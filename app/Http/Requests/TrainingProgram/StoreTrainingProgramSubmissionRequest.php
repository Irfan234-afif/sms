<?php

namespace App\Http\Requests\TrainingProgram;

use Illuminate\Foundation\Http\FormRequest;

class StoreTrainingProgramSubmissionRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            // Main submission fields
            'training_type' => 'required|in:internal,external',
            'training_program_id' => 'nullable|required_if:training_type,internal|exists:training_programs,id',
            'external_training_title' => 'nullable|required_if:training_type,external|string|max:255',
            'external_training_provider' => 'nullable|required_if:training_type,external|string|max:255',
            'external_training_location' => 'nullable|string|max:255',
            'external_training_method' => 'nullable|string|max:255',
            'external_training_description' => 'nullable|string',
            'start_date' => 'nullable|required_if:training_type,external|date',
            'end_date' => 'nullable|required_if:training_type,external|date|after_or_equal:start_date',
            'daily_start_time' => 'nullable|required_if:training_type,external|date_format:H:i',
            'daily_end_time' => 'nullable|required_if:training_type,external|date_format:H:i|after:daily_start_time',
            'training_days' => 'nullable|array',
            'justification' => 'nullable|string',
            'expected_outcomes' => 'nullable|string',

            // Goals validation
            'goals' => 'sometimes|array|min:1',
            'goals.*.goal_type' => 'required|in:knowledge,skill,attitude',
            'goals.*.description' => 'required|string|max:500',
            'goals.*.success_indicator' => 'required|string|max:500',
            'goals.*.order' => 'required|integer|min:1',

            // Budget items validation
            'budget_items' => 'sometimes|array|min:1',
            'budget_items.*.category' => 'required|in:venue,instructor_fee,material,equipment,transportation,accommodation,meal,certification,other',
            'budget_items.*.item_name' => 'required|string|max:255',
            'budget_items.*.description' => 'nullable|string|max:255',
            'budget_items.*.quantity' => 'required|numeric|min:1',
            'budget_items.*.unit_price' => 'required|numeric|min:0',

            // Participants validation - Updated for polymorphic
            'participants' => 'required|array|min:1',
            'participants.*.participant_type' => 'required|in:employee,student,student_guardian',
            'participants.*.participant_id' => [
                'required',
                'integer',
                function ($attribute, $value, $fail) {
                    $index = explode('.', $attribute)[1];
                    $type = $this->input("participants.{$index}.participant_type");
                    
                    $exists = match($type) {
                        'employee' => \App\Models\Employee::where('id', $value)->exists(),
                        'student' => \App\Models\Student::where('id', $value)->exists(),
                        'student_guardian' => \App\Models\StudentGuardian::where('id', $value)->exists(),
                        default => false,
                    };
                    
                    if (!$exists) {
                        $fail('Peserta yang dipilih tidak valid');
                    }
                },
            ],
            'participants.*.is_primary_participant' => 'sometimes|boolean',
            'participants.*.role_description' => 'nullable|string|max:255',
            'participants.*.selection_reason' => 'nullable|string|max:500',

            // Attachments validation
            'attachments' => 'sometimes|array',
            'attachments.*.attachment_type' => 'required|in:proposal,brochure,curriculum,quotation,agreement,other',
            'attachments.*.description' => 'nullable|string|max:255',
            'attachments.*.file' => 'required|file|mimes:pdf,doc,docx,jpg,jpeg,png|max:10240', // 10MB max
        ];
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            // Main submission messages
            'submission_id.exists' => 'Submission yang dipilih tidak valid',
            'training_type.required' => 'Tipe training wajib dipilih',
            'training_type.in' => 'Tipe training tidak valid',
            'training_program_id.required_if' => 'Program training wajib dipilih untuk tipe internal',
            'training_program_id.exists' => 'Program training yang dipilih tidak valid',
            'external_training_title.required_if' => 'Judul training wajib diisi untuk tipe external',
            'external_training_title.max' => 'Judul training maksimal 255 karakter',
            'external_training_provider.required_if' => 'Provider wajib diisi untuk tipe external',
            'external_training_provider.max' => 'Provider maksimal 255 karakter',
            'external_training_location.max' => 'Lokasi maksimal 255 karakter',
            'external_training_method.max' => 'Metode maksimal 255 karakter',
            'start_date.required' => 'Tanggal mulai wajib diisi',
            'start_date.date' => 'Format tanggal mulai tidak valid',
            'end_date.required' => 'Tanggal selesai wajib diisi',
            'end_date.date' => 'Format tanggal selesai tidak valid',
            'end_date.after_or_equal' => 'Tanggal selesai harus sama atau setelah tanggal mulai',
            'daily_start_time.required' => 'Waktu mulai harian wajib diisi',
            'daily_start_time.date_format' => 'Format waktu mulai tidak valid (HH:MM)',
            'daily_end_time.required' => 'Waktu selesai harian wajib diisi',
            'daily_end_time.date_format' => 'Format waktu selesai tidak valid (HH:MM)',
            'daily_end_time.after' => 'Waktu selesai harus setelah waktu mulai',
            'training_days.array' => 'Hari training harus berupa array',

            // Goals messages
            'goals.array' => 'Tujuan harus berupa array',
            'goals.min' => 'Minimal 1 tujuan harus diisi',
            'goals.*.goal_type.required' => 'Tipe tujuan wajib dipilih',
            'goals.*.goal_type.in' => 'Tipe tujuan tidak valid',
            'goals.*.description.required' => 'Deskripsi tujuan wajib diisi',
            'goals.*.description.max' => 'Deskripsi tujuan maksimal 500 karakter',
            'goals.*.success_indicator.required' => 'Indikator keberhasilan wajib diisi',
            'goals.*.success_indicator.max' => 'Indikator keberhasilan maksimal 500 karakter',
            'goals.*.order.required' => 'Urutan tujuan wajib diisi',
            'goals.*.order.integer' => 'Urutan tujuan harus berupa angka',
            'goals.*.order.min' => 'Urutan tujuan minimal 1',

            // Budget items messages
            'budget_items.array' => 'Item budget harus berupa array',
            'budget_items.min' => 'Minimal 1 item budget harus diisi',
            'budget_items.*.category.required' => 'Kategori budget wajib dipilih',
            'budget_items.*.category.in' => 'Kategori budget tidak valid',
            'budget_items.*.item_name.required' => 'Nama item budget wajib diisi',
            'budget_items.*.item_name.max' => 'Nama item budget maksimal 255 karakter',
            'budget_items.*.description.max' => 'Deskripsi item budget maksimal 255 karakter',
            'budget_items.*.quantity.required' => 'Kuantitas wajib diisi',
            'budget_items.*.quantity.numeric' => 'Kuantitas harus berupa angka',
            'budget_items.*.quantity.min' => 'Kuantitas minimal 1',
            'budget_items.*.unit_price.required' => 'Harga satuan wajib diisi',
            'budget_items.*.unit_price.numeric' => 'Harga satuan harus berupa angka',
            'budget_items.*.unit_price.min' => 'Harga satuan minimal 0',

            // Participants messages
            'participants.required' => 'Peserta wajib diisi',
            'participants.array' => 'Peserta harus berupa array',
            'participants.min' => 'Minimal 1 peserta harus dipilih',
            'participants.*.participant_type.required' => 'Tipe peserta wajib dipilih',
            'participants.*.participant_type.in' => 'Tipe peserta tidak valid',
            'participants.*.participant_id.required' => 'Peserta wajib dipilih',
            'participants.*.participant_id.integer' => 'Peserta harus berupa angka',
            'participants.*.is_primary_participant.boolean' => 'Status peserta utama harus berupa boolean',
            'participants.*.role_description.max' => 'Deskripsi peran maksimal 255 karakter',
            'participants.*.selection_reason.max' => 'Alasan pemilihan maksimal 500 karakter',

            // Attachments messages
            'attachments.array' => 'Lampiran harus berupa array',
            'attachments.*.attachment_type.required' => 'Tipe lampiran wajib dipilih',
            'attachments.*.attachment_type.in' => 'Tipe lampiran tidak valid',
            'attachments.*.description.max' => 'Deskripsi lampiran maksimal 255 karakter',
            'attachments.*.file.required' => 'File lampiran wajib diupload',
            'attachments.*.file.file' => 'Lampiran harus berupa file',
            'attachments.*.file.mimes' => 'File lampiran harus berformat: pdf, doc, docx, jpg, jpeg, png',
            'attachments.*.file.max' => 'Ukuran file lampiran maksimal 10MB',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            // Main submission attributes
            'submission_id' => 'Submission',
            'training_type' => 'Tipe Training',
            'training_program_id' => 'Program Training',
            'external_training_title' => 'Judul Training External',
            'external_training_provider' => 'Provider External',
            'external_training_location' => 'Lokasi External',
            'external_training_method' => 'Metode External',
            'external_training_description' => 'Deskripsi External',
            'start_date' => 'Tanggal Mulai',
            'end_date' => 'Tanggal Selesai',
            'daily_start_time' => 'Waktu Mulai Harian',
            'daily_end_time' => 'Waktu Selesai Harian',
            'training_days' => 'Hari Training',
            'justification' => 'Justifikasi',
            'expected_outcomes' => 'Hasil yang Diharapkan',

            // Goals attributes
            'goals.*.goal_type' => 'Tipe Tujuan',
            'goals.*.description' => 'Deskripsi Tujuan',
            'goals.*.success_indicator' => 'Indikator Keberhasilan',
            'goals.*.order' => 'Urutan Tujuan',

            // Budget items attributes
            'budget_items.*.category' => 'Kategori Budget',
            'budget_items.*.item_name' => 'Nama Item Budget',
            'budget_items.*.description' => 'Deskripsi Item Budget',
            'budget_items.*.quantity' => 'Kuantitas',
            'budget_items.*.unit_price' => 'Harga Satuan',

            // Participants attributes
            'participants.*.participant_type' => 'Tipe Peserta',
            'participants.*.participant_id' => 'Peserta',
            'participants.*.is_primary_participant' => 'Peserta Utama',
            'participants.*.role_description' => 'Deskripsi Peran',
            'participants.*.selection_reason' => 'Alasan Pemilihan',

            // Attachments attributes
            'attachments.*.attachment_type' => 'Tipe Lampiran',
            'attachments.*.description' => 'Deskripsi Lampiran',
            'attachments.*.file' => 'File Lampiran',
        ];
    }

    /**
     * Handle a passed validation attempt.
     */
    protected function passedValidation()
    {
        // Ensure at least one primary participant
        $participants = $this->input('participants', []);
        $primaryCount = collect($participants)->where('is_primary_participant', true)->count();
        
        if ($primaryCount === 0) {
            // Set first participant as primary if none selected
            $participants[0]['is_primary_participant'] = true;
            $this->merge(['participants' => $participants]);
        } elseif ($primaryCount > 1) {
            // Ensure only one primary participant
            $firstPrimaryIndex = collect($participants)->search(function ($participant) {
                return $participant['is_primary_participant'] === true;
            });
            
            foreach ($participants as $index => $participant) {
                $participants[$index]['is_primary_participant'] = ($index === $firstPrimaryIndex);
            }
            
            $this->merge(['participants' => $participants]);
        }
    }
} 