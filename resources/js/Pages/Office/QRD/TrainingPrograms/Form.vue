<script setup>
import { ElNotification } from 'element-plus';
import { useForm, router } from '@inertiajs/vue3';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Modal from '@/Components/Modal.vue';
import AssessmentModalContent from './AssessmentModalContent.vue';
import QuizModalContent from './QuizModalContent.vue';
import MaterialModalContent from './MaterialModalContent.vue';
import { ref, computed, onMounted } from 'vue';

const props = defineProps({
    program: {
        type: Object,
        default: null
    },
    phases: {
        type: Array,
        default: () => []
    }
});

const isEditMode = computed(() => !!props.program);

const breadcrumbs = computed(() => {
    const base = [
        { label: 'Yayasan', href: route('office') },
        { label: 'QRD', href: route('office.qrd') },
        { label: 'Program Pelatihan', href: route('office.qrd.manage.training-program.index') }
    ];
    
    if (isEditMode.value) {
        base.push({ label: 'Edit', href: route('office.qrd.manage.training-program.edit', props.program.uuid) });
    } else {
        base.push({ label: 'Buat Baru', href: route('office.qrd.manage.training-program.create') });
    }
    
    return base;
});

// Helper functions for creating new items (defined first to avoid hoisting issues)
function newMaterial() {
    return {
        title: '',
        type: 'text',
        content: '',
        file_path: '',
        order: 1,
        status: 'active',
        error: null
    };
}

function newQuiz() {
    return {
        title: '',
        description: '',
        passing_score: 70,
        status: 'active',
        questions: [],
        error: null
    };
}

function newQuestion() {
    return {
        question: '', // Using 'question' to match model field
        type: 'multiple_choice', // multiple_choice, multiple_select, essay, true_false
        points: 1,
        explanation: '',
        order: 1,
        status: 'active',
        options: [
            { ...newOption(), order: 1 },
            { ...newOption(), order: 2 }
        ], // For multiple choice/select - initialize with 2 options
        correct_answer: '', // For essay/true_false
        error: null
    };
}

function newOption() {
    return {
        option_text: '',
        is_correct: false,
        order: 1,
        explanation: ''
    };
}

function newAssessment() {
    return {
        title: '',
        description: '',
        calculation_method: 'AVERAGE',
        passing_score: 70,
        status: 'active',
        group_indicators: [],
        error: null
    };
}

function newModule() {
    const quiz = newQuiz();
    quiz.questions = []; // Start with empty questions array for initial module
    
    return {
        name: '',
        description: '',
        order: 1,
        status: 'active',
        materials: [newMaterial()],
        quizzes: [quiz],
        assessments: [newAssessment()],
        error: null
    };
}

function createNewPhase(existingPhases = []) {
    const maxOrder = existingPhases.reduce((max, phase) => Math.max(max, phase.order || 0), 0);
    return {
        name: '',
        description: '',
        order: maxOrder + 1,
        status: 'active',
        modules: [newModule()],
        error: null
    };
}

// Helper function to process phases data for form
const processPhaseData = (phases) => {
    if (!phases || phases.length === 0) {
        return [createNewPhase()];
    }
    
    return phases.map(phase => ({
        ...phase,
        modules: phase.modules?.map(module => ({
            ...module,
            materials: module.materials || [newMaterial()],
            quizzes: module.quizzes?.map(quiz => ({
                ...quiz,
                questions: quiz.questions?.map(question => ({
                    ...question,
                    // Map question field correctly
                    question: question.question || question.question_text || '',
                    options: question.options || []
                })) || []
            })) || [{ ...newQuiz(), questions: [] }],
            assessments: module.assessments || [newAssessment()]
        })) || [newModule()]
    }));
};

// Form state
const form = useForm({
    name: props.program?.name || '',
    type: props.program?.type || '',
    level: props.program?.level || '', 
    description: props.program?.description || '',
    status: props.program?.status || 'active',
    phases: processPhaseData(props.phases)
});

// Navigation state
const selectedPhase = ref(null);
const selectedModule = ref(null);
const selectedContentType = ref('materials'); // 'materials', 'quizzes', 'assessments'

// Modal state
const showAssessmentModal = ref(false);
const showMaterialModal = ref(false);
const showQuizModal = ref(false);
const modalProperty = ref({
    title: '',
    mode: '',
    maxWidth: '4xl',
    data: null,
    index: -1,
    module: null
});

// Form validation
const field = {
    name: {
        label: 'Nama Program',
        rules: [{ required: true, message: 'Nama Program wajib diisi', trigger: 'blur' }],
        error: null
    },
    type: {
        label: 'Tipe Program',
        rules: [{ required: true, message: 'Tipe Program wajib diisi', trigger: 'blur' }],
        error: null
    },
    level: {
        label: 'Level Program',
        rules: [{ required: true, message: 'Level Program wajib diisi', trigger: 'blur' }],
        error: null
    },
    description: {
        label: 'Deskripsi',
        rules: [],
        error: null
    },
    status: {
        label: 'Status',
        rules: [{ required: true, message: 'Status wajib dipilih', trigger: 'change' }],
        error: null,
        options: [
            { value: 'active', label: 'Aktif' },
            { value: 'inactive', label: 'Nonaktif' }
        ]
    }
};

// Navigation functions
const selectPhase = (phase) => {
    if (!phase) return;
    selectedPhase.value = phase;
    selectedModule.value = (phase?.modules?.length > 0) ? phase.modules[0] : null;
    selectedContentType.value = 'materials';
};

const selectModule = (module) => {
    if (!module) return;
    selectedModule.value = module;
    selectedContentType.value = 'materials';
};

// Phase management
const addPhase = () => {
    const newPhaseData = createNewPhase(form.phases);
    form.phases.push(newPhaseData);
    selectPhase(newPhaseData);
};

const removePhase = (phaseIndex) => {
    if (form.phases.length <= 1) return;
    
    const removedPhase = form.phases[phaseIndex];
    form.phases.splice(phaseIndex, 1);
    
    // Reorder remaining phases
    form.phases.forEach((phase, idx) => {
        phase.order = idx + 1;
    });
    
    // Update selection if removed phase was selected
    if (selectedPhase.value === removedPhase) {
        selectPhase(form.phases[0] || null);
    }
};

// Module management
const addModule = (phaseIndex) => {
    const phase = form.phases[phaseIndex];
    const maxOrder = phase.modules.reduce((max, module) => Math.max(max, module.order || 0), 0);
    
    const newModuleData = {
        ...newModule(),
        order: maxOrder + 1
    };
    
    phase.modules.push(newModuleData);
    selectModule(newModuleData);
};

const removeModule = (phaseIndex, moduleIndex) => {
    const phase = form.phases[phaseIndex];
    if (phase.modules.length <= 1) return;
    
    const removedModule = phase.modules[moduleIndex];
    phase.modules.splice(moduleIndex, 1);
    
    // Reorder remaining modules
    phase.modules.forEach((module, idx) => {
        module.order = idx + 1;
    });
    
    // Update selection if removed module was selected
    if (selectedModule.value === removedModule) {
        selectModule(phase.modules[0] || null);
    }
};

// Content management based on selected type
const currentContent = computed(() => {
    if (!selectedModule.value || !selectedContentType.value) return [];
    
    try {
        switch(selectedContentType.value) {
            case 'quizzes':
                return selectedModule.value.quizzes || [];
            case 'assessments':
                return selectedModule.value.assessments || [];
            default:
                return selectedModule.value.materials || [];
        }
    } catch (error) {
        console.error('Error in currentContent computed:', error);
        return [];
    }
});

const addContent = () => {
    if (!selectedModule.value || !selectedContentType.value) return;
    
    try {
        switch(selectedContentType.value) {
            case 'materials':
                if (!selectedModule.value.materials) selectedModule.value.materials = [];
                selectedModule.value.materials.push(newMaterial());
                break;
            case 'quizzes':
                if (!selectedModule.value.quizzes) selectedModule.value.quizzes = [];
                const quiz = newQuiz();
                // Initialize with one question
                quiz.questions = [{ ...newQuestion(), order: 1 }];
                selectedModule.value.quizzes.push(quiz);
                break;
            case 'assessments':
                if (!selectedModule.value.assessments) selectedModule.value.assessments = [];
                selectedModule.value.assessments.push(newAssessment());
                break;
        }
    } catch (error) {
        console.error('Error adding content:', error);
        ElNotification({
            title: 'Error',
            message: 'Gagal menambahkan konten',
            type: 'error'
        });
    }
};

const removeContent = (index) => {
    if (!selectedModule.value || !selectedContentType.value || index < 0) return;
    
    try {
        switch(selectedContentType.value) {
            case 'materials':
                if (selectedModule.value.materials && selectedModule.value.materials.length > index) {
                    selectedModule.value.materials.splice(index, 1);
                }
                break;
            case 'quizzes':
                if (selectedModule.value.quizzes && selectedModule.value.quizzes.length > index) {
                    selectedModule.value.quizzes.splice(index, 1);
                }
                break;
            case 'assessments':
                if (selectedModule.value.assessments && selectedModule.value.assessments.length > index) {
                    selectedModule.value.assessments.splice(index, 1);
                }
                break;
        }
    } catch (error) {
        console.error('Error removing content:', error);
        ElNotification({
            title: 'Error',
            message: 'Gagal menghapus konten',
            type: 'error'
        });
    }
};

// Assessment modal functions
const openAssessmentModal = (assessment, index) => {
    modalProperty.value = {
        title: assessment ? 'Edit Assessment' : 'New Assessment',
        mode: assessment ? 'edit' : 'create',
        maxWidth: '4xl',
        data: assessment || newAssessment(),
        index: index,
        module: selectedModule.value
    };
    showAssessmentModal.value = true;
};

const handleAssessmentUpdate = (updatedAssessment) => {
    if (modalProperty.value.mode === 'create') {
        selectedModule.value.assessments.push(updatedAssessment);
    } else {
        selectedModule.value.assessments[modalProperty.value.index] = updatedAssessment;
    }
    showAssessmentModal.value = false;
};

const handleAssessmentRemove = () => {
    if (modalProperty.value.mode === 'edit') {
        selectedModule.value.assessments.splice(modalProperty.value.index, 1);
    }
    showAssessmentModal.value = false;
};

// Material modal functions
const openMaterialModal = (material, index) => {
    modalProperty.value = {
        title: material ? 'Edit Materi' : 'New Material',
        mode: material ? 'edit' : 'create',
        maxWidth: '4xl',
        data: material || newMaterial(),
        index: index,
        module: selectedModule.value
    };
    showMaterialModal.value = true;
};

const handleMaterialUpdate = (updatedMaterial) => {
    if (modalProperty.value.mode === 'create') {
        selectedModule.value.materials.push(updatedMaterial);
    } else {
        selectedModule.value.materials[modalProperty.value.index] = updatedMaterial;
    }
    showMaterialModal.value = false;
};

const handleMaterialRemove = () => {
    if (modalProperty.value.mode === 'edit') {
        selectedModule.value.materials.splice(modalProperty.value.index, 1);
    }
    showMaterialModal.value = false;
};

// Quiz modal functions
const openQuizModal = (quiz, index) => {
    modalProperty.value = {
        title: quiz ? 'Edit Kuis' : 'New Quiz',
        mode: quiz ? 'edit' : 'create',
        maxWidth: '6xl',
        data: quiz || newQuiz(),
        index: index,
        module: selectedModule.value
    };
    showQuizModal.value = true;
};

const handleQuizUpdate = (updatedQuiz) => {
    if (modalProperty.value.mode === 'create') {
        selectedModule.value.quizzes.push(updatedQuiz);
    } else {
        selectedModule.value.quizzes[modalProperty.value.index] = updatedQuiz;
    }
    showQuizModal.value = false;
};

const handleQuizRemove = () => {
    if (modalProperty.value.mode === 'edit') {
        selectedModule.value.quizzes.splice(modalProperty.value.index, 1);
    }
    showQuizModal.value = false;
};

// Quiz question management
const addQuestion = (quiz) => {
    if (!quiz.questions) {
        quiz.questions = [];
    }
    const maxOrder = quiz.questions.reduce((max, q) => Math.max(max, q.order || 0), 0);
    const newQuestionData = {
        ...newQuestion(),
        order: maxOrder + 1
    };
    quiz.questions.push(newQuestionData);
};

const removeQuestion = (quiz, questionIndex) => {
    if (quiz.questions && quiz.questions.length > questionIndex) {
        quiz.questions.splice(questionIndex, 1);
        // Reorder remaining questions
        quiz.questions.forEach((question, idx) => {
            question.order = idx + 1;
        });
    }
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

// Quiz option management
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

// Form submission
const process = ref(false);

const handleCancel = () => {
    router.visit(route('office.qrd.manage.training-program.index'));
};

const submit = () => {
    process.value = true;
    
    try {
        const route_name = isEditMode.value 
            ? 'office.qrd.manage.training-program.update'
            : 'office.qrd.manage.training-program.store';
            
        const route_params = isEditMode.value ? [props.program?.uuid] : [];
        
        const method = isEditMode.value ? 'put' : 'post';
    
        form[method](route(route_name, ...route_params), {
            preserveScroll: true,
            onSuccess: () => {
                ElNotification({
                    title: 'Sukses',
                    message: `Program pelatihan berhasil ${isEditMode.value ? 'diperbarui' : 'dibuat'}`,
                    type: 'success'
                });
                router.visit(route('office.qrd.manage.training-program.index'));
            },
            onError: (errors) => {
                console.error('Form errors:', errors);
                ElNotification({
                    title: 'Error',
                    message: `Gagal ${isEditMode.value ? 'memperbarui' : 'membuat'} program pelatihan`,
                    type: 'error'
                });
            },
            onFinish: () => {
                process.value = false;
            }
        });
    } catch (error) {
        console.error('Submit error:', error);
        ElNotification({
            title: 'Error',
            message: 'Terjadi kesalahan dalam mengirim data',
            type: 'error'
        });
        process.value = false;
    }
};

// Initialize selection
onMounted(() => {
    // Ensure form is initialized before selecting
    if (form && form.phases && form.phases.length > 0) {
        selectPhase(form.phases[0]);
    }
});
</script>

<template>
    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
            <div class="mx-4 py-3">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">
                            {{ isEditMode ? 'Edit Program Pelatihan' : 'Buat Program Pelatihan Baru' }}
                        </h1>
                        <p class="mt-1 text-sm text-gray-600">
                            {{ isEditMode ? 'Perbarui informasi program pelatihan' : 'Buat program pelatihan dengan struktur yang terorganisir' }}
                        </p>
                    </div>
                    <div class="flex items-center space-x-3">
                        <el-button @click="handleCancel" :disabled="process">
                            Batal
                        </el-button>
                        <el-button type="primary" @click="submit" :loading="process">
                            {{ isEditMode ? 'Perbarui' : 'Simpan' }}
                        </el-button>
                    </div>
                </div>
            </div>
        </template>
        <template #sidebar>
            <QRDSidebar />
        </template>
        <template #content>
            <div class="flex h-full bg-gray-50">
                <!-- Left Sidebar - Program Structure -->
                <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
                    <div class="p-4">
                        <!-- Basic Program Info -->
                        <div class="mb-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Program</h3>
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">{{ field.name.label }}</label>
                                    <el-input v-model="form.name" placeholder="Masukkan nama program" />
                                </div>
                                <div class="grid grid-cols-2 gap-3">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ field.type.label }}</label>
                                        <el-input v-model="form.type" placeholder="Tipe" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">{{ field.level.label }}</label>
                                        <el-input v-model="form.level" placeholder="Level" />
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">{{ field.description.label }}</label>
                                    <el-input v-model="form.description" type="textarea" :rows="2" placeholder="Deskripsi program" />
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">{{ field.status.label }}</label>
                                    <el-select v-model="form.status" class="w-full" placeholder="Pilih Status">
                                        <el-option v-for="item in field.status.options" :key="item.value" :label="item.label" :value="item.value" />
                                    </el-select>
                                </div>
                            </div>
                        </div>

                        <!-- Phases Navigation -->
                        <div>
                            <div class="flex items-center justify-between mb-4">
                                <h3 class="text-lg font-medium text-gray-900">Struktur Program</h3>
                                <el-button type="primary" plain @click="addPhase" :disabled="process">
                                    + Phase
                                </el-button>
                            </div>
                            
                            <div class="space-y-2">
                                <div v-for="(phase, phaseIndex) in form.phases" :key="phaseIndex">
                                    <button 
                                        @click="selectPhase(phase)"
                                        :class="[
                                            'w-full text-left p-3 rounded-lg border transition-colors',
                                            selectedPhase === phase 
                                                ? 'border-blue-500 bg-blue-50 text-blue-700' 
                                                : 'border-gray-200 hover:border-gray-300'
                                        ]"
                                    >
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center space-x-3">
                                                <div class="flex-shrink-0 w-6 h-6 rounded-full bg-blue-100 flex items-center justify-center">
                                                    <span class="text-xs font-medium text-blue-600">{{ phaseIndex + 1 }}</span>
                                                </div>
                                                <div>
                                                    <div class="font-medium">{{ phase.name || `Phase ${phaseIndex + 1}` }}</div>
                                                    <div class="text-sm text-gray-500">{{ phase.modules?.length || 0 }} modul</div>
                                                </div>
                                            </div>
                                            <el-button
                                                v-if="form.phases.length > 1"
                                                type="danger"
                                                plain
                                                size="small"
                                                @click.stop="removePhase(phaseIndex)"
                                                :disabled="process"
                                            >
                                                ×
                                            </el-button>
                                        </div>
                                    </button>

                                    <!-- Modules for selected phase -->
                                    <div v-if="selectedPhase === phase && phase.modules" class="ml-4 mt-2 space-y-1">
                                        <button 
                                            v-for="(module, moduleIndex) in phase.modules" 
                                            :key="moduleIndex"
                                            @click="selectModule(module)"
                                            :class="[
                                                'w-full text-left p-2 rounded border text-sm transition-colors',
                                                selectedModule === module 
                                                    ? 'border-blue-300 bg-blue-25 text-blue-600' 
                                                    : 'border-gray-100 hover:border-gray-200'
                                            ]"
                                        >
                                            <div class="flex items-center justify-between">
                                                <div class="flex items-center space-x-2">
                                                    <span>📚</span>
                                                    <span>{{ module.name || `Module ${moduleIndex + 1}` }}</span>
                                                </div>
                                                <el-button
                                                    v-if="phase.modules.length > 1"
                                                    type="danger"
                                                    plain
                                                    size="small"
                                                    @click.stop="removeModule(phaseIndex, moduleIndex)"
                                                    :disabled="process"
                                                >
                                                    ×
                                                </el-button>
                                            </div>
                                        </button>
                                        
                                        <el-button
                                            type="primary"
                                            plain
                                            size="small"
                                            class="w-full mt-2"
                                            @click="addModule(phaseIndex)"
                                            :disabled="process"
                                        >
                                            + Module
                                        </el-button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content Area -->
                <div class="flex-1 flex flex-col">
                    <!-- Content Header -->
                    <div v-if="selectedPhase" class="bg-white border-b border-gray-200 p-4">
                        <div class="mb-4">
                            <h2 class="text-xl font-semibold text-gray-900">{{ selectedPhase.name || 'Phase Configuration' }}</h2>
                            <div class="grid grid-cols-2 gap-4 mt-3">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Nama Phase</label>
                                    <el-input v-model="selectedPhase.name" placeholder="Masukkan nama phase" />
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Order</label>
                                    <el-input-number v-model="selectedPhase.order" :min="1" class="w-full" />
                                </div>
                                <div class="col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-1">Deskripsi Phase</label>
                                    <el-input v-model="selectedPhase.description" type="textarea" :rows="2" placeholder="Deskripsi phase" />
                                </div>
                            </div>
                        </div>

                        <!-- Module Header -->
                        <div v-if="selectedModule">
                            <div class="border-t pt-4">
                                <h3 class="text-lg font-medium text-gray-900 mb-3">{{ selectedModule.name || 'Module Configuration' }}</h3>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Nama Module</label>
                                        <el-input v-model="selectedModule.name" placeholder="Masukkan nama module" />
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Order</label>
                                        <el-input-number v-model="selectedModule.order" :min="1" class="w-full" />
                                    </div>
                                    <div class="col-span-2">
                                        <label class="block text-sm font-medium text-gray-700 mb-1">Deskripsi Module</label>
                                        <el-input v-model="selectedModule.description" type="textarea" :rows="2" placeholder="Deskripsi module" />
                                    </div>
                                </div>
                            </div>

                            <!-- Content Type Tabs -->
                            <div class="flex border rounded-lg overflow-hidden mt-4">
                                <button 
                                    @click="selectedContentType = 'materials'"
                                    :class="[
                                        'px-4 py-2 text-sm font-medium',
                                        selectedContentType === 'materials' 
                                            ? 'bg-blue-600 text-white' 
                                            : 'bg-white text-gray-700 hover:bg-gray-50'
                                    ]"
                                >
                                    Materi ({{ selectedModule.materials?.length || 0 }})
                                </button>
                                <button 
                                    @click="selectedContentType = 'quizzes'"
                                    :class="[
                                        'px-4 py-2 text-sm font-medium border-l',
                                        selectedContentType === 'quizzes' 
                                            ? 'bg-blue-600 text-white' 
                                            : 'bg-white text-gray-700 hover:bg-gray-50'
                                    ]"
                                >
                                    Kuis ({{ selectedModule.quizzes?.length || 0 }})
                                </button>
                                <button 
                                    @click="selectedContentType = 'assessments'"
                                    :class="[
                                        'px-4 py-2 text-sm font-medium border-l',
                                        selectedContentType === 'assessments' 
                                            ? 'bg-blue-600 text-white' 
                                            : 'bg-white text-gray-700 hover:bg-gray-50'
                                    ]"
                                >
                                    Penilaian ({{ selectedModule.assessments?.length || 0 }})
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Content Management -->
                    <div class="flex-1 overflow-y-auto p-4" v-if="selectedModule">
                        <div class="max-w-4xl">
                            <!-- Content Header -->
                            <div class="flex items-center justify-between mb-4">
                                <h4 class="text-lg font-medium">
                                    {{ 
                                        selectedContentType === 'materials' ? 'Materi Pembelajaran' : 
                                        selectedContentType === 'quizzes' ? 'Kuis' : 'Penilaian' 
                                    }}
                                </h4>
                                <div class="flex space-x-2">
                                    <el-button 
                                        type="primary" 
                                        @click="selectedContentType === 'assessments' ? openAssessmentModal(null, -1) : addContent()"
                                        :disabled="process"
                                    >
                                        Tambah {{ 
                                            selectedContentType === 'materials' ? 'Materi' : 
                                            selectedContentType === 'quizzes' ? 'Kuis' : 'Penilaian' 
                                        }}
                                    </el-button>
                                    <el-button 
                                        v-if="selectedContentType === 'materials' || selectedContentType === 'quizzes'"
                                        type="primary" 
                                        plain
                                        @click="selectedContentType === 'materials' ? openMaterialModal(null, -1) : openQuizModal(null, -1)"
                                        :disabled="process"
                                    >
                                        Tambah {{ 
                                            selectedContentType === 'materials' ? 'Materi' : 'Kuis' 
                                        }} (Modal)
                                    </el-button>
                                </div>
                            </div>

                            <!-- Materials -->
                            <div v-if="selectedContentType === 'materials'" class="space-y-4">
                                <div v-for="(material, index) in currentContent" :key="index" class="bg-white border rounded-lg p-4">
                                    <div class="flex items-center justify-between mb-3">
                                        <h5 class="font-medium">Materi {{ index + 1 }}</h5>
                                        <div class="flex space-x-2">
                                            <el-button type="primary" plain size="small" @click="openMaterialModal(material, index)">
                                                Edit Modal
                                            </el-button>
                                            <el-button type="danger" plain size="small" @click="removeContent(index)" :disabled="process">
                                                Hapus
                                            </el-button>
                                        </div>
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Judul Materi</label>
                                            <el-input v-model="material.title" placeholder="Masukkan judul materi" />
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Tipe</label>
                                            <el-select v-model="material.type" class="w-full">
                                                <el-option label="Text" value="text" />
                                                <el-option label="Link" value="link" />
                                                <el-option label="Video" value="video" />
                                                <el-option label="Document" value="document" />
                                            </el-select>
                                        </div>
                                        <div class="col-span-2">
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Konten</label>
                                            <el-input 
                                                v-if="material.type === 'text'"
                                                v-model="material.content" 
                                                type="textarea" 
                                                :rows="3" 
                                                placeholder="Masukkan konten materi"
                                            />
                                            <el-input 
                                                v-else
                                                v-model="material.content" 
                                                placeholder="Masukkan URL atau konten"
                                            />
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Order</label>
                                            <el-input-number v-model="material.order" :min="1" class="w-full" />
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                                            <el-select v-model="material.status" class="w-full">
                                                <el-option label="Active" value="active" />
                                                <el-option label="Inactive" value="inactive" />
                                            </el-select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quizzes -->
                            <div v-else-if="selectedContentType === 'quizzes'" class="space-y-6">
                                <div v-for="(quiz, quizIndex) in currentContent" :key="quizIndex" class="bg-white border rounded-lg overflow-hidden">
                                    <!-- Quiz Header -->
                                    <div class="bg-gray-50 p-4 border-b">
                                    <div class="flex items-center justify-between mb-3">
                                            <h5 class="font-medium text-lg">Kuis {{ quizIndex + 1 }}</h5>
                                            <div class="flex space-x-2">
                                                <el-button type="primary" plain size="small" @click="openQuizModal(quiz, quizIndex)">
                                                    Edit Modal
                                                </el-button>
                                                <el-button type="danger" plain size="small" @click="removeContent(quizIndex)" :disabled="process">
                                                    Hapus Kuis
                                                </el-button>
                                            </div>
                                    </div>
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Judul Kuis</label>
                                            <el-input v-model="quiz.title" placeholder="Masukkan judul kuis" />
                                        </div>
                                        <div>
                                                <label class="block text-sm font-medium text-gray-700 mb-1">Passing Score (%)</label>
                                            <el-input-number v-model="quiz.passing_score" :min="0" :max="100" class="w-full" />
                                        </div>
                                        <div class="col-span-2">
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Deskripsi</label>
                                            <el-input v-model="quiz.description" type="textarea" :rows="2" placeholder="Deskripsi kuis" />
                                        </div>
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                                            <el-select v-model="quiz.status" class="w-full">
                                                <el-option label="Active" value="active" />
                                                <el-option label="Inactive" value="inactive" />
                                            </el-select>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Quiz Questions -->
                                    <div class="p-4">
                                        <div class="flex items-center justify-between mb-4">
                                            <h6 class="font-medium">Pertanyaan ({{ quiz.questions?.length || 0 }})</h6>
                                            <el-button type="primary" plain size="small" @click="addQuestion(quiz)">
                                                + Tambah Pertanyaan
                                            </el-button>
                                        </div>

                                        <div class="space-y-4">
                                            <div v-for="(question, questionIndex) in quiz.questions" :key="questionIndex" 
                                                 class="border rounded-lg p-4 bg-gray-50">
                                                <div class="flex items-center justify-between mb-3">
                                                    <h6 class="font-medium">Pertanyaan {{ questionIndex + 1 }}</h6>
                                                    <el-button type="danger" plain size="small" 
                                                               @click="removeQuestion(quiz, questionIndex)">
                                                        Hapus
                                                    </el-button>
                                                </div>

                                                <div class="grid grid-cols-2 gap-4 mb-4">
                                                    <div class="col-span-2">
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Teks Pertanyaan</label>
                                                        <el-input v-model="question.question" type="textarea" :rows="2" 
                                                                  placeholder="Masukkan pertanyaan" />
                                                    </div>
                                                    <div>
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Tipe Pertanyaan</label>
                                                        <el-select v-model="question.type" class="w-full" @change="handleQuestionTypeChange(question)">
                                                            <el-option label="Pilihan Ganda" value="multiple_choice" />
                                                            <el-option label="Pilihan Ganda (Multiple)" value="multiple_select" />
                                                            <el-option label="Essay" value="essay" />
                                                            <el-option label="Benar/Salah" value="true_false" />
                                                        </el-select>
                                                    </div>
                                                    <div>
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Poin</label>
                                                        <el-input-number v-model="question.points" :min="1" class="w-full" />
                                                    </div>
                                                    <div class="col-span-2">
                                                        <label class="block text-sm font-medium text-gray-700 mb-1">Penjelasan (Opsional)</label>
                                                        <el-input v-model="question.explanation" type="textarea" :rows="2" 
                                                                  placeholder="Penjelasan jawaban" />
                                                    </div>
                                                </div>

                                                <!-- Question Options/Answers -->
                                                <div v-if="question.type === 'multiple_choice' || question.type === 'multiple_select'" 
                                                     class="bg-white rounded-lg p-3 border">
                                                    <div class="flex items-center justify-between mb-3">
                                                        <h6 class="font-medium text-sm">Pilihan Jawaban</h6>
                                                        <el-button type="primary" plain size="small" @click="addOption(question)">
                                                            + Tambah Pilihan
                                                        </el-button>
                                                    </div>
                                                    
                                                    <div class="space-y-2">
                                                                                                                 <div v-for="(option, optionIndex) in question.options" :key="optionIndex" 
                                                              class="flex items-center gap-3 p-2 border rounded">
                                                             <div class="flex-shrink-0">
                                                                 <el-checkbox v-if="question.type === 'multiple_select'" 
                                                                              v-model="option.is_correct" />
                                                                 <el-radio v-else 
                                                                           :value="optionIndex"
                                                                           :model-value="getSelectedRadioValue(question)"
                                                                           @change="handleRadioChange(question, optionIndex)"
                                                                           :name="`question_${question.id || 'new'}_${optionIndex}`" />
                                                             </div>
                                                            <div class="flex-1">
                                                                <el-input v-model="option.option_text" placeholder="Teks pilihan" />
                                                            </div>
                                                            <div class="flex-shrink-0">
                                                                <el-button type="danger" plain size="small" 
                                                                           @click="removeOption(question, optionIndex)">
                                                                    ×
                                                                </el-button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Essay Answer -->
                                                <div v-else-if="question.type === 'essay'" class="bg-white rounded-lg p-3 border">
                                                    <label class="block text-sm font-medium text-gray-700 mb-1">Model Jawaban (Opsional)</label>
                                                    <el-input v-model="question.correct_answer" type="textarea" :rows="3" 
                                                              placeholder="Masukkan model jawaban untuk referensi penilaian" />
                                                </div>

                                                <!-- True/False Answer -->
                                                <div v-else-if="question.type === 'true_false'" class="bg-white rounded-lg p-3 border">
                                                    <label class="block text-sm font-medium text-gray-700 mb-1">Jawaban yang Benar</label>
                                                    <el-select v-model="question.correct_answer" class="w-full">
                                                        <el-option label="Benar" value="true" />
                                                        <el-option label="Salah" value="false" />
                                                    </el-select>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Empty State for Questions -->
                                        <div v-if="!quiz.questions || quiz.questions.length === 0" class="text-center py-8 border-2 border-dashed border-gray-300 rounded-lg">
                                            <svg class="mx-auto h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                            </svg>
                                            <h3 class="mt-2 text-sm font-medium text-gray-900">Belum ada pertanyaan</h3>
                                            <p class="mt-1 text-sm text-gray-500">Tambahkan pertanyaan pertama untuk kuis ini.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Assessments -->
                            <div v-else-if="selectedContentType === 'assessments'" class="space-y-4">
                                <div v-for="(assessment, index) in currentContent" :key="index" 
                                     class="bg-white border rounded-lg p-4 flex items-center justify-between">
                                    <div>
                                        <h5 class="font-medium">{{ assessment.title || `Assessment ${index + 1}` }}</h5>
                                        <p class="text-sm text-gray-600">{{ assessment.description }}</p>
                                        <div class="text-xs text-gray-500 mt-1">
                                            Metode: {{ assessment.calculation_method }} | Passing Score: {{ assessment.passing_score }}%
                                        </div>
                                    </div>
                                    <div class="flex items-center space-x-2">
                                        <el-button type="primary" @click="openAssessmentModal(assessment, index)">
                                            Edit
                                        </el-button>
                                        <el-button type="danger" plain @click="removeContent(index)" :disabled="process">
                                            Hapus
                                        </el-button>
                                    </div>
                                </div>
                            </div>

                            <!-- Empty State -->
                            <div v-if="currentContent.length === 0" class="text-center py-8">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                                </svg>
                                <h3 class="mt-2 text-sm font-medium text-gray-900">
                                    Belum ada {{ 
                                        selectedContentType === 'materials' ? 'materi' : 
                                        selectedContentType === 'quizzes' ? 'kuis' : 'penilaian' 
                                    }}
                                </h3>
                                <p class="mt-1 text-sm text-gray-500">
                                    Mulai dengan menambahkan {{ 
                                        selectedContentType === 'materials' ? 'materi' : 
                                        selectedContentType === 'quizzes' ? 'kuis' : 'penilaian' 
                                    }} pertama.
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- No Selection State -->
                    <div v-else class="flex-1 flex items-center justify-center">
                        <div class="text-center">
                            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"></path>
                            </svg>
                            <h3 class="mt-2 text-sm font-medium text-gray-900">Mulai Membangun Program</h3>
                            <p class="mt-1 text-sm text-gray-500">Lengkapi informasi program di sidebar, lalu pilih phase dan module untuk mengelola konten.</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Assessment Modal -->
            <Modal
                :show="showAssessmentModal"
                :property="modalProperty"
                @close="showAssessmentModal = false"
            >
                <AssessmentModalContent
                    :property-modal="modalProperty"
                    @close="showAssessmentModal = false"
                    @update:assessment="handleAssessmentUpdate"
                    @remove="handleAssessmentRemove"
                />
            </Modal>

            <!-- Material Modal -->
            <Modal
                :show="showMaterialModal"
                :property="modalProperty"
                @close="showMaterialModal = false"
            >
                <MaterialModalContent
                    :property-modal="modalProperty"
                    @close="showMaterialModal = false"
                    @update:material="handleMaterialUpdate"
                    @remove="handleMaterialRemove"
                />
            </Modal>

            <!-- Quiz Modal -->
            <Modal
                :show="showQuizModal"
                :property="modalProperty"
                @close="showQuizModal = false"
            >
                <QuizModalContent
                    :property-modal="modalProperty"
                    @close="showQuizModal = false"
                    @update:quiz="handleQuizUpdate"
                    @remove="handleQuizRemove"
                />
            </Modal>
        </template>
    </OfficeLayout>
</template> 