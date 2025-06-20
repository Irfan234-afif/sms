<script setup>
import { ElNotification } from 'element-plus';
import { useForm } from '@inertiajs/vue3';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Modal from '@/Components/Modal.vue';
import AssessmentModalContent from './AssessmentModalContent.vue';
import Badge from '@/Components/Badge.vue';
import { ref } from 'vue';

const breadcrumbs = [
    { label: 'Yayasan', href: route('office') },
    { label: 'QRD', href: route('office.qrd') },
    { label: 'Program Pelatihan', href: route('office.qrd.manage.training-program.index') },
    { label: 'Buat Baru', href: route('office.qrd.manage.training-program.create') }
];

const showAssessmentModal = ref(false);
const modalProperty = ref({
    title: '',
    mode: '',
    maxWidth: '4xl',
    data: null,
    index: -1,
    module: null
});

const openAssessmentModal = (module, assessment, index) => {
    modalProperty.value = {
        title: assessment ? 'Edit Assessment' : 'New Assessment',
        mode: assessment ? 'edit' : 'create',
        maxWidth: '4xl',
        data: assessment || {
            title: '',
            description: '',
            groupIndicators: []
        },
        index: index,
        module: module
    };
    showAssessmentModal.value = true;
};

const handleAssessmentUpdate = (updatedAssessment) => {
    const module = modalProperty.value.module;
    if (modalProperty.value.mode === 'create') {
        module.assessments.push(updatedAssessment);
    } else {
        module.assessments[modalProperty.value.index] = updatedAssessment;
    }
};

const handleAssessmentRemove = () => {
    const module = modalProperty.value.module;
    if (modalProperty.value.mode === 'edit') {
        module.assessments.splice(modalProperty.value.index, 1);
    }
    showAssessmentModal.value = false;
};
</script>

<script>
export default {
    data() {
        return {
            process: false,
            loaded: true,
            form: useForm({
                name: '',
                type: '',
                level: '',
                description: '',
                status: 'active',
                phases: [{
                    name: '',
                    description: '',
                    order: 1,
                    status: 'active',
                    modules: [{
                        name: '',
                        description: '',
                        order: 1,
                        status: 'active',
                        materials: [],
                        quizzes: [{
                            title: '',
                            description: '',
                            passing_score: 70,
                            status: 'active',
                            questions: [],
                            error: null
                        }],
                        assessments: [],
                        error: null
                    }],
                    error: null
                }]
            }),
            field: {
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
            }
        };
    },
    methods: {
        newPhase() {
            const newOrder = this.form.phases.length > 0 
                ? Math.max(...this.form.phases.map(p => p.order)) + 1 
                : 1;
            return {
                name: '',
                description: '',
                order: newOrder,
                status: 'active',
                modules: [this.newModule()],
                error: null
            };
        },
        newModule() {
            return {
                name: '',
                description: '',
                order: 1,
                status: 'active',
                materials: [this.newMaterial()],
                quizzes: [this.newQuiz()],
                assessments: [this.newAssessment()],
                error: null
            };
        },
        newMaterial() {
            return {
                title: '',
                type: 'text',
                content: '',
                file_path: '',
                order: 1,
                status: 'active',
                error: null
            };
        },
        newQuiz() {
            return {
                title: '',
                description: '',
                passing_score: 70,
                status: 'active',
                questions: [],
                error: null
            };
        },
        newAssessment() {
            return {
                title: '',
                description: '',
                status: 'active',
                groupIndicators: [],
                error: null
            };
        },
        submit() {
            this.$refs.form.validate((valid) => {
                if (valid) {
                    // Ensure all materials have required fields
                    this.form.phases.forEach(phase => {
                        phase.modules.forEach(module => {
                            if (module.materials) {
                                module.materials = module.materials.map(material => ({
                                    title: material.title,
                                    type: material.type,
                                    content: material.content,
                                    file_path: material.file_path || null,
                                    order: material.order,
                                    status: material.status
                                }));
                            }
                        });
                    });

                    this.process = true;
                    this.form.post(route('office.qrd.manage.training-program.store'), {
                        preserveScroll: true,
                        onSuccess: () => {
                            ElNotification({
                                title: 'Sukses',
                                message: 'Program pelatihan berhasil dibuat',
                                type: 'success'
                            });
                            this.$inertia.visit(route('office.qrd.manage.training-program.index'));
                        },
                        onError: (errors) => {
                            // Reset all field errors
                            Object.keys(this.field).forEach(key => {
                                this.field[key].error = null;
                            });

                            // Handle nested errors
                            Object.keys(errors).forEach(key => {
                                if (key.includes('.')) {
                                    // Handle nested errors (phases, modules, etc)
                                    const parts = key.split('.');
                                    if (parts[0] === 'phases') {
                                        const phaseIndex = parseInt(parts[1]);
                                        const field = parts[parts.length - 1];
                                        
                                        if (this.form.phases[phaseIndex]) {
                                            if (parts.length === 3) {
                                                // Phase level error
                                                this.form.phases[phaseIndex].error = errors[key];
                                            } else if (parts.length === 5 && parts[2] === 'modules') {
                                                // Module level error
                                                const moduleIndex = parseInt(parts[3]);
                                                if (this.form.phases[phaseIndex].modules[moduleIndex]) {
                                                    this.form.phases[phaseIndex].modules[moduleIndex].error = errors[key];
                                                }
                                            } else if (parts.length === 7) {
                                                // Assessment or Quiz level error
                                                const moduleIndex = parseInt(parts[3]);
                                                const itemType = parts[4]; // assessments or quizzes
                                                const itemIndex = parseInt(parts[5]);
                                                
                                                if (this.form.phases[phaseIndex].modules[moduleIndex] &&
                                                    this.form.phases[phaseIndex].modules[moduleIndex][itemType][itemIndex]) {
                                                    this.form.phases[phaseIndex].modules[moduleIndex][itemType][itemIndex].error = errors[key];
                                                }
                                            }
                                        }
                                    }
                                } else if (this.field[key]) {
                                    // Handle top level errors
                                    this.field[key].error = errors[key];
                                }
                            });

                            ElNotification({
                                title: 'Error',
                                message: 'Gagal membuat program pelatihan',
                                type: 'error'
                            });
                        },
                        onFinish: () => {
                            this.process = false;
                        }
                    });
                }
            });
        }
    }
};
</script>

<template>
    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
        </template>
        <template #sidebar>
            <QRDSidebar />
        </template>
        <template #content>
            <div class="bg-white rounded-lg shadow p-6">
                <h2 class="text-xl font-bold mb-6">Buat Program Pelatihan Baru</h2>

                <el-form ref="form" :model="form" label-position="top" :disabled="process" class="space-y-4">
                    <el-form-item :label="field.name.label" :rules="field.name.rules" :error="field.name.error"
                        prop="name">
                        <el-input v-model="form.name" />
                    </el-form-item>

                    <el-form-item :label="field.type.label" :rules="field.type.rules" :error="field.type.error"
                        prop="type">
                        <el-input v-model="form.type" />
                    </el-form-item>

                    <el-form-item :label="field.level.label" :rules="field.level.rules" :error="field.level.error"
                        prop="level">
                        <el-input v-model="form.level" />
                    </el-form-item>

                    <el-form-item :label="field.description.label" :rules="field.description.rules"
                        :error="field.description.error" prop="description">
                        <el-input v-model="form.description" type="textarea" :rows="3" />
                    </el-form-item>

                    <el-form-item :label="field.status.label" :rules="field.status.rules" :error="field.status.error"
                        prop="status">
                        <el-select v-model="form.status" class="w-full" placeholder="Pilih Status">
                            <el-option v-for="item in field.status.options" :key="item.value" :label="item.label"
                                :value="item.value" />
                        </el-select>
                    </el-form-item>

                    <h3 class="text-lg font-semibold mb-4">Program Phases</h3>
                    <div v-for="(phase, index) in form.phases" :key="index" class="border rounded-lg p-4 mb-4">
                        <div class="flex justify-between items-center mb-2">
                            <h3 class="font-medium">Phase {{ index + 1 }}</h3>
                            <el-button
                                v-if="form.phases.length > 1"
                                type="danger"
                                @click="form.phases.splice(index, 1)"
                            >
                                Remove
                            </el-button>
                        </div>
                        
                        <el-form-item 
                            label="Phase Name" 
                            required
                            :error="phase.error"
                        >
                            <el-input v-model="phase.name" />
                        </el-form-item>
                        
                        <el-form-item label="Description">
                            <el-input v-model="phase.description" type="textarea" :rows="2" />
                        </el-form-item>
                        
                        <el-form-item label="Order">
                            <el-input-number v-model="phase.order" :min="0" />
                        </el-form-item>
                        
                        <el-form-item label="Status">
                            <el-select v-model="phase.status" class="w-full">
                                <el-option label="Active" value="active" />
                                <el-option label="Inactive" value="inactive" />
                            </el-select>
                        </el-form-item>

                        <h3 class="text-lg font-semibold mb-4">Modules</h3>
                        <div v-for="(module, moduleIndex) in phase.modules" :key="moduleIndex" class="border rounded-lg p-4 mb-4 ml-4">
                            <div class="flex justify-between items-center mb-2">
                                <h3 class="font-medium">Module {{ moduleIndex + 1 }}</h3>
                                <el-button
                                    v-if="phase.modules.length > 1"
                                    type="danger"
                                    @click="phase.modules.splice(moduleIndex, 1)"
                                >
                                    Remove
                                </el-button>
                            </div>
                            
                            <el-form-item 
                                label="Module Name" 
                                required
                                :error="module.error"
                            >
                                <el-input v-model="module.name" />
                            </el-form-item>
                            
                            <el-form-item label="Description">
                                <el-input v-model="module.description" type="textarea" :rows="2" />
                            </el-form-item>
                            
                            <el-form-item label="Order">
                                <el-input-number v-model="module.order" :min="0" />
                            </el-form-item>
                            
                            <el-form-item label="Status">
                                <el-select v-model="module.status" class="w-full">
                                    <el-option label="Active" value="active" />
                                    <el-option label="Inactive" value="inactive" />
                                </el-select>
                            </el-form-item>

                            <h3 class="text-lg font-semibold mb-4">Materials</h3>
                            <div v-for="(material, materialIndex) in module.materials" :key="materialIndex" class="border rounded-lg p-4 mb-4 ml-4">
                                <div class="flex justify-between items-center mb-2">
                                    <h3 class="font-medium">Material {{ materialIndex + 1 }}</h3>
                                    <el-button
                                        v-if="module.materials.length > 1"
                                        type="danger"
                                        @click="module.materials.splice(materialIndex, 1)"
                                    >
                                        Remove
                                    </el-button>
                                </div>
                                
                                <el-form-item 
                                    label="Material Title" 
                                    required
                                    :error="material.error"
                                >
                                    <el-input v-model="material.title" />
                                </el-form-item>
                                
                                <el-form-item label="Type">
                                    <el-select v-model="material.type" class="w-full">
                                        <el-option label="Text" value="text" />
                                        <el-option label="Link" value="link" />
                                        <el-option label="Video" value="video" />
                                        <el-option label="Document" value="document" />
                                    </el-select>
                                </el-form-item>
                                
                                <el-form-item label="Content" required>
                                    <el-input 
                                        v-if="material.type === 'text'"
                                        v-model="material.content" 
                                        type="textarea" 
                                        :rows="3" 
                                    />
                                    <el-input 
                                        v-else
                                        v-model="material.content" 
                                        placeholder="Enter URL or content"
                                    />
                                </el-form-item>
                                
                                <el-form-item label="Order">
                                    <el-input-number v-model="material.order" :min="0" />
                                </el-form-item>
                                
                                <el-form-item label="Status">
                                    <el-select v-model="material.status" class="w-full">
                                        <el-option label="Active" value="active" />
                                        <el-option label="Inactive" value="inactive" />
                                    </el-select>
                                </el-form-item>
                            </div>
                            
                            <div class="mb-6 ml-4">
                                <el-button
                                    type="primary"
                                    plain
                                    @click="module.materials.push(this.newMaterial())"
                                >
                                    Add Material
                                </el-button>
                            </div>

                            <h3 class="text-lg font-semibold mb-4">Quizzes</h3>
                            <div v-for="(quiz, quizIndex) in module.quizzes" :key="quizIndex" class="border rounded-lg p-4 mb-4 ml-4">
                                <div class="flex justify-between items-center mb-2">
                                    <h3 class="font-medium">Quiz {{ quizIndex + 1 }}</h3>
                                    <el-button
                                        v-if="module.quizzes.length > 1"
                                        type="danger"
                                        @click="module.quizzes.splice(quizIndex, 1)"
                                    >
                                        Remove
                                    </el-button>
                                </div>
                                
                                <el-form-item 
                                    label="Quiz Name" 
                                    required
                                    :error="quiz.error"
                                >
                                    <el-input v-model="quiz.title" />
                                </el-form-item>
                                
                                <el-form-item label="Description">
                                    <el-input v-model="quiz.description" type="textarea" :rows="2" />
                                </el-form-item>
                                
                                <el-form-item label="Passing Score">
                                    <el-input-number v-model="quiz.passing_score" :min="0" :max="100" />
                                </el-form-item>
                                
                                <el-form-item label="Status">
                                    <el-select v-model="quiz.status" class="w-full">
                                        <el-option label="Active" value="active" />
                                        <el-option label="Inactive" value="inactive" />
                                    </el-select>
                                </el-form-item>
                            </div>
                            
                            <div class="mb-6 ml-4">
                                <el-button
                                    type="primary"
                                    plain
                                    @click="module.quizzes.push(this.newQuiz())"
                                >
                                    Add Quiz
                                </el-button>
                            </div>

                            <div class="mt-4">
                                <h3 class="text-lg font-semibold mb-4">Assessments</h3>
                                
                                <div class="space-y-2">
                                    <div v-for="(assessment, assessmentIndex) in module.assessments" 
                                         :key="assessmentIndex" 
                                         class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                                        <div class="flex items-center space-x-3">
                                            <span class="font-medium">{{ assessment.title }}</span>
                                            <span v-if="assessment.error" class="text-red-500 text-sm">{{ assessment.error }}</span>
                                        </div>
                                        <div class="flex items-center space-x-2">
                                            <el-button
                                                type="primary"
                                                @click="openAssessmentModal(module, assessment, assessmentIndex)"
                                            >
                                                Edit
                                            </el-button>
                                            <el-button
                                                type="danger"
                                                @click="module.assessments.splice(assessmentIndex, 1)"
                                            >
                                                Remove
                                            </el-button>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <el-button
                                        type="primary"
                                        plain
                                        @click="openAssessmentModal(module, null, -1)"
                                    >
                                        Add Assessment
                                    </el-button>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-6 ml-4">
                            <el-button
                                type="primary"
                                plain
                                @click="phase.modules.push(this.newModule())"
                            >
                                Add Module
                            </el-button>
                        </div>
                    </div>
                    
                    <div class="mb-6">
                        <el-button
                            type="primary"
                            plain
                            @click="form.phases.push(this.newPhase())"
                        >
                            Add Phase
                        </el-button>
                    </div>

                    <div class="flex justify-end space-x-3">
                        <el-button @click="$inertia.visit(route('office.qrd.manage.training-program.index'))"
                            :disabled="process">
                            Batal
                        </el-button>
                        <el-button type="primary" @click="submit" :loading="process">
                            Simpan
                        </el-button>
                    </div>
                </el-form>
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
        </template>
    </OfficeLayout>
</template>
