<template>
    <div class="flex flex-col bg-white rounded-lg shadow-xl max-w-6xl mx-auto h-[80vh]">
        <!-- Modal Header -->
        <div class="px-6 py-4 border-b border-gray-200">
            <div class="flex items-center justify-between">
                <h3 class="text-lg font-medium text-gray-900">
                    {{ propertyModal.mode === 'edit' ? 'Edit Materi' : 'Tambah Materi Baru' }}
                </h3>
                <button @click="$emit('close')" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                </button>
            </div>
        </div>

        <!-- Modal Body -->
        <div class="px-6 py-4 h-full overflow-y-auto">
            <form @submit.prevent="handleSubmit" class="space-y-6">
                <!-- Basic Information -->
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Judul Materi</label>
                        <el-input 
                            v-model="localMaterial.title" 
                            placeholder="Masukkan judul materi"
                            size="large"
                        />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Tipe Materi</label>
                        <el-select 
                            v-model="localMaterial.type" 
                            class="w-full"
                            size="large"
                            @change="handleTypeChange"
                        >
                            <el-option label="Teks" value="text" />
                            <el-option label="Link/URL" value="link" />
                            <el-option label="Video" value="video" />
                            <el-option label="Dokumen" value="document" />
                        </el-select>
                    </div>
                </div>

                <!-- Content Section -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Konten</label>
                    <div v-if="localMaterial.type === 'text'">
                        <el-input 
                            v-model="localMaterial.content" 
                            type="textarea" 
                            :rows="8" 
                            placeholder="Masukkan konten materi pembelajaran..."
                            resize="vertical"
                        />
                        <p class="text-xs text-gray-500 mt-1">Anda dapat menggunakan format HTML untuk pemformatan teks (contoh: &lt;h3&gt;, &lt;p&gt;, &lt;strong&gt;, &lt;ul&gt;, dll).</p>
                    </div>
                    <div v-else-if="localMaterial.type === 'link'">
                        <el-input 
                            v-model="localMaterial.content" 
                            placeholder="https://example.com/link-materi"
                            size="large"
                        />
                        <p class="text-xs text-gray-500 mt-1">Masukkan URL link materi yang valid.</p>
                    </div>
                    <div v-else-if="localMaterial.type === 'video'">
                        <el-input 
                            v-model="localMaterial.content" 
                            placeholder="https://youtube.com/watch?v=... atau URL video lainnya"
                            size="large"
                        />
                        <p class="text-xs text-gray-500 mt-1">Masukkan URL video dari YouTube, Vimeo, atau platform lainnya.</p>
                    </div>
                    <div v-else-if="localMaterial.type === 'document'">
                        <el-input 
                            v-model="localMaterial.content" 
                            placeholder="URL dokumen atau path file"
                            size="large"
                        />
                        <p class="text-xs text-gray-500 mt-1">Masukkan URL dokumen (Google Docs, PDF, dll) atau path file.</p>
                    </div>
                </div>

                <!-- File Path (if needed) -->
                <div v-if="localMaterial.type === 'document'">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Path File (Opsional)</label>
                    <el-input 
                        v-model="localMaterial.file_path" 
                        placeholder="/path/to/document.pdf"
                        size="large"
                    />
                    <p class="text-xs text-gray-500 mt-1">Path file jika dokumen disimpan di server lokal.</p>
                </div>

                <!-- Advanced Settings -->
                <div class="grid grid-cols-3 gap-4">
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Urutan</label>
                        <el-input-number 
                            v-model="localMaterial.order" 
                            :min="1" 
                            class="w-full"
                            size="large"
                        />
                    </div>
                    <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                        <el-select 
                            v-model="localMaterial.status" 
                            class="w-full"
                            size="large"
                        >
                            <el-option label="Aktif" value="active" />
                            <el-option label="Nonaktif" value="inactive" />
                        </el-select>
                    </div>
                    <!-- <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">Durasi Estimasi (menit)</label>
                        <el-input-number 
                            v-model="localMaterial.estimated_duration" 
                            :min="1" 
                            class="w-full"
                            size="large"
                            placeholder="30"
                        />
                    </div> -->
                </div>

                <!-- Preview Section -->
                <div v-if="localMaterial.content" class="border rounded-lg p-4 bg-gray-50">
                    <h4 class="text-sm font-medium text-gray-700 mb-3">Preview</h4>
                    
                    <!-- Text Content Preview with HTML rendering -->
                    <div v-if="localMaterial.type === 'text'" class="max-h-64 overflow-y-auto">
                        <div class="prose max-w-none" v-html="localMaterial.content"></div>
                    </div>
                    
                    <!-- Link Preview -->
                    <div v-else-if="localMaterial.type === 'link'" class="space-y-2">
                        <div class="flex items-center space-x-2">
                            <svg class="h-4 w-4 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                            </svg>
                            <span class="text-sm font-medium text-gray-700">Tautan Eksternal</span>
                        </div>
                        <a :href="localMaterial.content" target="_blank" class="text-blue-600 hover:text-blue-800 text-sm break-all">
                            {{ localMaterial.content }}
                        </a>
                    </div>
                    
                    <!-- Video Preview -->
                    <div v-else-if="localMaterial.type === 'video'" class="space-y-2">
                        <div class="flex items-center space-x-2">
                            <svg class="h-4 w-4 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h1.586a1 1 0 01.707.293l2.414 2.414a1 1 0 00.707.293H15M9 10V9a2 2 0 012-2h2a2 2 0 012 2v1M9 10v4a2 2 0 002 2h2a2 2 0 002-2v-4"></path>
                            </svg>
                            <span class="text-sm font-medium text-gray-700">Video Content</span>
                        </div>
                        <a :href="localMaterial.content" target="_blank" class="text-blue-600 hover:text-blue-800 text-sm break-all">
                            {{ localMaterial.content }}
                        </a>
                        <!-- YouTube/Vimeo embed preview if it's a supported URL -->
                        <div v-if="isYouTubeURL(localMaterial.content) || isVimeoURL(localMaterial.content)" class="mt-2">
                            <div class="text-xs text-gray-500 mb-1">Preview:</div>
                            <div class="aspect-video max-w-sm bg-gray-200 rounded border flex items-center justify-center">
                                <svg class="h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.828 14.828a4 4 0 01-5.656 0M9 10h1.586a1 1 0 01.707.293l2.414 2.414a1 1 0 00.707.293H15M9 10V9a2 2 0 012-2h2a2 2 0 012 2v1M9 10v4a2 2 0 002 2h2a2 2 0 002-2v-4"></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Document Preview -->
                    <div v-else-if="localMaterial.type === 'document'" class="space-y-2">
                        <div class="flex items-center space-x-2">
                            <svg class="h-4 w-4 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <span class="text-sm font-medium text-gray-700">Dokumen</span>
                        </div>
                        <a :href="localMaterial.content" target="_blank" class="text-blue-600 hover:text-blue-800 text-sm break-all">
                            {{ localMaterial.content }}
                        </a>
                        <div v-if="localMaterial.file_path" class="text-xs text-gray-500">
                            Path: {{ localMaterial.file_path }}
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <!-- Modal Footer -->
        <div class="px-6 py-4 border-t border-gray-200 flex justify-between">
            <div>
                <el-button 
                    v-if="propertyModal.mode === 'edit'"
                    type="danger" 
                    plain 
                    @click="handleRemove"
                >
                    Hapus Materi
                </el-button>
            </div>
            <div class="flex space-x-3">
                <el-button @click="$emit('close')">
                    Batal
                </el-button>
                <el-button type="primary" @click="handleSubmit">
                    {{ propertyModal.mode === 'edit' ? 'Update' : 'Simpan' }}
                </el-button>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, computed, watch } from 'vue';
import { ElNotification } from 'element-plus';

const props = defineProps({
    propertyModal: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['close', 'update:material', 'remove']);

// Local state
const localMaterial = ref({
    title: '',
    type: 'text',
    content: '',
    file_path: '',
    order: 1,
    status: 'active',
    estimated_duration: null,
    ...props.propertyModal.data
});

// Handle type change
const handleTypeChange = () => {
    // Reset content when type changes
    localMaterial.value.content = '';
    localMaterial.value.file_path = '';
};

// Helper functions for URL detection
const isYouTubeURL = (url) => {
    if (!url) return false;
    return /(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})/i.test(url);
};

const isVimeoURL = (url) => {
    if (!url) return false;
    return /(?:vimeo)\.com.*(?:videos|video|channels|)\/([\d]+)/i.test(url);
};

// Handle form submission
const handleSubmit = () => {
    // Validation
    if (!localMaterial.value.title.trim()) {
        ElNotification({
            title: 'Error',
            message: 'Judul materi wajib diisi',
            type: 'error'
        });
        return;
    }

    if (!localMaterial.value.content.trim()) {
        ElNotification({
            title: 'Error',
            message: 'Konten materi wajib diisi',
            type: 'error'
        });
        return;
    }

    // Emit update
    emit('update:material', { ...localMaterial.value });
    
    ElNotification({
        title: 'Sukses',
        message: `Materi berhasil ${props.propertyModal.mode === 'edit' ? 'diperbarui' : 'ditambahkan'}`,
        type: 'success'
    });
};

// Handle remove
const handleRemove = () => {
    emit('remove');
    ElNotification({
        title: 'Sukses',
        message: 'Materi berhasil dihapus',
        type: 'success'
    });
};

// Watch for data changes
watch(() => props.propertyModal.data, (newData) => {
    if (newData) {
        localMaterial.value = {
            title: '',
            type: 'text',
            content: '',
            file_path: '',
            order: 1,
            status: 'active',
            estimated_duration: null,
            ...newData
        };
    }
}, { immediate: true, deep: true });
</script> 