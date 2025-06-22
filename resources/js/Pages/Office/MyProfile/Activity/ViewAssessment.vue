<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { computed } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  assessment: {
    type: Object,
    required: true
  },
  result: {
    type: Object,
    default: null
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') },
  { label: props.activity.title, href: route('office.myProfile.activity.trainingProgram.show', props.activity.uuid) },
  { label: `Penilaian: ${props.assessment.title}`, href: '#' }
];

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  });
};

// Assessment module information
const moduleInfo = computed(() => {
  if (!props.assessment?.activity_module) return null;
  return props.assessment.activity_module;
});

const phaseInfo = computed(() => {
  return moduleInfo.value?.activity_phase || null;
});

const getGradeColor = (score) => {
  if (score >= 85) return 'text-green-600';
  if (score >= 70) return 'text-blue-600';
  if (score >= 55) return 'text-yellow-600';
  return 'text-red-600';
};

const getGradeLetter = (score) => {
  if (score >= 85) return 'A';
  if (score >= 70) return 'B';
  if (score >= 55) return 'C';
  return 'D';
};

const overallScore = computed(() => {
  if (!props.result?.final_score) return null;
  return Math.round(props.result.final_score);
});

const hasResult = computed(() => {
  return props.result && props.result.assessed_at;
});

const isPassed = computed(() => {
  if (!overallScore.value || !props.assessment?.passing_score) return false;
  return overallScore.value >= props.assessment.passing_score;
});


</script>

<template>
  <Head :title="`Penilaian: ${assessment.title}`" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ assessment.title }}</h1>
            <p class="mt-1 text-sm text-gray-600" v-if="assessment.description">{{ assessment.description }}</p>
          </div>
          <div class="flex items-center space-x-4">
            <Badge :type="hasResult ? (isPassed ? 'green' : 'red') : 'gray'">
              {{ hasResult ? (isPassed ? 'Lulus' : 'Tidak Lulus') : 'Belum Dinilai' }}
            </Badge>
            <div v-if="hasResult && overallScore !== null" class="text-right">
              <div class="text-2xl font-bold" :class="getGradeColor(overallScore)">
                {{ overallScore }}
              </div>
              <div class="text-sm text-gray-600">
                Grade {{ getGradeLetter(overallScore) }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <div class="p-6 space-y-6">
        <!-- Assessment Overview -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h2 class="text-lg font-medium text-gray-900 mb-4">Ringkasan Penilaian</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
              <div class="bg-blue-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-blue-900">Modul</p>
                    <p class="text-lg font-semibold text-blue-700">{{ moduleInfo?.name || 'Assessment' }}</p>
                  </div>
                </div>
              </div>

              <div class="bg-green-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-green-900">Metode Perhitungan</p>
                    <p class="text-lg font-semibold text-green-700">{{ assessment.calculation_method === 'SUM' ? 'Penjumlahan' : 'Rata-rata' }}</p>
                  </div>
                </div>
              </div>

              <div class="bg-purple-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-purple-900">Nilai Kelulusan</p>
                    <p class="text-lg font-semibold text-purple-700">{{ assessment.passing_score || 70 }}</p>
                  </div>
                </div>
              </div>

              <div class="bg-yellow-50 rounded-lg p-4">
                <div class="flex items-center">
                  <svg class="h-8 w-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                  </svg>
                  <div class="ml-4">
                    <p class="text-sm font-medium text-yellow-900">Tanggal Dinilai</p>
                    <p class="text-lg font-semibold text-yellow-700">{{ formatDate(result?.assessed_at) }}</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Overall Score -->
        <div v-if="hasResult && overallScore !== null" class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Nilai Keseluruhan</h3>
            <div class="text-center">
              <div class="inline-flex items-center justify-center w-32 h-32 rounded-full bg-gray-100 mb-4">
                <div class="text-center">
                  <div class="text-4xl font-bold" :class="getGradeColor(overallScore)">
                    {{ overallScore }}
                  </div>
                  <div class="text-sm text-gray-600">dari 100</div>
                </div>
              </div>
              <div class="text-xl font-semibold" :class="getGradeColor(overallScore)">
                Grade {{ getGradeLetter(overallScore) }}
              </div>
              <div class="text-gray-600 mt-2">
                {{ isPassed ? 'Lulus' : 'Tidak Lulus' }}
              </div>
            </div>
          </div>
        </div>

        <!-- Assessment Criteria and Results -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Kriteria Penilaian</h3>
            
            <div v-if="assessment.group_indicators?.length > 0" class="space-y-6">
              <div v-for="(group, groupIndex) in assessment.group_indicators" :key="group.uuid" class="border rounded-lg p-4">
                <div class="flex items-start justify-between mb-4">
                  <div class="flex items-start space-x-3">
                    <div class="flex-shrink-0 w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                      <span class="text-sm font-medium text-blue-600">{{ groupIndex + 1 }}</span>
                    </div>
                    <div>
                      <h4 class="font-medium text-gray-900">{{ group.name }}</h4>
                      <p class="text-sm text-gray-600" v-if="group.description">{{ group.description }}</p>
                    </div>
                  </div>
                  <div v-if="hasResult && result.scores && result.scores[group.id]" class="text-right">
                    <div class="text-lg font-semibold" :class="getGradeColor(result.scores[group.id])">
                      {{ result.scores[group.id] }}
                    </div>
                    <div class="text-sm text-gray-500">Nilai</div>
                  </div>
                </div>

                <!-- Indicators -->
                <div v-if="group.indicators?.length > 0" class="ml-11 space-y-3">
                  <div v-for="(indicator, indicatorIndex) in group.indicators" :key="indicator.uuid" class="bg-gray-50 rounded p-3">
                    <div class="flex items-start justify-between">
                      <div class="flex-1">
                        <div class="font-medium text-sm">{{ indicator.name }}</div>
                        <div class="text-xs text-gray-600" v-if="indicator.description">
                          {{ indicator.description }}
                        </div>
                        
                        <!-- Rubric Criteria -->
                        <div v-if="indicator.sessions?.length > 0" class="mt-3">
                          <div class="text-xs font-medium text-gray-700 mb-2">Kriteria Penilaian:</div>
                          <div class="space-y-3">
                            <div v-for="session in indicator.sessions" :key="session.uuid" class="border rounded p-3 bg-white">
                              <div class="font-medium text-sm text-blue-800 mb-2">{{ session.name }}</div>
                              <div v-if="session.description" class="text-xs text-gray-600 mb-2">{{ session.description }}</div>
                              <div v-if="session.rubrics?.length > 0" class="grid grid-cols-1 md:grid-cols-2 gap-2">
                                <div v-for="rubric in session.rubrics" :key="rubric.uuid" 
                                     class="bg-gray-50 border border-gray-200 rounded p-2">
                                  <div class="flex items-center justify-between mb-1">
                                    <span class="font-medium text-xs text-gray-800">{{ rubric.level }}</span>
                                    <span class="text-xs font-bold text-blue-600">{{ rubric.score }}</span>
                                  </div>
                                  <div class="text-xs text-gray-600">{{ rubric.description }}</div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div v-else class="text-center py-8">
              <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
              </svg>
              <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak Ada Kriteria Penilaian</h3>
              <p class="mt-1 text-sm text-gray-500">
                Assessment ini belum memiliki kriteria penilaian yang ditentukan.
              </p>
            </div>
          </div>
        </div>

        <!-- Feedback -->
        <div v-if="hasResult && result.feedback" class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Umpan Balik</h3>
            <div class="prose max-w-none">
              <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
                <div class="flex items-start space-x-3">
                  <svg class="h-5 w-5 text-blue-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-1l-4 4z"></path>
                  </svg>
                  <div>
                    <h4 class="font-medium text-blue-900">Komentar dari {{ result.assessor?.full_name }}</h4>
                    <div class="text-blue-800 mt-2" v-html="result.feedback"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Assessment Information -->
        <div class="bg-white rounded-lg shadow">
          <div class="p-6">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Penilaian</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <dt class="text-sm font-medium text-gray-500">Status</dt>
                <dd class="mt-1 text-sm text-gray-900">
                  <Badge :type="hasResult ? (isPassed ? 'green' : 'red') : 'gray'">
                    {{ hasResult ? (isPassed ? 'Lulus' : 'Tidak Lulus') : 'Belum Dinilai' }}
                  </Badge>
                </dd>
              </div>
              
              <div v-if="result?.assessor">
                <dt class="text-sm font-medium text-gray-500">Penilai</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ result.assessor.full_name }}</dd>
              </div>

              <div v-if="result?.assessed_at">
                <dt class="text-sm font-medium text-gray-500">Tanggal Penilaian</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ formatDate(result.assessed_at) }}</dd>
              </div>

              <div v-if="hasResult && overallScore !== null">
                <dt class="text-sm font-medium text-gray-500">Hasil</dt>
                <dd class="mt-1 text-sm text-gray-900">
                  <span :class="getGradeColor(overallScore)" class="font-semibold">
                    {{ isPassed ? 'Lulus' : 'Tidak Lulus' }}
                  </span>
                </dd>
              </div>

              <div>
                <dt class="text-sm font-medium text-gray-500">Deskripsi</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ assessment.description || '-' }}</dd>
              </div>

              <div>
                <dt class="text-sm font-medium text-gray-500">Metode Perhitungan</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ assessment.calculation_method === 'SUM' ? 'Penjumlahan' : 'Rata-rata' }}</dd>
              </div>

              <div>
                <dt class="text-sm font-medium text-gray-500">Nilai Kelulusan</dt>
                <dd class="mt-1 text-sm text-gray-900">{{ assessment.passing_score || 70 }}</dd>
              </div>
            </div>
          </div>
        </div>

        <!-- Status Information -->
        <div v-if="!hasResult" class="bg-yellow-50 border border-yellow-200 rounded-lg p-6">
          <div class="flex items-start space-x-3">
            <svg class="h-6 w-6 text-yellow-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <div>
              <h3 class="text-lg font-medium text-yellow-900">Menunggu Penilaian</h3>
              <p class="text-yellow-800 mt-1">
                Penilaian ini akan dilakukan oleh instruktur atau penilai yang ditunjuk. 
                Anda akan mendapatkan notifikasi ketika hasil penilaian sudah tersedia.
              </p>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="flex justify-between items-center bg-white rounded-lg shadow p-6">
          <OutlineButton 
            type="secondary" 
            @click="$inertia.get(route('office.myProfile.activity.trainingProgram.learn', activity.uuid))"
          >
            Kembali ke Pembelajaran
          </OutlineButton>
          
          <div class="space-x-3">
            <OutlineButton 
              type="secondary" 
              @click="$inertia.get(route('office.myProfile.activity.trainingProgram.show', activity.uuid))"
            >
              Lihat Aktivitas
            </OutlineButton>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 