<script>
import { initFlowbite } from 'flowbite';
import { computed } from 'vue';
export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import { Head, Link } from '@inertiajs/vue3';
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import Modal from '@/Components/Modal.vue';
import QuizDetailModalContent from './QuizDetailModalContent.vue';
import { ref } from 'vue';

const props = defineProps({
    activity: Object,
    participant: Object,
});

const breadcrumbs = [
    { label: 'Yayasan', href: route('office') },
    { label: 'QRD', href: route('office.qrd') },
    { label: 'Aktivitas Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
    { label: props.activity?.title || 'Activity', href: route('office.qrd.activity.training-program-activity.show', props.activity?.uuid) },
    { label: `Detail ${props.participant?.profile?.name || 'Participant'}` },
];

const getStatusColor = (status) => {
    const colors = {
        'NOT_STARTED': 'gray',
        'IN_PROGRESS': 'blue',
        'COMPLETED': 'green',
        'FAILED': 'red'
    };
    return colors[status] || 'gray';
};

const getStatusText = (status) => {
    const texts = {
        'NOT_STARTED': 'Belum Dimulai',
        'IN_PROGRESS': 'Sedang Berlangsung',
        'COMPLETED': 'Selesai',
        'FAILED': 'Gagal'
    };
    return texts[status] || status;
};

// Computed property to organize module progress by phase
const moduleProgressByPhase = computed(() => {
    if (!props.participant?.module_progress || !props.participant?.phase_progress) {
        return {};
    }

    const grouped = {};
    
    // Group module progress by phase
    props.participant.module_progress.forEach(moduleProgress => {
        // Get the phase ID from the module's phase relationship
        let phaseId = null;
        let phaseName = 'Unknown Phase';

        // Try to get phase info from module relationship
        if (moduleProgress.module?.phase_id) {
            phaseId = moduleProgress.module.phase_id;
            
            // Find the corresponding phase progress to get phase name
            const phaseProgress = props.participant.phase_progress.find(p => 
                p.activity_phase_id === phaseId || 
                p.master_phase_id === phaseId || 
                p.old_phase_id === phaseId
            );
            
            if (phaseProgress?.phase?.name) {
                phaseName = phaseProgress.phase.name;
            }
        }

        // If we couldn't determine phase from module, try to match with existing phases
        if (!phaseId && props.participant.phase_progress.length > 0) {
            // For now, assign to first phase if we can't determine
            const firstPhase = props.participant.phase_progress[0];
            phaseId = firstPhase.activity_phase_id || firstPhase.master_phase_id || firstPhase.old_phase_id;
            phaseName = firstPhase.phase?.name || 'Unknown Phase';
        }

        if (!grouped[phaseId]) {
            grouped[phaseId] = {
                phaseName: phaseName,
                modules: []
            };
        }

        grouped[phaseId].modules.push(moduleProgress);
    });

    return grouped;
});

// Helper function to check if assessment has been completed
const hasAssessmentResult = (assessment) => {
    if (!props.participant?.assessment_results) {
        return false;
    }
    
    return props.participant.assessment_results.some(result => 
        result.activity_assessment_id === assessment.id || 
        result.master_assessment_id === assessment.master_assessment_id || 
        result.old_assessment_id === assessment.id
    );
};

// Helper function to check if quiz is awaiting grading
const isAwaitingGrading = (attempt) => {
    return attempt.completed_at && 
           (attempt.score === null || attempt.score === undefined) &&
           !attempt.graded_at;
};

// Modal state for quiz detail
const showQuizDetailModal = ref(false);
const selectedQuizAttempt = ref(null);

const showQuizDetail = (attempt) => {
    selectedQuizAttempt.value = attempt;
    showQuizDetailModal.value = true;
};

const closeQuizDetailModal = () => {
    showQuizDetailModal.value = false;
    selectedQuizAttempt.value = null;
};
</script>

<template>
    <Head :title="`Detail ${participant?.profile?.name || 'Participant'} - ${activity?.title || 'Training Activity'}`" />

    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
            <div class="mx-4 py-3">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">
                            Detail Peserta: {{ participant?.profile?.name || 'Unknown Participant' }}
                        </h1>
                        <p class="mt-1 text-sm text-gray-600">
                            Training: {{ activity?.title || 'Unknown Activity' }}
                        </p>
                    </div>
                    <div class="flex space-x-2">
                        <Link v-if="activity?.uuid" :href="route('office.qrd.activity.training-program-activity.show', activity.uuid)">
                            <OutlineButton type="secondary">
                                <div class="flex items-center space-x-1">
                                    <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                                    </svg>
                                    <span>Kembali</span>
                                </div>
                            </OutlineButton>
                        </Link>
                    </div>
                </div>
            </div>
        </template>
        
        <template #sidebar>
            <QRDSidebar />
        </template>
        
        <template #content>
            <div class="bg-white">
                <div class="p-6 space-y-6">
                    
                    <!-- Debug Info (remove in production) -->
                    <div v-if="!activity || !participant" class="bg-red-50 border border-red-200 rounded-lg p-4">
                        <div class="flex">
                            <div class="flex-shrink-0">
                                <svg class="h-5 w-5 text-red-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
                                </svg>
                            </div>
                            <div class="ml-3">
                                <h3 class="text-sm font-medium text-red-800">Data Tidak Ditemukan</h3>
                                <div class="mt-2 text-sm text-red-700">
                                    <p>Activity: {{ activity ? 'Found' : 'Not found' }}</p>
                                    <p>Participant: {{ participant ? 'Found' : 'Not found' }}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Participant Info Cards -->
                    <div v-if="participant" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Basic Info -->
                        <div class="bg-white border border-gray-200 rounded-lg p-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Peserta</h3>
                            <div class="space-y-3">
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Nama</label>
                                    <div class="text-gray-900">{{ participant.profile?.name || '-' }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Email</label>
                                    <div class="text-gray-900">{{ participant.profile?.email || '-' }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">ID Karyawan</label>
                                    <div class="text-gray-900">{{ participant.profile?.employee_id || '-' }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Posisi</label>
                                    <div class="text-gray-900">{{ participant.profile?.position || '-' }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Area</label>
                                    <div class="text-gray-900">{{ participant.profile?.area?.name || '-' }}</div>
                                </div>
                            </div>
                        </div>

                        <!-- Progress Overview -->
                        <div class="bg-white border border-gray-200 rounded-lg p-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Progress Overview</h3>
                            <div class="space-y-4">
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Progress Keseluruhan</label>
                                    <div class="mt-2 flex items-center">
                                        <div class="flex-1 bg-gray-200 rounded-full h-3 mr-3">
                                            <div class="bg-blue-600 h-3 rounded-full" :style="`width: ${participant.overall_progress || 0}%`"></div>
                                        </div>
                                        <span class="text-sm font-medium text-gray-900">{{ Math.round(participant.overall_progress || 0) }}%</span>
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="text-sm font-medium text-gray-500">Tanggal Pendaftaran</label>
                                        <div class="text-gray-900">{{ participant.enrollment_date || '-' }}</div>
                                    </div>
                                    <div>
                                        <label class="text-sm font-medium text-gray-500">Tanggal Selesai</label>
                                        <div class="text-gray-900">{{ participant.completion_date || '-' }}</div>
                                    </div>
                                </div>
                                <div v-if="participant.has_completed" class="bg-green-50 border border-green-200 rounded-lg p-3">
                                    <div class="flex">
                                        <svg class="h-5 w-5 text-green-400" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                                        </svg>
                                        <div class="ml-2">
                                            <h3 class="text-sm font-medium text-green-800">Training Selesai</h3>
                                            <p class="text-sm text-green-700">Peserta telah menyelesaikan training dengan sukses.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Progress Detail -->
                    <div v-if="participant" class="bg-white border border-gray-200 rounded-lg">
                        <div class="p-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-6">Detail Progress Training</h3>

                            <!-- Training Type Info -->
                            <div v-if="!activity.training_program && !activity.activity_training_program" class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
                                <div class="flex">
                                    <svg class="h-5 w-5 text-blue-400" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                                    </svg>
                                    <div class="ml-3">
                                        <h3 class="text-sm font-medium text-blue-800">Training Eksternal</h3>
                                        <p class="text-sm text-blue-700">Ini adalah training eksternal tanpa kurikulum internal. Progress tracking tidak tersedia untuk training jenis ini.</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Phase Progress for Internal Training -->
                            <div v-if="participant.phase_progress && participant.phase_progress.length > 0" class="space-y-4">
                                <div v-for="phaseProgress in participant.phase_progress" :key="phaseProgress.id" 
                                     class="border border-gray-200 rounded-lg p-4">
                                    <div class="flex items-center justify-between mb-4">
                                        <h4 class="text-md font-medium text-gray-900">
                                            {{ phaseProgress.phase?.name || 'Loading Phase...' }}
                                        </h4>
                                        <div class="flex items-center">
                                            <div class="w-32 bg-gray-200 rounded-full h-2 mr-3">
                                                <div class="bg-green-600 h-2 rounded-full" :style="`width: ${phaseProgress.progress_percentage || 0}%`"></div>
                                            </div>
                                            <span class="text-sm font-medium text-gray-900">{{ Math.round(phaseProgress.progress_percentage || 0) }}%</span>
                                        </div>
                                    </div>
                                    
                                    <!-- Module Progress for this Phase -->
                                    <div v-if="moduleProgressByPhase[phaseProgress.activity_phase_id || phaseProgress.master_phase_id || phaseProgress.old_phase_id]" class="ml-4 space-y-2">
                                        <div v-for="moduleProgress in moduleProgressByPhase[phaseProgress.activity_phase_id || phaseProgress.master_phase_id || phaseProgress.old_phase_id].modules" 
                                             :key="moduleProgress.id" 
                                             class="bg-gray-50 rounded-lg p-3">
                                            <div class="flex items-center justify-between">
                                                <span class="text-sm font-medium text-gray-700">
                                                    {{ moduleProgress.module?.name || 'Loading Module...' }}
                                                </span>
                                                <div class="flex items-center space-x-3">
                                                    <Badge :type="getStatusColor(moduleProgress.status)">
                                                        {{ getStatusText(moduleProgress.status) }}
                                                    </Badge>
                                                    <div class="flex items-center">
                                                        <div class="w-20 bg-gray-200 rounded-full h-1.5 mr-2">
                                                            <div class="bg-blue-600 h-1.5 rounded-full" :style="`width: ${moduleProgress.progress_percentage || 0}%`"></div>
                                                        </div>
                                                        <span class="text-xs text-gray-600">{{ Math.round(moduleProgress.progress_percentage || 0) }}%</span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Quiz & Assessment Tables -->
                            <div class="mt-8 space-y-6">
                                <!-- Available Assessments for Input -->
                                <div v-if="activity.activity_training_program && activity.activity_training_program.phases">
                                    <h4 class="text-md font-medium text-gray-900 mb-3">Assessment yang Tersedia</h4>
                                    <div class="bg-gray-50 rounded-lg p-4">
                                        <div class="space-y-4">
                                            <template v-for="phase in activity.activity_training_program.phases" :key="phase.id">
                                                <template v-for="module in phase.modules" :key="module.id">
                                                    <template v-for="assessment in module.assessments" :key="assessment.id">
                                                        <div class="bg-white border border-gray-200 rounded-lg p-4">
                                                            <div class="flex items-center justify-between">
                                                                <div class="flex-1">
                                                                    <h5 class="text-sm font-medium text-gray-900">{{ assessment.title }}</h5>
                                                                    <p class="text-xs text-gray-500">
                                                                        {{ phase.name }} → {{ module.name }}
                                                                    </p>
                                                                    <p v-if="assessment.description" class="text-xs text-gray-600 mt-1">
                                                                        {{ assessment.description }}
                                                                    </p>
                                                                </div>
                                                                <div class="flex items-center space-x-3">
                                                                                                                                                                                          <!-- Check if assessment already has result -->
                                                                  <template v-if="hasAssessmentResult(assessment)">
                                                                      <Badge type="green">Sudah Dinilai</Badge>
                                                                      <Link 
                                                                          :href="route('office.qrd.activity.training-program-activity.inputAssessment', [activity.uuid, participant.uuid, assessment.id])"
                                                                          class="inline-flex items-center px-3 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                                                                      >
                                                                          Edit Penilaian
                                                                      </Link>
                                                                  </template>
                                                                  <template v-else>
                                                                      <Badge type="gray">Belum Dinilai</Badge>
                                                                      <Link 
                                                                          :href="route('office.qrd.activity.training-program-activity.inputAssessment', [activity.uuid, participant.uuid, assessment.id])"
                                                                          class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                                                                      >
                                                                          Input Penilaian
                                                                      </Link>
                                                                  </template>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </template>
                                                </template>
                                            </template>
                                        </div>
                                    </div>
                                </div>

                                <!-- Quiz Attempts & Assessment Results -->
                                <div class="grid grid-cols-1 gap-6">
                                    <!-- Quiz Attempts -->
                                    <div v-if="participant.quiz_attempts && participant.quiz_attempts.length > 0" class="w-full">
                                        <h4 class="text-md font-medium text-gray-900 mb-3">Riwayat Quiz</h4>
                                        <div class="overflow-hidden border border-gray-200 rounded-lg">
                                            <table class="min-w-full divide-y divide-gray-200">
                                                <thead class="bg-gray-50">
                                                    <tr>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Quiz</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Skor</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Aksi</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-gray-200">
                                                    <tr v-for="attempt in participant.quiz_attempts" :key="attempt.id">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                            {{ attempt.quiz?.title || 'Unknown Quiz' }}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                            <template v-if="isAwaitingGrading(attempt)">
                                                                <Badge type="orange">Menunggu Koreksi</Badge>
                                                            </template>
                                                            <template v-else>
                                                            {{ attempt.score || 0 }}/{{ attempt.quiz?.passing_score || 100 }}
                                                            </template>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <template v-if="isAwaitingGrading(attempt)">
                                                                <Badge type="orange">Menunggu Koreksi</Badge>
                                                            </template>
                                                            <template v-else>
                                                            <Badge :type="attempt.passed ? 'green' : 'red'">
                                                                {{ attempt.passed ? 'Lulus' : 'Tidak Lulus' }}
                                                            </Badge>
                                                            </template>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            {{ attempt.completed_at || '-' }}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <div class="flex space-x-2">
                                                                <template v-if="isAwaitingGrading(attempt)">
                                                                    <Link 
                                                                        :href="route('office.qrd.activity.training-program-activity.gradeQuiz', [activity.uuid, participant.uuid, attempt.id])"
                                                                        class="inline-flex items-center px-3 py-1.5 border border-transparent text-xs font-medium rounded text-white bg-orange-600 hover:bg-orange-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500"
                                                                    >
                                                                        Koreksi Quiz
                                                                    </Link>
                                                                </template>
                                                                <template v-else-if="attempt.graded_at">
                                                                    <Link 
                                                                        :href="route('office.qrd.activity.training-program-activity.gradeQuiz', [activity.uuid, participant.uuid, attempt.id])"
                                                                        class="inline-flex items-center px-3 py-1.5 border border-gray-300 shadow-sm text-xs font-medium rounded text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                                                                    >
                                                                        Edit Koreksi
                                                                    </Link>
                                                                    <button 
                                                                        @click="showQuizDetail(attempt)"
                                                                        class="inline-flex items-center px-3 py-1.5 border border-blue-300 shadow-sm text-xs font-medium rounded text-blue-700 bg-blue-50 hover:bg-blue-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                                                                    >
                                                                        <svg class="mr-1 h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                                                        </svg>
                                                                        Lihat Detail
                                                                    </button>
                                                                </template>
                                                                <template v-else-if="attempt.completed_at">
                                                                    <button 
                                                                        @click="showQuizDetail(attempt)"
                                                                        class="inline-flex items-center px-3 py-1.5 border border-blue-300 shadow-sm text-xs font-medium rounded text-blue-700 bg-blue-50 hover:bg-blue-100 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                                                                    >
                                                                        <svg class="mr-1 h-3 w-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                                                        </svg>
                                                                        Lihat Jawaban
                                                                    </button>
                                                                </template>
                                                                <template v-else>
                                                                    <span class="text-gray-400">-</span>
                                                                </template>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                    <!-- Assessment Results -->
                                    <div v-if="participant.assessment_results && participant.assessment_results.length > 0" class="w-full">
                                        <h4 class="text-md font-medium text-gray-900 mb-3">Hasil Assessment</h4>
                                        <div class="overflow-hidden border border-gray-200 rounded-lg">
                                            <table class="min-w-full divide-y divide-gray-200">
                                                <thead class="bg-gray-50">
                                                    <tr>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Assessment</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Skor</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tanggal</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-gray-200">
                                                    <tr v-for="result in participant.assessment_results" :key="result.id">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                            {{ result.activity_assessment?.title || result.assessment?.name || result.assessment?.description || 'Assessment' }}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                            {{ result.final_score || result.total_score || 0 }}
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <Badge :type="result.is_passed ? 'green' : 'red'">
                                                                {{ result.is_passed ? 'Lulus' : 'Tidak Lulus' }}
                                                            </Badge>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            {{ result.assessed_at || '-' }}
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Empty State for Internal Training -->
                            <div v-if="(activity.training_program || activity.activity_training_program) && 
                                       (!participant.phase_progress || participant.phase_progress.length === 0) && 
                                       (!participant.quiz_attempts || participant.quiz_attempts.length === 0) && 
                                       (!participant.assessment_results || participant.assessment_results.length === 0)" 
                                 class="text-center py-12">
                                <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                                <h3 class="mt-2 text-sm font-medium text-gray-900">Sedang Memproses Progress</h3>
                                <p class="mt-1 text-sm text-gray-500">Progress training sedang diinisialisasi. Silakan refresh halaman dalam beberapa saat.</p>
                                <button @click="window.location.reload()" class="mt-3 inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm leading-4 font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    <svg class="-ml-0.5 mr-2 h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
                                    </svg>
                                    Refresh
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </template>
    </OfficeLayout>

    <!-- Quiz Detail Modal -->
    <Modal :show="showQuizDetailModal" :property="{ maxWidth: '6xl' }" @close="closeQuizDetailModal">
        <template #default>
            <QuizDetailModalContent 
                v-if="selectedQuizAttempt"
                :selectedQuizAttempt="selectedQuizAttempt"
                :participant="participant"
                :activity="activity"
                @close="closeQuizDetailModal"
            />
        </template>
    </Modal>
</template> 