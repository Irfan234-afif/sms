<?php

namespace App\Http\Controllers\Office\ICC\Publication;

use App\Http\Controllers\Controller;
use App\Http\Resources\FaqResource;
use App\Http\Resources\GalleryResource;
use App\Models\Gallery;
use App\Models\GalleryItem;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Inertia\Inertia;
use Ramsey\Uuid\Uuid;

class GalleryController extends Controller
{
    public function index()
    {
        $galleries = Gallery::query();

        if (request()->has('search')) {
            $galleries->where('title', 'like', '%' . request('search') . '%');
        }

        $galleries = $galleries->with('items')
            ->latest()
            ->paginate(15);

        $data = [
            'search_params' => [
                'search' => request('search'),
            ],
            'galleries' => GalleryResource::collection($galleries)
        ];

        return Inertia::render('Office/ICC/Publication/Gallery/Index', $data);
    }

    public function save()
    {
        DB::beginTransaction();

        try {
            $gallery = Gallery::where('uuid', request('gallery_id'))->first();

            $gallery_created = Gallery::updateOrCreate(
                [
                    'id' => $gallery ? $gallery->id : null
                ],
                [
                    'title' => request('title'),
                    'slug' => Str::slug(request('title') . '-' . Uuid::uuid1()),
                    'description' => request('description'),
                    'status' => 'PUBLISHED',
                ]
            );

            $uploadedImages = request()->file('images', []);
            $thumbnailIndex = request('thumbnail');

            // Mengambil UUID gambar yang sudah ada dari request
            $existingImageUUIDs = array_map(fn($img) => $img['uuid'] ?? null, request('images', []));
            $existingImageUUIDs = array_filter($existingImageUUIDs); // Hapus null values

            if (!empty($uploadedImages)) {
                foreach ($uploadedImages as $key => $imageFile) {
                    if ($imageFile['file']->isValid()) {
                        $galleryItemId = request("images.$key.uuid");

                        $filename = 'gallery_' . time() . '_' . uniqid() . '.' . $imageFile['file']->getClientOriginalExtension();

                        $imageFile['file']->storeAs('galleries', $filename, 'public');

                        if ($galleryItemId) {
                            $oldImage = GalleryItem::where('uuid', $galleryItemId)->first();

                            if ($oldImage) {
                                // Hapus gambar lama jika berbeda dengan yang baru di-upload
                                if ($oldImage->image !== $filename) {
                                    Storage::disk('public')->delete('galleries/' . $oldImage->image);
                                }

                                $oldImage->update([
                                    'image' => $filename,
                                ]);
                            }
                        } else {
                            $gallery_item_created = $gallery_created->items()->create([
                                'image' => $filename,
                            ]);

                            array_push($existingImageUUIDs, $gallery_item_created->uuid);
                        }
                    }
                }
            }

            foreach ($existingImageUUIDs as $key => $uuid) {
                GalleryItem::where('uuid', $uuid)->update([
                    'is_thumbnail' => $thumbnailIndex !== null && $thumbnailIndex == $key,
                ]);
            }

            // Hapus gambar lama yang tidak ada dalam daftar UUID yang masih digunakan
            $oldGalleryItems = $gallery_created->items()->whereNotIn('uuid', $existingImageUUIDs)->get();
            foreach ($oldGalleryItems as $oldItem) {
                Storage::disk('public')->delete('galleries/' . $oldItem->image);
                $oldItem->delete();
            }

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Galeri berhasil disimpan.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }


    public function delete()
    {
        DB::beginTransaction();

        try {
            $gallery = Gallery::where('uuid', request('gallery_id'))->firstOrFail();

            $gallery->delete();

            DB::commit();

            return response()->json([
                'status' => 'success',
                'message' => 'Galeri berhasil dihapus.',
            ], 200);
        } catch (\Throwable $th) {
            DB::rollBack();

            return response()->json([
                'status' => 'error',
                'message' => $th->getMessage(),
            ], 500);
        }
    }
}
