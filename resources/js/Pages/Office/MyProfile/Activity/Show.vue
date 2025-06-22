<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { computed } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  participant: {
    type: Object,
    required: true
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') },
  { label: props.activity.title, href: '#' }
];

const getStatusColor = (status) => {
  switch(status) {
    case 'completed':
      return 'green';
    case 'in_progress':
      return 'yellow';
    case 'enrolled':
      return 'blue';
    default:
      return 'gray';
  }
};

const getStatusText = (status) => {
  switch(status) {
    case 'completed':
      return 'Selesai';
    case 'in_progress':
      return 'Sedang Belajar';
    case 'enrolled':
      return 'Terdaftar';
    default:
      return 'Tidak Diketahui';
  }
};

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};

const canStartLearning = computed(() => {
  return props.activity.status === 'ONGOING' || props.activity.status === 'PLANNED';
});

const hasTrainingProgram = computed(() => {
  return props.activity.activity_training_program && props.activity.activity_training_program.phases?.length > 0;
});

const totalModules = computed(() => {
  if (!hasTrainingProgram.value) return 0;
  return props.activity.activity_training_program.phases.reduce((total, phase) => {
    return total + (phase.modules?.length || 0);
  }, 0);
});

const completedModules = computed(() => {
  if (!hasTrainingProgram.value) return 0;
  let completed = 0;
  props.activity.activity_training_program.phases.forEach(phase => {
    phase.modules?.forEach(module => {
      if (module.status === 'completed') {
        completed++;
      }
    });
  });
  return completed;
});

const overallProgress = computed(() => {
  return props.participant.overall_progress || 0;
});

const getProgressColor = (progress) => {
  if (progress >= 100) return 'bg-green-500';
  if (progress >= 50) return 'bg-blue-500';
  return 'bg-gray-300';
};

const getModuleStatusColor = (status) => {
  switch(status) {
    case 'completed':
      return 'text-green-600';
    case 'in_progress':
      return 'text-blue-600';
    default:
      return 'text-gray-400';
  }
};

const getModuleStatusIcon = (status) => {
  switch(status) {
    case 'completed':
      return '✓';
    case 'in_progress':
      return '▶';
    default:
      return '○';
  }
};

const getActivityStatusText = (status) => {
  switch(status) {
    case 'ONGOING':
      return 'Sedang Berlangsung';
    case 'COMPLETED':
      return 'Selesai';
    case 'PLANNED':
      return 'Direncanakan';
    default:
      return 'Tidak Diketahui';
  }
};

const getActivityStatusColor = (status) => {
  switch(status) {
    case 'ONGOING':
      return 'green';
    case 'COMPLETED':
      return 'blue';
    case 'PLANNED':
      return 'yellow';
    default:
      return 'gray';
  }
};
</script>

<template>
  <Head :title="`${activity.title}`" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ activity.title }}</h1>
            <p class="mt-1 text-sm text-gray-600" v-if="activity.description">{{ activity.description }}</p>
          </div>
          <div class="flex items-center space-x-4">
            <Badge :type="getStatusColor(participant.status)">
              {{ getStatusText(participant.status) }}
            </Badge>
            <Link 
              v-if="canStartLearning && hasTrainingProgram"
              :href="route('office.myProfile.activity.trainingProgram.learn', activity.uuid)"
              class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 focus:bg-blue-700 active:bg-blue-900 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition ease-in-out duration-150"
            >
              {{ participant.status === 'enrolled' ? 'Mulai Belajar' : 'Lanjutkan Belajar' }}
            </Link>
          </div>
        </div>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <div class="p-6 space-y-6">
        <!-- Activity Overview -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h2 class="text-lg font-medium text-gray-900 mb-4">Ringkasan Aktivitas</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <div class="bg-blue-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-blue-900">Tanggal Mulai</p>
                    <p class="text-lg font-semibold text-blue-700">{{ formatDate(activity.start_date) }}</p>
                  </div>
                </div>
              </div>

              <div class="bg-green-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-green-900">Tanggal Selesai</p>
                    <p class="text-lg font-semibold text-green-700">{{ formatDate(activity.end_date) }}</p>
                  </div>
                </div>
              </div>

              <div class="bg-purple-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-purple-900">Progress</p>
                    <p class="text-lg font-semibold text-purple-700">{{ Math.round(overallProgress) }}%</p>
                  </div>
                </div>
              </div>

              <div class="bg-yellow-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C20.832 18.477 19.246 18 17.5 18c-1.746 0-3.332.477-4.5 1.253"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-yellow-900">Modul</p>
                    <p class="text-lg font-semibold text-yellow-700">{{ completedModules }}/{{ totalModules }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Progress Bar -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <div class="flex items-center justify-between mb-2">
              <h3 class="text-lg font-medium text-gray-900">Progress Keseluruhan</h3>
              <span class="text-sm font-medium text-gray-700">{{ Math.round(overallProgress) }}%</span>
            </div>
            <div class="w-full bg-gray-200 rounded-full h-3">
              <div 
                :class="getProgressColor(overallProgress)"
                class="h-3 rounded-full transition-all duration-500" 
                :style="`width: ${overallProgress}%`"
              ></div>
            </div>
            <div class="mt-2 text-sm text-gray-600">
              {{ completedModules }} dari {{ totalModules }} modul telah diselesaikan
            </div>
          </div>
        </div>

        <!-- Training Program Content -->
        <div v-if="hasTrainingProgram" class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Kurikulum Pelatihan</h3>
            <div class="space-y-4">
              <div v-for="(phase, phaseIndex) in activity.activity_training_program.phases" :key="phase.uuid" class="border rounded-lg p-4">
                <div class="flex items-start justify-between">
                  <div class="flex items-start space-x-3">
                    <div class="flex-shrink-0 w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                      <span class="text-sm font-medium text-blue-600">{{ phaseIndex + 1 }}</span>
                    </div>
                    <div>
                      <h4 class="font-medium text-gray-900">{{ phase.name }}</h4>
                      <p class="text-sm text-gray-600" v-if="phase.description">{{ phase.description }}</p>
                    </div>
                  </div>
                  <div class="text-right">
                    <div class="text-sm text-gray-500">{{ phase.progress || 0 }}%</div>
                    <div class="w-16 bg-gray-200 rounded-full h-2 mt-1">
                      <div 
                        :class="getProgressColor(phase.progress || 0)"
                        class="h-2 rounded-full" 
                        :style="`width: ${phase.progress || 0}%`"
                      ></div>
                    </div>
                  </div>
                </div>

                <!-- Modules -->
                <div v-if="phase.modules?.length > 0" class="mt-4 ml-11 space-y-2">
                  <div v-for="(module, moduleIndex) in phase.modules" :key="module.uuid" class="flex items-center justify-between p-3 bg-gray-50 rounded border">
                    <div class="flex items-center space-x-3">
                      <span :class="getModuleStatusColor(module.status)" class="text-lg">
                        {{ getModuleStatusIcon(module.status) }}
                      </span>
                      <div>
                        <div class="font-medium text-sm">{{ module.name }}</div>
                        <div class="text-xs text-gray-500">
                          {{ module.materials?.length || 0 }} materi, 
                          {{ module.quizzes?.length || 0 }} kuis, 
                          {{ module.assessments?.length || 0 }} penilaian
                        </div>
                      </div>
                    </div>
                    <div class="text-right">
                      <div class="text-sm text-gray-600">{{ module.progress || 0 }}%</div>
                      <div class="w-12 bg-gray-200 rounded-full h-1 mt-1">
                        <div 
                          :class="getProgressColor(module.progress || 0)"
                          class="h-1 rounded-full" 
                          :style="`width: ${module.progress || 0}%`"
                        ></div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- No Training Program -->
        <div v-else class="bg-white rounded-lg shadow">
          <div class="p-6 text-center">
            <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
            </svg>
            <h3 class="mt-2 text-sm font-medium text-gray-900">Aktivitas Manual</h3>
            <p class="mt-1 text-sm text-gray-500">
              Aktivitas ini tidak memiliki kurikulum terstruktur. Silakan hubungi penyelenggara untuk informasi lebih lanjut.
            </p>
          </div>
        </div>

        <!-- Activity Information -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Aktivitas</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <dt class="text-sm font-medium text-gray-500">Status Aktivitas</dt>
                <dd class="mt-1 text-sm text-gray-900">
                  <Badge :type="getActivityStatusColor(activity.status)">
                    {{ getActivityStatusText(activity.status) }}
                  </Badge>
                </dd>
              </div>
              
              <div>
                <dt class="text-sm font-medium text-gray-500">Tanggal Pendaftaran</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ formatDate(participant.enrollment_date) }}</dd>
              </div>

              <div v-if="participant.completion_date">
                <dt class="text-sm font-medium text-gray-500">Tanggal Selesai</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ formatDate(participant.completion_date) }}</dd>
              </div>

              <div v-if="participant.certificate_issued && activity.uuid">
                <dt class="text-sm font-medium text-gray-500">Sertifikat</dt>
                <dd class="mt-1 text-sm text-gray-900">
                  <OutlineButton 
                    type="primary" 
                    @click="$inertia.get(route('office.myProfile.activity.trainingProgram.certificate', activity.uuid))"
                  >
                    Lihat Sertifikat
                  </OutlineButton>
                </dd>
              </div>

              <div v-if="activity.activity_training_program">
                <dt class="text-sm font-medium text-gray-500">Program Pelatihan</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ activity.activity_training_program.title }}</dd>
              </div>

              <div v-if="activity.submission">
                <dt class="text-sm font-medium text-gray-500">Berdasarkan Pengajuan</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ activity.submission.title }}</dd>
              </div>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex justify-between items-center bg-white rounded-lg shadow p-6">
          <OutlineButton 
            type="secondary" 
            @click="$inertia.get(route('office.myProfile.activity.trainingProgram.index'))"
          >
            Kembali ke Daftar
          </OutlineButton>
          
          <div class="space-x-3">
            <OutlineButton 
              v-if="participant.certificate_issued && activity.uuid"
              type="primary" 
              @click="$inertia.get(route('office.myProfile.activity.trainingProgram.certificate', activity.uuid))"
            >
              Lihat Sertifikat
            </OutlineButton>
            <Link 
              v-if="canStartLearning && hasTrainingProgram && activity.uuid"
              :href="route('office.myProfile.activity.trainingProgram.learn', activity.uuid)"
              class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 focus:bg-blue-700 active:bg-blue-900 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 transition ease-in-out duration-150"
            >
              {{ participant.status === 'enrolled' ? 'Mulai Belajar' : 'Lanjutkan Belajar' }}
            </Link>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 