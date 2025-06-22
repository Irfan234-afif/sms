<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
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
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Aktivitas Pelatihan', href: route('office.qrd.activity.training-program-activity.index') },
  { label: props.activity.title, href: route('office.qrd.activity.training-program-activity.show', props.activity.uuid) },
  { label: 'Sertifikat Peserta', href: '#' }
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
  
  window.open(
    route('office.qrd.activity.training-program-activity.downloadParticipantCertificate', {
      uuid: props.activity.uuid,
      participantUuid: props.participant.uuid
    }),
    '_blank'
  );
  
  setTimeout(() => {
    isDownloading.value = false;
  }, 2000);
};
</script>

<template>
  <Head title="Sertifikat Peserta" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">Sertifikat Peserta</h1>
            <p class="mt-1 text-sm text-gray-600">
              Sertifikat untuk {{ participant.profile?.name }} - "{{ activity.title }}"
            </p>
          </div>
          <div class="flex items-center space-x-4">
            <Badge type="green">Sertifikat Diterbitkan</Badge>
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
      <QRDSidebar />
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
                <h2 class="text-4xl font-bold text-gray-900 mb-2">{{ participant.profile?.name }}</h2>
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

              <!-- Participant Details -->
              <div class="mb-8">
                <h4 class="text-lg font-semibold text-gray-900 mb-4">Detail Peserta</h4>
                <div class="text-left bg-gray-50 rounded-lg p-6">
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h5 class="font-medium text-gray-900 mb-2">Informasi Peserta</h5>
                      <div class="space-y-2 text-sm">
                        <div class="flex justify-between">
                          <span class="text-gray-600">Nama:</span>
                          <span class="font-medium">{{ participant.profile?.name }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Email:</span>
                          <span class="font-medium">{{ participant.profile?.email }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Area:</span>
                          <span class="font-medium">{{ participant.profile?.area?.name || 'N/A' }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Posisi:</span>
                          <span class="font-medium">{{ participant.profile?.position || 'N/A' }}</span>
                        </div>
                      </div>
                    </div>
                    <div>
                      <h5 class="font-medium text-gray-900 mb-2">Statistik Pelatihan</h5>
                      <div class="space-y-2 text-sm">
                        <div class="flex justify-between">
                          <span class="text-gray-600">Tanggal Daftar:</span>
                          <span class="font-medium">{{ formatDate(participant.enrollment_date) }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Progress:</span>
                          <span class="font-medium">{{ participant.overall_progress }}%</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Nomor Sertifikat:</span>
                          <span class="font-medium">{{ participant.certificate_number }}</span>
                        </div>
                        <div class="flex justify-between">
                          <span class="text-gray-600">Status:</span>
                          <Badge type="green" class="text-xs">Selesai</Badge>
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
                      <div>Certificate ID: {{ participant.certificate_number }}</div>
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

            <Link :href="route('office.qrd.activity.training-program-activity.show', activity.uuid)">
              <OutlineButton type="secondary" size="lg">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                </svg>
                Kembali
              </OutlineButton>
            </Link>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template>

<style scoped>
@media print {
  .no-print {
    display: none !important;
  }
}
</style> 