<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref } from 'vue';

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
  { label: props.activity.title, href: route('office.myProfile.activity.trainingProgram.show', props.activity.uuid) },
  { label: 'Sertifikat', href: '#' }
];

const isDownloading = ref(false);

const formatDate = (date) => {
  if (!date) return '-';
  return new Date(date).toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};

const downloadCertificate = () => {
  isDownloading.value = true;
  
  // Download PDF certificate
  window.open(
    route('office.myProfile.activity.trainingProgram.downloadCertificate', props.activity.uuid),
    '_blank'
  );
  
  setTimeout(() => {
    isDownloading.value = false;
  }, 2000);
};

const shareCertificate = () => {
  // Share certificate URL or generate share link
  const shareUrl = route('office.myProfile.activity.trainingProgram.certificate', props.activity.uuid);
  
  if (navigator.share) {
    navigator.share({
      title: `Sertifikat - ${props.activity.title}`,
      text: `Saya telah menyelesaikan pelatihan "${props.activity.title}"`,
      url: shareUrl
    });
  } else {
    // Fallback: copy to clipboard
    navigator.clipboard.writeText(shareUrl).then(() => {
      alert('Link sertifikat telah disalin ke clipboard!');
    });
  }
};

const getCurrentDate = () => {
  return new Date().toLocaleDateString('id-ID', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  });
};
</script>

<template>
  <Head title="Sertifikat Pelatihan" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">Sertifikat Pelatihan</h1>
            <p class="mt-1 text-sm text-gray-600">
              Sertifikat penyelesaian untuk "{{ activity.title }}"
            </p>
          </div>
          <div class="flex items-center space-x-4">
            <Badge type="green">Selesai</Badge>
            <OutlineButton @click="downloadCertificate" :loading="isDownloading" type="primary">
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-4-4m4 4l4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              Download PDF
            </OutlineButton>
          </div>
        </div>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <div class="p-6">
        <!-- Certificate Preview -->
        <div class="max-w-4xl mx-auto">
          <!-- Certificate Card -->
          <div class="bg-white rounded-lg shadow-lg overflow-hidden border-2 border-gray-200">
            <!-- Certificate Header -->
            <div class="bg-gradient-to-r from-blue-600 to-purple-600 text-white p-8 text-center">
              <div class="mb-4">
                <svg class="mx-auto h-16 w-16 text-white" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M12 2L3.09 8.26L4 9L12 2L20 9L20.91 8.26L12 2ZM21 16V10.09L12 16L3 10.09V16H21ZM12 18L21 12V18C21 19.1 20.1 20 19 20H5C3.9 20 3 19.1 3 18V12L12 18Z"/>
                </svg>
              </div>
              <h1 class="text-3xl font-bold mb-2">SERTIFIKAT PELATIHAN</h1>
              <p class="text-xl">Certificate of Training Completion</p>
            </div>

            <!-- Certificate Body -->
            <div class="p-8 text-center">
              <div class="mb-8">
                <p class="text-lg text-gray-600 mb-4">Dengan ini menyatakan bahwa</p>
                <h2 class="text-4xl font-bold text-gray-900 mb-2">{{ participant.profile?.full_name }}</h2>
                <p class="text-lg text-gray-600">telah berhasil menyelesaikan pelatihan</p>
              </div>

              <div class="mb-8 py-6 px-8 bg-gray-50 rounded-lg">
                <h3 class="text-2xl font-bold text-blue-600 mb-2">{{ activity.title }}</h3>
                <p class="text-gray-700" v-if="activity.description">{{ activity.description }}</p>
                
                <div class="mt-4 grid grid-cols-1 md:grid-cols-3 gap-4 text-sm">
                  <div class="bg-white p-3 rounded border">
                    <div class="font-medium text-gray-500">Tanggal Mulai</div>
                    <div class="text-gray-900">{{ formatDate(activity.start_date) }}</div>
                  </div>
                  <div class="bg-white p-3 rounded border">
                    <div class="font-medium text-gray-500">Tanggal Selesai</div>
                    <div class="text-gray-900">{{ formatDate(participant.completion_date) }}</div>
                  </div>
                  <div class="bg-white p-3 rounded border">
                    <div class="font-medium text-gray-500">Progress</div>
                    <div class="text-gray-900">{{ participant.overall_progress || 100 }}%</div>
                  </div>
                </div>
              </div>

              <!-- Training Program Details -->
              <div v-if="activity.training_program" class="mb-8">
                <h4 class="text-lg font-semibold text-gray-900 mb-4">Detail Program Pelatihan</h4>
                <div class="text-left bg-gray-50 rounded-lg p-6">
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h5 class="font-medium text-gray-900 mb-2">Fase Pembelajaran</h5>
                      <ul class="space-y-1 text-sm text-gray-700">
                        <li v-for="(phase, index) in activity.training_program.phases" :key="phase.uuid" class="flex items-center">
                          <svg class="h-4 w-4 text-green-500 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                          </svg>
                          {{ phase.name }}
                        </li>
                      </ul>
                    </div>
                    <div>
                      <h5 class="font-medium text-gray-900 mb-2">Statistik Pembelajaran</h5>
                      <div class="space-y-2 text-sm">
                        <div class="flex justify-between">
                          <span class="text-gray-600">Total Fase:</span>
                          <span class="font-medium">{{ activity.training_program.phases?.length || 0 }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Total Modul:</span>
                          <span class="font-medium">
                            {{ activity.training_program.phases?.reduce((total, phase) => total + (phase.modules?.length || 0), 0) || 0 }}
                          </span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Durasi:</span>
                          <span class="font-medium">
                            {{ Math.ceil((new Date(activity.end_date) - new Date(activity.start_date)) / (1000 * 60 * 60 * 24)) }} hari
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Certificate Footer -->
              <div class="border-t border-gray-200 pt-8">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                  <div class="text-center">
                    <div class="mb-4">
                      <div class="h-16 border-b border-gray-300 mx-8"></div>
                    </div>
                    <div class="text-sm">
                      <div class="font-medium">Direktur QRD</div>
                      <div class="text-gray-600">Quality Resource Development</div>
                    </div>
                  </div>
                  <div class="text-center">
                    <div class="mb-4">
                      <div class="text-sm text-gray-600">Diterbitkan pada</div>
                      <div class="font-medium">{{ formatDate(participant.completion_date) }}</div>
                    </div>
                    <div class="text-xs text-gray-500">
                      <div>Certificate ID: {{ participant.certificate_id || `CERT-${activity.uuid.substring(0, 8).toUpperCase()}` }}</div>
                      <div class="mt-1">Valid dan dapat diverifikasi secara online</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Certificate Border Decoration -->
            <div class="h-4 bg-gradient-to-r from-blue-600 to-purple-600"></div>
          </div>

          <!-- Action Buttons -->
          <div class="mt-8 flex justify-center space-x-4">
            <OutlineButton @click="downloadCertificate" :loading="isDownloading" type="primary" size="lg">
              <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 10v6m0 0l-4-4m4 4l4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
              Download PDF
            </OutlineButton>
            
            <OutlineButton @click="shareCertificate" type="secondary" size="lg">
              <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.367 2.684 3 3 0 00-5.367-2.684z"></path>
              </svg>
              Bagikan
            </OutlineButton>
            
            <OutlineButton 
              @click="window.print()" 
              type="secondary" 
              size="lg"
            >
              <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"></path>
              </svg>
              Print
            </OutlineButton>
          </div>
        </div>

        <!-- Certificate Information -->
        <div class="max-w-4xl mx-auto mt-8 bg-white rounded-lg shadow p-6">
          <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Sertifikat</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <dt class="text-sm font-medium text-gray-500">Nama Peserta</dt>
              <dd class="mt-1 text-sm text-gray-900">{{ participant.profile?.full_name }}</dd>
            </div>
            <div>
              <dt class="text-sm font-medium text-gray-500">Area/Departemen</dt>
              <dd class="mt-1 text-sm text-gray-900">{{ participant.profile?.area?.name || '-' }}</dd>
            </div>
            <div>
              <dt class="text-sm font-medium text-gray-500">Tanggal Mulai</dt>
              <dd class="mt-1 text-sm text-gray-900">{{ formatDate(activity.start_date) }}</dd>
            </div>
            <div>
              <dt class="text-sm font-medium text-gray-500">Tanggal Selesai</dt>
              <dd class="mt-1 text-sm text-gray-900">{{ formatDate(participant.completion_date) }}</dd>
            </div>
            <div>
              <dt class="text-sm font-medium text-gray-500">Progress Akhir</dt>
              <dd class="mt-1 text-sm text-gray-900">{{ participant.overall_progress || 100 }}%</dd>
            </div>
            <div>
              <dt class="text-sm font-medium text-gray-500">Certificate ID</dt>
              <dd class="mt-1 text-sm text-gray-900 font-mono">
                {{ participant.certificate_id || `CERT-${activity.uuid.substring(0, 8).toUpperCase()}` }}
              </dd>
            </div>
          </div>
        </div>

        <!-- Navigation -->
        <div class="max-w-4xl mx-auto mt-8 flex justify-between items-center">
          <OutlineButton 
            type="secondary" 
            @click="$inertia.get(route('office.myProfile.activity.trainingProgram.show', activity.uuid))"
          >
            Kembali ke Aktivitas
          </OutlineButton>
          
          <OutlineButton 
            type="secondary" 
            @click="$inertia.get(route('office.myProfile.activity.trainingProgram.index'))"
          >
            Daftar Aktivitas
          </OutlineButton>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template>

<style>
@media print {
  .no-print {
    display: none !important;
  }
  
  .print-break {
    page-break-before: always;
  }
  
  body {
    background: white !important;
  }
}
</style> 