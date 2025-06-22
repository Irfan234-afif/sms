<template>
    <div class="flex flex-col bg-white rounded-lg shadow-xl max-w-6xl mx-auto h-[80vh]">
        <!-- Modal Header -->
        <div class="px-6 py-4 border-b border-gray-200">
            <div class="flex items-center justify-between">
                <h3 class="text-lg font-medium text-gray-900">
                    {{ propertyModal.mode === 'edit' ? 'Edit Kuis' : 'Tambah Kuis Baru' }}
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
            <div class="space-y-6">
                <!-- Basic Quiz Information -->
                <div class="bg-gray-50 rounded-lg p-4">
                    <h4 class="text-md font-medium text-gray-900 mb-4">Informasi Kuis</h4>
                    <div class="grid grid-cols-2 gap-4">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Judul Kuis</label>
                            <el-input 
                                v-model="localQuiz.title" 
                                placeholder="Masukkan judul kuis"
                                size="large"
                            />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Passing Score (%)</label>
                            <el-input-number 
                                v-model="localQuiz.passing_score" 
                                :min="0" 
                                :max="100" 
                                class="w-full"
                                size="large"
                            />
                        </div>
                        <div class="col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-2">Deskripsi</label>
                            <el-input 
                                v-model="localQuiz.description" 
                                type="textarea" 
                                :rows="3" 
                                placeholder="Deskripsi kuis..."
                            />
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                            <el-select 
                                v-model="localQuiz.status" 
                                class="w-full"
                                size="large"
                            >
                                <el-option label="Aktif" value="active" />
                                <el-option label="Nonaktif" value="inactive" />
                            </el-select>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-2">Durasi (menit)</label>
                            <el-input-number 
                                v-model="localQuiz.duration_minutes" 
                                :min="1" 
                                class="w-full"
                                size="large"
                                placeholder="30"
                            />
                        </div>
                    </div>
                </div>

                <!-- Questions Section -->
                <div>
                    <div class="flex items-center justify-between mb-4">
                        <h4 class="text-md font-medium text-gray-900">
                            Pertanyaan ({{ localQuiz.questions?.length || 0 }})
                        </h4>
                        <el-button type="primary" @click="addQuestion">
                            + Tambah Pertanyaan
                        </el-button>
                    </div>

                    <!-- Questions List -->
                    <div class="space-y-4">
                        <div v-for="(question, questionIndex) in localQuiz.questions" 
                             :key="questionIndex" 
                             class="border rounded-lg p-4 bg-white shadow-sm">
                            
                            <!-- Question Header -->
                            <div class="flex items-center justify-between mb-4">
                                <h5 class="font-medium text-gray-900">Pertanyaan {{ questionIndex + 1 }}</h5>
                                <div class="flex space-x-2">
                                    <el-button 
                                        type="primary" 
                                        plain 
                                        size="small"
                                        @click="duplicateQuestion(questionIndex)"
                                    >
                                        Duplikat
                                    </el-button>
                                    <el-button 
                                        type="danger" 
                                        plain 
                                        size="small" 
                                        @click="removeQuestion(questionIndex)"
                                    >
                                        Hapus
                                    </el-button>
                                </div>
                            </div>

                            <!-- Question Details -->
                            <div class="grid grid-cols-12 gap-4 mb-4">
                                <div class="col-span-8">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Teks Pertanyaan</label>
                                    <el-input 
                                        v-model="question.question" 
                                        type="textarea" 
                                        :rows="3" 
                                        placeholder="Masukkan pertanyaan..."
                                    />
                                </div>
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Tipe</label>
                                    <el-select 
                                        v-model="question.type" 
                                        class="w-full" 
                                        @change="handleQuestionTypeChange(question)"
                                    >
                                        <el-option label="Pilihan Ganda" value="multiple_choice" />
                                        <el-option label="Multiple Select" value="multiple_select" />
                                        <el-option label="Essay" value="essay" />
                                        <el-option label="Benar/Salah" value="true_false" />
                                    </el-select>
                                </div>
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Poin</label>
                                    <el-input-number 
                                        v-model="question.points" 
                                        :min="1" 
                                        class="w-full"
                                    />
                                </div>
                            </div>

                            <!-- Question Options/Answers -->
                            <div v-if="question.type === 'multiple_choice' || question.type === 'multiple_select'" 
                                 class="bg-gray-50 rounded-lg p-4 mb-4">
                                <div class="flex items-center justify-between mb-3">
                                    <h6 class="font-medium text-sm">Pilihan Jawaban</h6>
                                    <el-button type="primary" plain size="small" @click="addOption(question)">
                                        + Tambah Pilihan
                                    </el-button>
                                </div>
                                
                                <div class="space-y-3">
                                    <div v-for="(option, optionIndex) in question.options" 
                                         :key="optionIndex" 
                                         class="flex items-center gap-3 p-3 bg-white border rounded">
                                        <div class="flex-shrink-0">
                                            <el-checkbox 
                                                v-if="question.type === 'multiple_select'" 
                                                v-model="option.is_correct" 
                                            />
                                            <el-radio 
                                                v-else 
                                                :value="optionIndex"
                                                :model-value="getSelectedRadioValue(question)"
                                                @change="handleRadioChange(question, optionIndex)"
                                                :name="`question_${questionIndex}_${optionIndex}`" 
                                            />
                                        </div>
                                        <div class="flex-1">
                                            <el-input 
                                                v-model="option.option_text" 
                                                placeholder="Teks pilihan"
                                            />
                                        </div>
                                        <div class="flex-shrink-0">
                                            <el-input 
                                                v-model="option.explanation" 
                                                placeholder="Penjelasan (opsional)"
                                                class="w-48"
                                            />
                                        </div>
                                        <div class="flex-shrink-0">
                                            <el-button 
                                                type="danger" 
                                                plain 
                                                size="small" 
                                                @click="removeOption(question, optionIndex)"
                                            >
                                                ×
                                            </el-button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Essay Answer -->
                            <div v-else-if="question.type === 'essay'" class="bg-gray-50 rounded-lg p-4 mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Model Jawaban (Opsional)</label>
                                <el-input 
                                    v-model="question.correct_answer" 
                                    type="textarea" 
                                    :rows="4" 
                                    placeholder="Masukkan model jawaban untuk referensi penilaian..."
                                />
                            </div>

                            <!-- True/False Answer -->
                            <div v-else-if="question.type === 'true_false'" class="bg-gray-50 rounded-lg p-4 mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Jawaban yang Benar</label>
                                <el-select v-model="question.correct_answer" class="w-full">
                                    <el-option label="Benar" value="true" />
                                    <el-option label="Salah" value="false" />
                                </el-select>
                            </div>

                            <!-- Question Explanation -->
                            <div class="mt-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Penjelasan (Opsional)</label>
                                <el-input 
                                    v-model="question.explanation" 
                                    type="textarea" 
                                    :rows="2" 
                                    placeholder="Penjelasan jawaban..."
                                />
                            </div>
                        </div>
                    </div>

                    <!-- Empty State for Questions -->
                    <div v-if="!localQuiz.questions || localQuiz.questions.length === 0" 
                         class="text-center py-8 border-2 border-dashed border-gray-300 rounded-lg">
                        <svg class="mx-auto h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                  d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z">
                            </path>
                        </svg>
                        <h3 class="mt-2 text-sm font-medium text-gray-900">Belum ada pertanyaan</h3>
                        <p class="mt-1 text-sm text-gray-500">Tambahkan pertanyaan pertama untuk kuis ini.</p>
                        <el-button type="primary" class="mt-4" @click="addQuestion">
                            Tambah Pertanyaan
                        </el-button>
                    </div>
                </div>
            </div>
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
                    Hapus Kuis
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

const emit = defineEmits(['close', 'update:quiz', 'remove']);

// Helper functions
function newOption() {
    return {
        option_text: '',
        is_correct: false,
        order: 1,
        explanation: ''
    };
}

function newQuestion() {
    return {
        question: '',
        type: 'multiple_choice',
        points: 1,
        explanation: '',
        order: 1,
        status: 'active',
        options: [
            { ...newOption(), order: 1 },
            { ...newOption(), order: 2 }
        ],
        correct_answer: '',
        error: null
    };
}

// Local state
const localQuiz = ref({
    title: '',
    description: '',
    passing_score: 70,
    status: 'active',
    duration_minutes: 30,
    questions: [],
    ...props.propertyModal.data
});

// Question management
const addQuestion = () => {
    if (!localQuiz.value.questions) {
        localQuiz.value.questions = [];
    }
    const maxOrder = localQuiz.value.questions.reduce((max, q) => Math.max(max, q.order || 0), 0);
    const newQuestionData = {
        ...newQuestion(),
        order: maxOrder + 1
    };
    localQuiz.value.questions.push(newQuestionData);
};

const removeQuestion = (questionIndex) => {
    if (localQuiz.value.questions && localQuiz.value.questions.length > questionIndex) {
        localQuiz.value.questions.splice(questionIndex, 1);
        // Reorder remaining questions
        localQuiz.value.questions.forEach((question, idx) => {
            question.order = idx + 1;
        });
    }
};

const duplicateQuestion = (questionIndex) => {
    const originalQuestion = localQuiz.value.questions[questionIndex];
    const duplicatedQuestion = {
        ...JSON.parse(JSON.stringify(originalQuestion)), // Deep copy
        order: localQuiz.value.questions.length + 1
    };
    localQuiz.value.questions.push(duplicatedQuestion);
};

const handleQuestionTypeChange = (question) => {
    // Reset question-specific data when type changes
    if (question.type === 'multiple_choice' || question.type === 'multiple_select') {
        if (!question.options || question.options.length === 0) {
            question.options = [
                { ...newOption(), order: 1 },
                { ...newOption(), order: 2 }
            ];
        } else {
            // Reset all is_correct values when switching between choice types
            question.options.forEach(option => {
                option.is_correct = false;
            });
        }
        question.correct_answer = '';
    } else {
        question.options = [];
        if (question.type === 'true_false') {
            question.correct_answer = 'true';
        } else {
            question.correct_answer = '';
        }
    }
};

// Option management
const addOption = (question) => {
    if (!question.options) {
        question.options = [];
    }
    const maxOrder = question.options.reduce((max, opt) => Math.max(max, opt.order || 0), 0);
    question.options.push({
        ...newOption(),
        order: maxOrder + 1
    });
};

const removeOption = (question, optionIndex) => {
    if (question.options && question.options.length > optionIndex && question.options.length > 1) {
        question.options.splice(optionIndex, 1);
        // Reorder remaining options
        question.options.forEach((option, idx) => {
            option.order = idx + 1;
        });
    }
};

const handleSingleCorrect = (question, selectedIndex) => {
    // For single choice, only one option can be correct
    question.options.forEach((option, index) => {
        option.is_correct = (index === selectedIndex);
    });
};

// Helper function to get selected option index for radio buttons
const getSelectedRadioValue = (question) => {
    const selectedIndex = question.options.findIndex(option => option.is_correct);
    return selectedIndex >= 0 ? selectedIndex : null;
};

// Handle radio button change
const handleRadioChange = (question, selectedIndex) => {
    handleSingleCorrect(question, selectedIndex);
};

// Handle form submission
const handleSubmit = () => {
    // Validation
    if (!localQuiz.value.title.trim()) {
        ElNotification({
            title: 'Error',
            message: 'Judul kuis wajib diisi',
            type: 'error'
        });
        return;
    }

    if (!localQuiz.value.questions || localQuiz.value.questions.length === 0) {
        ElNotification({
            title: 'Error',
            message: 'Kuis harus memiliki minimal 1 pertanyaan',
            type: 'error'
        });
        return;
    }

    // Validate questions
    for (let i = 0; i < localQuiz.value.questions.length; i++) {
        const question = localQuiz.value.questions[i];
        
        if (!question.question.trim()) {
            ElNotification({
                title: 'Error',
                message: `Pertanyaan ${i + 1} wajib diisi`,
                type: 'error'
            });
            return;
        }

        if (question.type === 'multiple_choice' || question.type === 'multiple_select') {
            if (!question.options || question.options.length < 2) {
                ElNotification({
                    title: 'Error',
                    message: `Pertanyaan ${i + 1} harus memiliki minimal 2 pilihan`,
                    type: 'error'
                });
                return;
            }

            const hasCorrectAnswer = question.options.some(option => option.is_correct);
            if (!hasCorrectAnswer) {
                ElNotification({
                    title: 'Error',
                    message: `Pertanyaan ${i + 1} harus memiliki jawaban yang benar`,
                    type: 'error'
                });
                return;
            }
        }
    }

    // Emit update
    emit('update:quiz', { ...localQuiz.value });
    
    ElNotification({
        title: 'Sukses',
        message: `Kuis berhasil ${props.propertyModal.mode === 'edit' ? 'diperbarui' : 'ditambahkan'}`,
        type: 'success'
    });
};

// Handle remove
const handleRemove = () => {
    emit('remove');
    ElNotification({
        title: 'Sukses',
        message: 'Kuis berhasil dihapus',
        type: 'success'
    });
};

// Watch for data changes
watch(() => props.propertyModal.data, (newData) => {
    if (newData) {
        localQuiz.value = {
            title: '',
            description: '',
            passing_score: 70,
            status: 'active',
            duration_minutes: 30,
            questions: [],
            ...newData
        };
    }
}, { immediate: true, deep: true });
</script> 