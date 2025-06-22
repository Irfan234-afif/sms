<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { computed } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  attempt: {
    type: Object,
    required: true
  },
  quizId: {
    type: [Number, String],
    default: null
  }
});

// Check if quiz is awaiting manual grading
const isAwaitingGrading = computed(() => {
  return props.attempt.completed_at && 
         (props.attempt.score === null || props.attempt.score === undefined) &&
         !props.attempt.graded_at;
});

// Check if quiz has been graded
const isGraded = computed(() => {
  return props.attempt.graded_at && 
         (props.attempt.score !== null && props.attempt.score !== undefined);
});

// Get the quiz data (prioritize activity quiz over legacy quiz)
const quizData = computed(() => {
  return props.attempt.activity_quiz || props.attempt.quiz;
});

const breadcrumbs = computed(() => [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') },
  { label: props.activity.title, href: route('office.myProfile.activity.trainingProgram.show', props.activity.uuid) },
  { label: `Hasil Kuis: ${quizData.value?.title || 'Quiz'}`, href: '#' }
]);

const scoreColor = computed(() => {
  if (props.attempt.passed) {
    return 'text-green-600';
  }
  return 'text-red-600';
});

const scoreBadgeType = computed(() => {
  if (isAwaitingGrading.value) {
    return 'orange';
  }
  if (props.attempt.passed) {
    return 'green';
  }
  return 'red';
});

const getResultIcon = () => {
  if (props.attempt.passed) {
    return `
      <svg class="w-16 h-16 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
      </svg>
    `;
  }
  return `
    <svg class="w-16 h-16 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
    </svg>
  `;
  };

const getTotalQuestions = computed(() => {
  return quizData.value?.questions ? quizData.value.questions.length : 0;
});

const getCorrectAnswers = computed(() => {
  if (!props.attempt.answers || !quizData.value?.questions) {
    return 0;
  }

  let correct = 0;
  quizData.value.questions.forEach(question => {
    const userAnswer = props.attempt.answers[question.id];
    const correctOption = question.options.find(option => option.is_correct);
    
    if (correctOption && userAnswer == correctOption.id) {
      correct++;
    }
  });

  return correct;
});

const getIncorrectAnswers = computed(() => {
  return getTotalQuestions.value - getCorrectAnswers.value;
});

// Computed property for quiz ID
const reviewQuizId = computed(() => {
  const quizId = props.quizId || 
                 props.attempt.activity_quiz_id || 
                 props.attempt.quiz_id || 
                 props.attempt.activity_quiz?.id || 
                 props.attempt.quiz?.id;
  
  return quizId;
});

// Computed property for review URL
const reviewUrl = computed(() => {
  if (!reviewQuizId.value) {
    return null;
  }
  
  const url = route('office.myProfile.activity.trainingProgram.takeQuiz', {
    activityUuid: props.activity.uuid,
    quizId: reviewQuizId.value,
    review: 'true'
  });
  
  return url;
});

// Navigation functions
const goToActivity = () => {
  router.get(route('office.myProfile.activity.trainingProgram.show', props.activity.uuid));
};

const goToReview = () => {
  if (reviewUrl.value) {
    router.get(reviewUrl.value);
  }
};

const goToLearn = () => {
  router.get(route('office.myProfile.activity.trainingProgram.learn', props.activity.uuid));
};
</script>

<template>
  <Head :title="`Hasil Kuis: ${quizData?.title || 'Quiz'}`" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">Hasil Kuis: {{ quizData?.title || 'Quiz' }}</h1>
            <p class="mt-1 text-sm text-gray-600">Hasil pengerjaan kuis telah tersimpan</p>
          </div>
          <Badge :type="scoreBadgeType">
            {{ isAwaitingGrading ? 'MENUNGGU KOREKSI' : (attempt.passed ? 'LULUS' : 'BELUM LULUS') }}
          </Badge>
        </div>
      </div>
    </template>
    
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    
    <template #content>
      <div class="max-w-4xl mx-auto py-8">
        <!-- Awaiting Grading Status -->
        <div v-if="isAwaitingGrading" class="bg-orange-50 border border-orange-200 rounded-lg p-8 mb-8">
          <div class="text-center">
            <!-- Waiting Icon -->
            <div class="flex justify-center mb-6">
              <svg class="w-16 h-16 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
            </div>
            
            <!-- Status Message -->
            <h3 class="text-2xl font-bold text-orange-800 mb-4">
              Quiz Sedang Menunggu Koreksi
            </h3>
            <p class="text-lg text-orange-700 mb-6">
              Jawaban Anda telah berhasil dikirim dan sedang menunggu koreksi dari instruktur. 
              Hasil akan ditampilkan setelah proses koreksi selesai.
            </p>
            
            <!-- Quick Info -->
            <div class="bg-white rounded-lg p-4 mb-6 inline-block">
              <div class="text-sm text-gray-600 space-y-1">
                <div><strong>Tanggal Submit:</strong> {{ new Date(attempt.completed_at).toLocaleString('id-ID') }}</div>
                <div><strong>Total Soal:</strong> {{ getTotalQuestions }}</div>
                <div><strong>Percobaan ke:</strong> {{ attempt.attempt_number }}</div>
              </div>
            </div>

            <!-- Action Buttons -->
            <div class="flex justify-center space-x-4">
              <OutlineButton @click="goToActivity" type="secondary">
                Kembali ke Aktivitas
              </OutlineButton>
              <OutlineButton @click="goToLearn" type="primary">
                Lanjut Belajar
              </OutlineButton>
            </div>
          </div>
        </div>

        <!-- Result Summary Card (only show when graded) -->
        <div v-else class="bg-white rounded-lg shadow-sm p-8 mb-8">
          <div class="text-center">
            <!-- Result Icon -->
            <div class="flex justify-center mb-6" v-html="getResultIcon()"></div>
            
            <!-- Score Display -->
            <div class="mb-6">
              <div class="text-4xl font-bold mb-2" :class="scoreColor">
                {{ Math.round(attempt.score) }}%
              </div>
              <div class="text-lg text-gray-600">
                {{ attempt.passed ? 'Selamat! Anda telah lulus kuis ini.' : 'Maaf, Anda belum mencapai nilai kelulusan.' }}
              </div>
              <div v-if="attempt.graded_at" class="text-sm text-gray-500 mt-2">
                <p><strong>Dikoreksi pada:</strong> {{ new Date(attempt.graded_at).toLocaleString('id-ID') }}</p>
              </div>
              <div v-if="attempt.grader_feedback" class="mt-4 p-4 bg-blue-50 rounded-lg">
                <h4 class="font-medium text-blue-800 mb-2">Feedback dari Instruktur:</h4>
                <p class="text-blue-700 italic">"{{ attempt.grader_feedback }}"</p>
              </div>
            </div>

            <!-- Quick Stats -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
              <div class="bg-blue-50 rounded-lg p-4">
                <div class="text-2xl font-bold text-blue-600">{{ getTotalQuestions }}</div>
                <div class="text-sm text-blue-800">Total Soal</div>
              </div>
              <div class="bg-green-50 rounded-lg p-4">
                <div class="text-2xl font-bold text-green-600">{{ getCorrectAnswers }}</div>
                <div class="text-sm text-green-800">Jawaban Benar</div>
              </div>
              <div class="bg-red-50 rounded-lg p-4">
                <div class="text-2xl font-bold text-red-600">{{ getIncorrectAnswers }}</div>
                <div class="text-sm text-red-800">Jawaban Salah</div>
              </div>
            </div>

            <!-- Actions -->
            <div class="flex justify-center space-x-4">
              <OutlineButton 
                @click="goToActivity"
                type="secondary"
              >
                Kembali ke Aktivitas
              </OutlineButton>
              
              <OutlineButton 
                v-if="reviewUrl"
                @click="goToReview"
                type="primary"
              >
                Review Jawaban
              </OutlineButton>
              
              <div v-else class="text-sm text-red-600">
                Quiz ID tidak ditemukan untuk review
              </div>
              
              <OutlineButton 
                @click="goToLearn"
                type="primary"
              >
                Lanjut Belajar
              </OutlineButton>
            </div>
          </div>
        </div>

        <!-- Detailed Results (only show when graded) -->
        <div v-if="!isAwaitingGrading" class="bg-white rounded-lg shadow-sm p-6">
          <h3 class="text-lg font-semibold text-gray-900 mb-6">Detail Hasil</h3>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <!-- Quiz Info -->
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Informasi Kuis</h4>
              <div class="space-y-2 text-sm">
                <div class="flex justify-between">
                  <span class="text-gray-600">Judul Kuis:</span>
                  <span class="font-medium">{{ quizData?.title || 'Quiz' }}</span>
                </div>
                <div class="flex justify-between">
                  <span class="text-gray-600">Nilai Kelulusan:</span>
                  <span class="font-medium">{{ quizData?.passing_score || 0 }}%</span>
                </div>
                <div class="flex justify-between">
                  <span class="text-gray-600">Percobaan ke:</span>
                  <span class="font-medium">{{ attempt.attempt_number }}</span>
                </div>
                <div class="flex justify-between">
                  <span class="text-gray-600">Waktu Pengerjaan:</span>
                  <span class="font-medium">{{ attempt.formatted_duration || '-' }}</span>
                </div>
              </div>
            </div>

            <!-- Performance Breakdown -->
            <div>
              <h4 class="font-medium text-gray-900 mb-3">Performa</h4>
              <div class="space-y-3">
                <!-- Correct Answers Bar -->
                <div>
                  <div class="flex justify-between text-sm mb-1">
                    <span class="text-gray-600">Jawaban Benar</span>
                    <span class="font-medium text-green-600">{{ getCorrectAnswers }}/{{ getTotalQuestions }}</span>
                  </div>
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div 
                      class="bg-green-500 h-2 rounded-full transition-all duration-500" 
                      :style="`width: ${(getCorrectAnswers / getTotalQuestions) * 100}%`"
                    ></div>
                  </div>
                </div>

                <!-- Score Bar -->
                <div>
                  <div class="flex justify-between text-sm mb-1">
                    <span class="text-gray-600">Skor</span>
                    <span class="font-medium" :class="scoreColor">{{ Math.round(attempt.score) }}%</span>
                  </div>
                  <div class="w-full bg-gray-200 rounded-full h-2">
                    <div 
                      :class="attempt.passed ? 'bg-green-500' : 'bg-red-500'"
                      class="h-2 rounded-full transition-all duration-500" 
                      :style="`width: ${attempt.score}%`"
                    ></div>
                  </div>
                </div>

                <!-- Passing Score Indicator -->
                <div class="text-xs text-gray-500 mt-2">
                  Minimum untuk lulus: {{ quizData?.passing_score || 0 }}%
                </div>
              </div>
            </div>
          </div>

          <!-- Status Message -->
          <div class="mt-6 p-4 rounded-lg" :class="attempt.passed ? 'bg-green-50 border border-green-200' : 'bg-red-50 border border-red-200'">
            <div class="flex items-start space-x-3">
              <div class="flex-shrink-0">
                <svg v-if="attempt.passed" class="w-5 h-5 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                <svg v-else class="w-5 h-5 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.732-.833-2.5 0L4.268 15.5c-.77.833.192 2.5 1.732 2.5z"></path>
                </svg>
              </div>
              <div class="flex-1">
                <h4 class="font-medium" :class="attempt.passed ? 'text-green-900' : 'text-red-900'">
                  {{ attempt.passed ? 'Kuis Berhasil Diselesaikan' : 'Kuis Belum Lulus' }}
                </h4>
                <p class="text-sm" :class="attempt.passed ? 'text-green-800' : 'text-red-800'">
                  <span v-if="attempt.passed">
                    Anda telah berhasil menyelesaikan kuis ini dengan nilai {{ Math.round(attempt.score) }}%. 
                    Anda dapat melanjutkan ke materi atau modul berikutnya.
                  </span>
                  <span v-else>
                    Nilai Anda adalah {{ Math.round(attempt.score) }}%, masih di bawah nilai kelulusan {{ quizData?.passing_score || 0 }}%. 
                    Silakan pelajari kembali materi dan coba ulangi kuis jika diperbolehkan.
                  </span>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 