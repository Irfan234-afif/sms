<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head, useForm, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, computed, onMounted } from 'vue';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  quiz: {
    type: Object,
    required: true
  },
  attempt: {
    type: Object,
    required: true
  },
  questions: {
    type: Array,
    default: () => []
  },
  reviewMode: {
    type: Boolean,
    default: false
  }
});

// Use questions from props first, then fallback to quiz.questions
const quizQuestions = computed(() => {
  return props.questions.length > 0 ? props.questions : (props.quiz.questions || []);
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') },
  { label: props.activity.title, href: route('office.myProfile.activity.trainingProgram.show', props.activity.uuid) },
  { label: `Kuis: ${props.quiz.title}`, href: '#' }
];

const currentQuestionIndex = ref(0);
const answers = ref({});
const showSubmitConfirmation = ref(false);
const isSaving = ref(false);

const form = useForm({
  attempt_id: props.attempt.id,
  answers: {}
});

// Initialize answers
quizQuestions.value.forEach((question) => {
  // Convert question.id to string for consistent key format in attempt.answers
  const questionKey = String(question.id);
  const existingAnswer = props.attempt?.answers?.[questionKey];
  
  // Initialize based on question type
  if (question.type === 'multiple_select') {
    // For multiple select, store as array of option IDs
    if (existingAnswer && Array.isArray(existingAnswer)) {
      answers.value[question.id] = existingAnswer.map(id => parseInt(id));
    } else if (existingAnswer && !Array.isArray(existingAnswer)) {
      answers.value[question.id] = [parseInt(existingAnswer)];
    } else {
      answers.value[question.id] = [];
    }
  } else if (question.type === 'essay') {
    // For essay, store as string
    answers.value[question.id] = existingAnswer || '';
  } else if (question.type === 'true_false') {
    // For true/false, store as boolean string
    if (existingAnswer === 'true' || existingAnswer === 'false') {
      answers.value[question.id] = existingAnswer;
    } else {
      answers.value[question.id] = null;
    }
  } else if (question.type === 'multiple_choice') {
    // For multiple choice, store as integer option ID
    if (existingAnswer !== null && existingAnswer !== undefined && existingAnswer !== '') {
      answers.value[question.id] = parseInt(existingAnswer);
    } else {
      answers.value[question.id] = null;
    }
  } else {
    // Default case
    answers.value[question.id] = existingAnswer || null;
  }
});

const currentQuestion = computed(() => {
  const question = quizQuestions.value[currentQuestionIndex.value];
  if (!question) return {};
  
  // Ensure we have the correct question text field
  return {
    ...question,
    question: question.question || question.question_text || '',
    options: question.options || []
  };
});

const isLastQuestion = computed(() => {
  return currentQuestionIndex.value === quizQuestions.value.length - 1;
});

const isFirstQuestion = computed(() => {
  return currentQuestionIndex.value === 0;
});

// Helper function to check if a question is answered
const isQuestionAnswered = (question) => {
  if (!question || !question.id) return false;
  
  const answer = answers.value[question.id];
  
  switch (question.type) {
    case 'multiple_select':
      return Array.isArray(answer) && answer.length > 0;
    case 'essay':
      return typeof answer === 'string' && answer.trim().length > 0;
    case 'true_false':
      return answer === 'true' || answer === 'false';
    case 'multiple_choice':
      return answer !== null && answer !== undefined && answer !== '';
    default:
      return answer !== null && answer !== undefined && answer !== '';
  }
};

const answeredQuestions = computed(() => {
  return quizQuestions.value.filter(question => isQuestionAnswered(question)).length;
});

const allQuestionsAnswered = computed(() => {
  if (quizQuestions.value.length === 0) return false;
  return answeredQuestions.value === quizQuestions.value.length;
});

const nextQuestion = () => {
  if (!isLastQuestion.value) {
    currentQuestionIndex.value++;
  }
};

const previousQuestion = () => {
  if (!isFirstQuestion.value) {
    currentQuestionIndex.value--;
  }
};

const goToQuestion = (index) => {
  currentQuestionIndex.value = index;
};

const selectAnswer = (questionId, answerId) => {
  // Disable selection in review mode
  if (props.reviewMode) return;
  
  const question = quizQuestions.value.find(q => q.id === questionId);
  if (!question) return;
  
  if (question.type === 'multiple_choice') {
    // Single selection - store as integer
  answers.value[questionId] = parseInt(answerId);
  } else if (question.type === 'multiple_select') {
    // Multiple selection - toggle in array
    if (!Array.isArray(answers.value[questionId])) {
      answers.value[questionId] = [];
    }
    const currentAnswers = [...answers.value[questionId]];
    const optionId = parseInt(answerId);
    const existingIndex = currentAnswers.indexOf(optionId);
    
    if (existingIndex > -1) {
      currentAnswers.splice(existingIndex, 1);
    } else {
      currentAnswers.push(optionId);
    }
    answers.value[questionId] = currentAnswers;
  } else if (question.type === 'true_false') {
    // True/False selection
    answers.value[questionId] = answerId;
  }
  
  // Auto-save answers
  saveAnswers();
};

const updateEssayAnswer = (questionId, value) => {
  // Disable editing in review mode
  if (props.reviewMode) return;
  
  answers.value[questionId] = value;
  
  // Debounced auto-save for essay questions
  clearTimeout(window.essayTimeout);
  window.essayTimeout = setTimeout(() => {
    saveAnswers();
  }, 1000);
};

const saveAnswers = async () => {
  // Don't save in review mode
  if (props.reviewMode || isSaving.value) return;
  
  try {
    isSaving.value = true;
    
    // Prepare answers for saving
    const answersToSave = {};
    
    quizQuestions.value.forEach(question => {
      const answer = answers.value[question.id];
      
      // Only save non-empty answers
      switch (question.type) {
        case 'multiple_choice':
          if (answer !== null && answer !== undefined && answer !== '') {
            answersToSave[question.id] = String(answer);
          }
          break;
        case 'multiple_select':
          if (Array.isArray(answer) && answer.length > 0) {
            answersToSave[question.id] = answer.map(a => String(a));
          }
          break;
        case 'true_false':
          if (answer === 'true' || answer === 'false') {
            answersToSave[question.id] = answer;
          }
          break;
        case 'essay':
          if (typeof answer === 'string' && answer.trim().length > 0) {
            answersToSave[question.id] = answer.trim();
          }
          break;
        default:
          if (answer !== null && answer !== undefined && answer !== '') {
            answersToSave[question.id] = answer;
          }
      }
    });
    
    await window.axios.post(route('office.myProfile.activity.trainingProgram.saveQuizAnswers'), {
      attempt_id: props.attempt.id,
      answers: answersToSave
    });
  } catch (error) {
    console.error('Error saving answers:', error);
  } finally {
    isSaving.value = false;
  }
};

const confirmSubmit = () => {
  showSubmitConfirmation.value = true;
};

const cancelSubmit = () => {
  showSubmitConfirmation.value = false;
};

const submitQuiz = () => {
  // Prepare final answers for submission
  const finalAnswers = {};
  
  quizQuestions.value.forEach(question => {
    const answer = answers.value[question.id];
    
    // Format answers based on question type for submission
    switch (question.type) {
      case 'multiple_choice':
        finalAnswers[question.id] = answer !== null && answer !== undefined ? String(answer) : null;
        break;
      case 'multiple_select':
        finalAnswers[question.id] = Array.isArray(answer) ? answer.map(a => String(a)) : [];
        break;
      case 'true_false':
        finalAnswers[question.id] = answer === 'true' || answer === 'false' ? answer : null;
        break;
      case 'essay':
        finalAnswers[question.id] = typeof answer === 'string' ? answer.trim() : '';
        break;
      default:
        finalAnswers[question.id] = answer;
    }
  });
  
  form.answers = finalAnswers;
  
  form.post(route('office.myProfile.activity.trainingProgram.submitQuiz', {
    activityUuid: props.activity.uuid,
    quizId: props.quiz.id
  }), {
    onSuccess: (page) => {
      // Redirect ke halaman menunggu koreksi
      router.get(route('office.myProfile.activity.trainingProgram.viewQuizResult', {
        activityUuid: props.activity.uuid,
        attemptId: page.props?.attemptId || form.attempt_id
      }));
    },
    onError: (errors) => {
      console.error('Quiz submission error:', errors);
      showSubmitConfirmation.value = false;
    }
  });
};

const getQuestionStatusColor = (index) => {
  const question = quizQuestions.value[index];
  if (!question) return 'bg-gray-200 text-gray-700';
  
  // Review mode coloring
  if (props.reviewMode) {
    const isCorrect = isAnswerCorrect(question.id);
    if (isCorrect === true) {
      return index === currentQuestionIndex.value ? 'bg-green-600 text-white' : 'bg-green-500 text-white';
    } else if (isCorrect === false) {
      return index === currentQuestionIndex.value ? 'bg-red-600 text-white' : 'bg-red-500 text-white';
    } else {
      return index === currentQuestionIndex.value ? 'bg-gray-600 text-white' : 'bg-gray-400 text-white';
    }
  }
  
  // Normal mode coloring - check if question is answered based on type
  const isAnswered = isQuestionAnswered(question);
  
  if (isAnswered) {
    return index === currentQuestionIndex.value ? 'bg-green-600 text-white' : 'bg-green-500 text-white';
  }
  
  if (index === currentQuestionIndex.value) {
    return 'bg-blue-500 text-white';
  }
  
  return 'bg-gray-200 text-gray-700';
};

// Review mode helpers
const getCorrectAnswer = (question) => {
  if (!props.reviewMode) return null;
  
  if (question.type === 'multiple_choice') {
  return question.options.find(option => option.is_correct);
  } else if (question.type === 'multiple_select') {
    return question.options.filter(option => option.is_correct);
  } else if (question.type === 'true_false') {
    return question.correct_answer;
  } else if (question.type === 'essay') {
    return question.correct_answer;
  }
  
  return null;
};

const isAnswerCorrect = (questionId) => {
  if (!props.reviewMode) return null;
  const question = quizQuestions.value.find(q => q.id === questionId);
  if (!question) return false;
  
  const userAnswer = answers.value[questionId];
  
  if (question.type === 'multiple_choice') {
    const correctOption = getCorrectAnswer(question);
  return correctOption && userAnswer === correctOption.id;
  } else if (question.type === 'multiple_select') {
    const correctOptions = getCorrectAnswer(question);
    if (!Array.isArray(userAnswer) || !correctOptions.length) return false;
    
    const correctIds = correctOptions.map(opt => opt.id).sort();
    const userIds = [...userAnswer].sort();
    
    return correctIds.length === userIds.length && 
           correctIds.every((id, index) => id === userIds[index]);
  } else if (question.type === 'true_false') {
    return userAnswer === question.correct_answer;
  } else if (question.type === 'essay') {
    // For essay questions, we can't automatically determine correctness
    // Return null to indicate manual grading required
    return null;
  }
  
  return false;
};

const getAnswerStatus = (questionId, optionId) => {
  if (!props.reviewMode) return null;
  
  const question = quizQuestions.value.find(q => q.id === questionId);
  if (!question || (question.type !== 'multiple_choice' && question.type !== 'multiple_select')) {
    return null;
  }
  
  const userAnswer = answers.value[questionId];
  
  if (question.type === 'multiple_choice') {
  const correctOption = getCorrectAnswer(question);
  const isUserAnswer = userAnswer === optionId;
  const isCorrectAnswer = correctOption && correctOption.id === optionId;
  
  if (isUserAnswer && isCorrectAnswer) return 'correct-user';
  if (isUserAnswer && !isCorrectAnswer) return 'incorrect-user';
  if (!isUserAnswer && isCorrectAnswer) return 'correct-not-selected';
  } else if (question.type === 'multiple_select') {
    const correctOptions = getCorrectAnswer(question);
    const isUserAnswer = Array.isArray(userAnswer) && userAnswer.includes(optionId);
    const isCorrectAnswer = correctOptions.some(opt => opt.id === optionId);
    
    if (isUserAnswer && isCorrectAnswer) return 'correct-user';
    if (isUserAnswer && !isCorrectAnswer) return 'incorrect-user';
    if (!isUserAnswer && isCorrectAnswer) return 'correct-not-selected';
  }
  
  return null;
};

const getQuestionTypeLabel = (type) => {
  const types = {
    'multiple_choice': 'Pilihan Ganda',
    'multiple_select': 'Pilihan Ganda (Multiple)',
    'essay': 'Essay',
    'true_false': 'Benar/Salah'
  };
  return types[type] || type;
};
</script>

<template>
  <Head :title="`Kuis: ${quiz.title}`" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ quiz.title }}</h1>
            <p class="mt-1 text-sm text-gray-600" v-if="quiz.description">{{ quiz.description }}</p>
            <div v-if="reviewMode" class="mt-2">
              <Badge type="blue">Mode Review - Jawaban Tidak Dapat Diubah</Badge>
            </div>
          </div>
          <div class="flex items-center space-x-4">
            <Badge :type="allQuestionsAnswered ? 'green' : 'yellow'">
              {{ answeredQuestions }}/{{ quizQuestions.length }} Terjawab
            </Badge>
            <div v-if="isSaving && !reviewMode" class="flex items-center text-sm text-gray-500">
              <svg class="animate-spin -ml-1 mr-2 h-4 w-4 text-gray-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              Menyimpan...
            </div>
          </div>
        </div>
      </div>
    </template>
    
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    
    <template #content>
      <div v-if="quizQuestions.length === 0" class="flex items-center justify-center h-64">
        <div class="text-center">
          <div class="text-gray-500 mb-2">
            <svg class="mx-auto h-12 w-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
            </svg>
          </div>
          <h3 class="text-lg font-medium text-gray-900">Tidak Ada Soal</h3>
          <p class="text-gray-600">Kuis ini belum memiliki soal yang tersedia.</p>
        </div>
      </div>

      <div v-else class="flex h-full bg-gray-50">
        <!-- Question Navigation Sidebar -->
        <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
          <div class="p-4">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Navigasi Soal</h3>
            
            <!-- Progress Bar -->
            <div class="mb-6">
              <div class="flex items-center justify-between mb-2">
                <span class="text-sm text-gray-600">Progress</span>
                <span class="text-sm font-medium">{{ answeredQuestions }}/{{ quizQuestions.length }}</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div 
                  class="bg-blue-600 h-2 rounded-full transition-all duration-300" 
                  :style="`width: ${(answeredQuestions / quizQuestions.length) * 100}%`"
                ></div>
              </div>
            </div>

            <!-- Question Grid -->
            <div class="grid grid-cols-5 gap-2">
              <button
                v-for="(question, index) in quizQuestions"
                :key="question.id"
                @click="goToQuestion(index)"
                :class="[
                  'w-10 h-10 rounded-lg text-sm font-medium transition-colors',
                  getQuestionStatusColor(index)
                ]"
              >
                {{ index + 1 }}
              </button>
            </div>

            <!-- Legend -->
            <div class="mt-6 space-y-2 text-sm">
              <template v-if="reviewMode">
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-green-500 rounded"></div>
                  <span class="text-gray-600">Jawaban Benar</span>
                </div>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-red-500 rounded"></div>
                  <span class="text-gray-600">Jawaban Salah</span>
                </div>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-gray-400 rounded"></div>
                  <span class="text-gray-600">Tidak Dijawab</span>
                </div>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-green-600 rounded"></div>
                  <span class="text-gray-600">Soal Saat Ini</span>
                </div>
              </template>
              <template v-else>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-green-500 rounded"></div>
                  <span class="text-gray-600">Terjawab</span>
                </div>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-blue-500 rounded"></div>
                  <span class="text-gray-600">Soal Saat Ini</span>
                </div>
                <div class="flex items-center space-x-2">
                  <div class="w-4 h-4 bg-gray-200 rounded"></div>
                  <span class="text-gray-600">Belum Terjawab</span>
                </div>
              </template>
            </div>

            <!-- Quiz Info -->
            <div class="mt-8 p-4 bg-gray-50 rounded-lg">
              <h4 class="font-medium text-gray-900 mb-2">Informasi Kuis</h4>
              <div class="space-y-1 text-sm text-gray-600">
                <div>
                  <span class="font-medium">Total Soal:</span> {{ quizQuestions.length }}
                </div>
                <div v-if="quiz.passing_score">
                  <span class="font-medium">Nilai Lulus:</span> {{ quiz.passing_score }}%
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Main Question Area -->
        <div class="flex-1 flex flex-col">
          <!-- Question Header -->
          <div class="bg-white border-b border-gray-200 p-6">
            <div class="flex items-center justify-between">
              <div>
                <h2 class="text-xl font-semibold text-gray-900">
                  Soal {{ currentQuestionIndex + 1 }} dari {{ quizQuestions.length }}
                </h2>
              </div>
              <div class="flex items-center space-x-3">
                <OutlineButton 
                  @click="previousQuestion" 
                  :disabled="isFirstQuestion"
                  type="secondary"
                >
                  Sebelumnya
                </OutlineButton>
                <OutlineButton 
                  @click="nextQuestion" 
                  :disabled="isLastQuestion"
                  type="primary"
                >
                  Selanjutnya
                </OutlineButton>
              </div>
            </div>
          </div>

          <!-- Question Content -->
          <div class="flex-1 overflow-y-auto p-6">
            <div class="max-w-4xl mx-auto">

              
              <div class="bg-white rounded-lg shadow p-6">
                <!-- No Question State -->
                <div v-if="!currentQuestion || !currentQuestion.id" class="text-center py-8">
                  <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                  <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak Ada Pertanyaan</h3>
                  <p class="mt-1 text-sm text-gray-500">Pertanyaan tidak dapat dimuat atau tidak ada data.</p>
                </div>

                <!-- Question Content -->
                <div v-else>
                  <!-- Question Text and Type -->
                <div class="mb-6">
                    <div class="flex items-center space-x-3 mb-3">
                      <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                        {{ getQuestionTypeLabel(currentQuestion.type) }}
                      </span>
                      <span v-if="currentQuestion.points" class="text-sm text-gray-500">
                        {{ currentQuestion.points }} poin
                      </span>
                    </div>
                    <div class="text-lg font-medium text-gray-900 leading-relaxed">
                      {{ currentQuestion.question || currentQuestion.question_text || 'Pertanyaan tidak tersedia' }}
                    </div>
                </div>

                <!-- Multiple Choice Questions -->
                <div v-if="currentQuestion.type === 'multiple_choice' && currentQuestion.options && currentQuestion.options.length > 0" class="space-y-3">
                  <div 
                    v-for="option in currentQuestion.options" 
                    :key="option.id"
                    @click="selectAnswer(currentQuestion.id, option.id)"
                    :class="[
                      'p-4 border rounded-lg transition-colors',
                      !reviewMode ? 'cursor-pointer' : 'cursor-default',
                      // Normal mode styling
                      !reviewMode && answers[currentQuestion.id] === option.id
                        ? 'border-blue-500 bg-blue-50' 
                        : !reviewMode ? 'border-gray-200 hover:border-gray-300 hover:bg-gray-50' : '',
                      // Review mode styling
                      reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'
                        ? 'border-green-500 bg-green-50'
                        : reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'incorrect-user'
                        ? 'border-red-500 bg-red-50'
                        : reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'correct-not-selected'
                        ? 'border-green-300 bg-green-25'
                        : reviewMode ? 'border-gray-200 bg-gray-50' : ''
                    ]"
                  >
                    <div class="flex items-start space-x-3">
                      <div class="flex-shrink-0 mt-1">
                        <!-- Review mode icons -->
                        <div v-if="reviewMode" class="flex items-center space-x-2">
                          <div 
                            :class="[
                              'w-4 h-4 rounded-full border-2 transition-colors',
                              answers[currentQuestion.id] === option.id
                                ? getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'
                                  ? 'border-green-500 bg-green-500'
                                  : 'border-red-500 bg-red-500'
                                : 'border-gray-300'
                            ]"
                          >
                            <div 
                              v-if="answers[currentQuestion.id] === option.id"
                              class="w-2 h-2 bg-white rounded-full m-0.5"
                            ></div>
                          </div>
                          <!-- Correct answer indicator -->
                          <div v-if="getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'" 
                               class="text-green-600 font-medium text-sm">
                            ✓ Benar
                          </div>
                          <div v-else-if="getAnswerStatus(currentQuestion.id, option.id) === 'incorrect-user'" 
                               class="text-red-600 font-medium text-sm">
                            ✗ Salah
                          </div>
                          <div v-else-if="getAnswerStatus(currentQuestion.id, option.id) === 'correct-not-selected'" 
                               class="text-green-600 font-medium text-sm">
                            ✓ Jawaban Benar
                          </div>
                        </div>
                        
                        <!-- Normal mode radio button -->
                        <div v-else 
                          :class="[
                            'w-4 h-4 rounded-full border-2 transition-colors',
                            answers[currentQuestion.id] === option.id
                              ? 'border-blue-500 bg-blue-500' 
                              : 'border-gray-300'
                          ]"
                        >
                          <div 
                            v-if="answers[currentQuestion.id] === option.id"
                            class="w-2 h-2 bg-white rounded-full m-0.5"
                          ></div>
                        </div>
                      </div>
                      <div class="flex-1">
                        <div class="text-gray-900">
                          {{ option.option_text || option.text || 'Opsi tidak tersedia' }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Multiple Select Questions -->
                <div v-else-if="currentQuestion.type === 'multiple_select' && currentQuestion.options && currentQuestion.options.length > 0" class="space-y-3">
                  <div class="text-sm text-gray-600 mb-4 p-3 bg-blue-50 rounded-lg">
                    <svg class="w-4 h-4 inline mr-1" fill="currentColor" viewBox="0 0 20 20">
                      <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                    </svg>
                    Pilih semua jawaban yang benar (bisa lebih dari satu)
                  </div>
                  <div 
                    v-for="option in currentQuestion.options" 
                    :key="option.id"
                    @click="selectAnswer(currentQuestion.id, option.id)"
                    :class="[
                      'p-4 border rounded-lg transition-colors',
                      !reviewMode ? 'cursor-pointer' : 'cursor-default',
                      // Normal mode styling
                      !reviewMode && Array.isArray(answers[currentQuestion.id]) && answers[currentQuestion.id].includes(option.id)
                        ? 'border-blue-500 bg-blue-50' 
                        : !reviewMode ? 'border-gray-200 hover:border-gray-300 hover:bg-gray-50' : '',
                      // Review mode styling
                      reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'
                        ? 'border-green-500 bg-green-50'
                        : reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'incorrect-user'
                        ? 'border-red-500 bg-red-50'
                        : reviewMode && getAnswerStatus(currentQuestion.id, option.id) === 'correct-not-selected'
                        ? 'border-green-300 bg-green-25'
                        : reviewMode ? 'border-gray-200 bg-gray-50' : ''
                    ]"
                  >
                    <div class="flex items-start space-x-3">
                      <div class="flex-shrink-0 mt-1">
                        <!-- Review mode icons -->
                        <div v-if="reviewMode" class="flex items-center space-x-2">
                          <div 
                            :class="[
                              'w-4 h-4 rounded border-2 transition-colors',
                              Array.isArray(answers[currentQuestion.id]) && answers[currentQuestion.id].includes(option.id)
                                ? getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'
                                  ? 'border-green-500 bg-green-500'
                                  : 'border-red-500 bg-red-500'
                                : 'border-gray-300'
                            ]"
                          >
                            <svg v-if="Array.isArray(answers[currentQuestion.id]) && answers[currentQuestion.id].includes(option.id)" 
                                 class="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                              <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                            </svg>
                          </div>
                          <!-- Correct answer indicator -->
                          <div v-if="getAnswerStatus(currentQuestion.id, option.id) === 'correct-user'" 
                               class="text-green-600 font-medium text-sm">
                            ✓ Benar
                          </div>
                          <div v-else-if="getAnswerStatus(currentQuestion.id, option.id) === 'incorrect-user'" 
                               class="text-red-600 font-medium text-sm">
                            ✗ Salah
                          </div>
                          <div v-else-if="getAnswerStatus(currentQuestion.id, option.id) === 'correct-not-selected'" 
                               class="text-green-600 font-medium text-sm">
                            ✓ Jawaban Benar
                          </div>
                        </div>
                        
                        <!-- Normal mode checkbox -->
                        <div v-else 
                          :class="[
                            'w-4 h-4 rounded border-2 transition-colors',
                            Array.isArray(answers[currentQuestion.id]) && answers[currentQuestion.id].includes(option.id)
                              ? 'border-blue-500 bg-blue-500' 
                              : 'border-gray-300'
                          ]"
                        >
                          <svg v-if="Array.isArray(answers[currentQuestion.id]) && answers[currentQuestion.id].includes(option.id)" 
                               class="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                          </svg>
                        </div>
                      </div>
                      <div class="flex-1">
                        <div class="text-gray-900">
                          {{ option.option_text || option.text || 'Opsi tidak tersedia' }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- True/False Questions -->
                <div v-else-if="currentQuestion.type === 'true_false'" class="space-y-3">
                  <div class="grid grid-cols-2 gap-4">
                    <div 
                      @click="selectAnswer(currentQuestion.id, 'true')"
                      :class="[
                        'p-4 border rounded-lg transition-colors text-center',
                        !reviewMode ? 'cursor-pointer' : 'cursor-default',
                        // Normal mode styling
                        !reviewMode && answers[currentQuestion.id] === 'true'
                          ? 'border-green-500 bg-green-50' 
                          : !reviewMode ? 'border-gray-200 hover:border-gray-300 hover:bg-gray-50' : '',
                        // Review mode styling
                        reviewMode && answers[currentQuestion.id] === 'true'
                          ? currentQuestion.correct_answer === 'true'
                            ? 'border-green-500 bg-green-50'
                            : 'border-red-500 bg-red-50'
                          : reviewMode && currentQuestion.correct_answer === 'true'
                          ? 'border-green-300 bg-green-25'
                          : reviewMode ? 'border-gray-200 bg-gray-50' : ''
                      ]"
                    >
                      <div class="flex flex-col items-center space-y-2">
                        <div 
                          :class="[
                            'w-5 h-5 rounded-full border-2 transition-colors',
                            answers[currentQuestion.id] === 'true'
                              ? reviewMode && currentQuestion.correct_answer === 'true'
                                ? 'border-green-500 bg-green-500'
                                : reviewMode && currentQuestion.correct_answer !== 'true'
                                ? 'border-red-500 bg-red-500'
                                : 'border-green-500 bg-green-500'
                              : 'border-gray-300'
                          ]"
                        >
                          <div 
                            v-if="answers[currentQuestion.id] === 'true'"
                            class="w-2.5 h-2.5 bg-white rounded-full m-0.5"
                          ></div>
                        </div>
                        <span class="font-medium">BENAR</span>
                        <div v-if="reviewMode && answers[currentQuestion.id] === 'true'" class="text-sm">
                          <span v-if="currentQuestion.correct_answer === 'true'" class="text-green-600">✓ Benar</span>
                          <span v-else class="text-red-600">✗ Salah</span>
                        </div>
                        <div v-if="reviewMode && answers[currentQuestion.id] !== 'true' && currentQuestion.correct_answer === 'true'" 
                             class="text-sm text-green-600">✓ Jawaban Benar</div>
                      </div>
                    </div>
                    <div 
                      @click="selectAnswer(currentQuestion.id, 'false')"
                      :class="[
                        'p-4 border rounded-lg transition-colors text-center',
                        !reviewMode ? 'cursor-pointer' : 'cursor-default',
                        // Normal mode styling
                        !reviewMode && answers[currentQuestion.id] === 'false'
                          ? 'border-red-500 bg-red-50' 
                          : !reviewMode ? 'border-gray-200 hover:border-gray-300 hover:bg-gray-50' : '',
                        // Review mode styling
                        reviewMode && answers[currentQuestion.id] === 'false'
                          ? currentQuestion.correct_answer === 'false'
                            ? 'border-green-500 bg-green-50'
                            : 'border-red-500 bg-red-50'
                          : reviewMode && currentQuestion.correct_answer === 'false'
                          ? 'border-green-300 bg-green-25'
                          : reviewMode ? 'border-gray-200 bg-gray-50' : ''
                      ]"
                    >
                      <div class="flex flex-col items-center space-y-2">
                        <div 
                          :class="[
                            'w-5 h-5 rounded-full border-2 transition-colors',
                            answers[currentQuestion.id] === 'false'
                              ? reviewMode && currentQuestion.correct_answer === 'false'
                                ? 'border-green-500 bg-green-500'
                                : reviewMode && currentQuestion.correct_answer !== 'false'
                                ? 'border-red-500 bg-red-500'
                                : 'border-red-500 bg-red-500'
                              : 'border-gray-300'
                          ]"
                        >
                          <div 
                            v-if="answers[currentQuestion.id] === 'false'"
                            class="w-2.5 h-2.5 bg-white rounded-full m-0.5"
                          ></div>
                        </div>
                        <span class="font-medium">SALAH</span>
                        <div v-if="reviewMode && answers[currentQuestion.id] === 'false'" class="text-sm">
                          <span v-if="currentQuestion.correct_answer === 'false'" class="text-green-600">✓ Benar</span>
                          <span v-else class="text-red-600">✗ Salah</span>
                        </div>
                        <div v-if="reviewMode && answers[currentQuestion.id] !== 'false' && currentQuestion.correct_answer === 'false'" 
                             class="text-sm text-green-600">✓ Jawaban Benar</div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Essay Questions -->
                <div v-else-if="currentQuestion.type === 'essay'">
                  <div class="space-y-4">
                    <div v-if="!reviewMode">
                      <label class="block text-sm font-medium text-gray-700 mb-2">
                        Tuliskan jawaban Anda:
                      </label>
                      <el-input
                        v-model="answers[currentQuestion.id]"
                        @input="updateEssayAnswer(currentQuestion.id, $event)"
                        type="textarea"
                        :rows="8"
                        placeholder="Masukkan jawaban essay Anda di sini..."
                        :disabled="reviewMode"
                      />
                    </div>
                    <div v-else class="space-y-4">
                      <div>
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                          Jawaban Anda:
                        </label>
                        <div class="p-4 bg-gray-50 rounded-lg border">
                          <div v-if="answers[currentQuestion.id]" class="whitespace-pre-wrap">
                            {{ answers[currentQuestion.id] }}
                          </div>
                          <div v-else class="text-gray-500 italic">
                            Tidak ada jawaban
                          </div>
                        </div>
                      </div>
                      <div v-if="currentQuestion.correct_answer">
                        <label class="block text-sm font-medium text-gray-700 mb-2">
                          Model Jawaban:
                        </label>
                        <div class="p-4 bg-blue-50 rounded-lg border border-blue-200">
                          <div class="whitespace-pre-wrap">{{ currentQuestion.correct_answer }}</div>
                        </div>
                      </div>
                      <div class="p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
                        <div class="flex items-start space-x-2">
                          <svg class="h-5 w-5 text-yellow-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                          </svg>
                          <div>
                            <p class="text-sm text-yellow-800">
                              <strong>Catatan:</strong> Jawaban essay dinilai secara manual oleh instruktur. 
                              Nilai untuk pertanyaan ini akan diperbarui setelah proses penilaian selesai.
                            </p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Fallback for unknown question types -->
                <div v-else class="p-4 bg-gray-50 border border-gray-200 rounded-lg">
                  <div class="text-center text-gray-600">
                    <svg class="mx-auto h-8 w-8 mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.732-.833-2.5 0L4.268 15.5c-.77.833.192 2.5 1.732 2.5z"/>
                    </svg>
                    <h3 class="font-medium">Tipe Pertanyaan Tidak Dikenal</h3>
                    <p class="text-sm">Tipe: {{ currentQuestion.type || 'undefined' }}</p>
                    <div class="mt-2 text-xs bg-white p-2 rounded border">
                      <strong>Debug Info:</strong>
                      <pre>{{ JSON.stringify(currentQuestion, null, 2) }}</pre>
                    </div>
                  </div>
                </div>

                <!-- Question Image -->
                <div v-if="currentQuestion.image_url" class="mt-6">
                  <img 
                    :src="currentQuestion.image_url" 
                    :alt="currentQuestion.question" 
                    class="max-w-full h-auto rounded-lg"
                  />
                </div>

                  <!-- Question Explanation (Review Mode) -->
                  <div v-if="reviewMode && currentQuestion.explanation" class="mt-6 p-4 bg-gray-50 rounded-lg border">
                    <h5 class="font-medium text-gray-900 mb-2">Penjelasan:</h5>
                    <div class="prose max-w-none text-gray-700" v-html="currentQuestion.explanation"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Bottom Actions -->
          <div class="bg-white border-t border-gray-200 p-6">
            <div class="flex justify-between items-center">
              <div class="text-sm text-gray-600">
                <span v-if="!reviewMode">
                  Soal {{ currentQuestionIndex + 1 }} dari {{ quizQuestions.length }} • 
                  {{ answeredQuestions }} terjawab
                </span>
                <span v-else>
                  Soal {{ currentQuestionIndex + 1 }} dari {{ quizQuestions.length }} • 
                  Review Jawaban
                  <span v-if="isAnswerCorrect(currentQuestion.id) === true" class="text-green-600 font-medium ml-2">
                    ✓ Jawaban Anda Benar
                  </span>
                  <span v-else-if="isAnswerCorrect(currentQuestion.id) === false" class="text-red-600 font-medium ml-2">
                    ✗ Jawaban Anda Salah
                  </span>
                </span>
              </div>
              
              <div class="flex items-center space-x-3">
                <!-- Review mode actions -->
                <template v-if="reviewMode">
                  <OutlineButton 
                    @click="previousQuestion" 
                    :disabled="isFirstQuestion"
                    type="secondary"
                  >
                    Sebelumnya
                  </OutlineButton>
                  
                  <OutlineButton 
                    v-if="!isLastQuestion"
                    @click="nextQuestion"
                    type="primary"
                  >
                    Selanjutnya
                  </OutlineButton>
                  
                  <OutlineButton 
                    v-else
                    @click="router.get(route('office.myProfile.activity.trainingProgram.viewQuizResult', {
                      activityUuid: activity.uuid,
                      attemptId: attempt.id
                    }))"
                    type="primary"
                  >
                    Kembali ke Hasil
                  </OutlineButton>
                </template>
                
                <!-- Normal mode actions -->
                <template v-else>
                  <OutlineButton 
                    @click="previousQuestion" 
                    :disabled="isFirstQuestion"
                    type="secondary"
                  >
                    Sebelumnya
                  </OutlineButton>
                  
                  <OutlineButton 
                    v-if="!isLastQuestion"
                    @click="nextQuestion"
                    type="primary"
                  >
                    Selanjutnya
                  </OutlineButton>
                  
                  <el-button 
                    v-else
                    @click="confirmSubmit"
                    type="primary"
                  >
                    Selesai & Submit
                  </el-button>
                </template>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Submit Confirmation Modal -->
      <el-dialog v-model="showSubmitConfirmation" title="Konfirmasi Submit" width="500px">
        <div class="space-y-4">
          <p class="text-gray-700">
            Apakah Anda yakin ingin mengirimkan jawaban kuis ini?
          </p>
          
          <div class="bg-gray-50 rounded-lg p-4">
            <div class="grid grid-cols-2 gap-4 text-sm">
              <div>
                <span class="text-gray-500">Total Soal:</span>
                <span class="ml-2 font-medium">{{ quizQuestions.length }}</span>
              </div>
              <div>
                <span class="text-gray-500">Terjawab:</span>
                <span class="ml-2 font-medium">{{ answeredQuestions }}</span>
              </div>
              <div>
                <span class="text-gray-500">Belum Terjawab:</span>
                <span class="ml-2 font-medium">{{ quizQuestions.length - answeredQuestions }}</span>
              </div>
              <div>
                <span class="text-gray-500">Progress:</span>
                <span class="ml-2 font-medium">{{ Math.round((answeredQuestions / quizQuestions.length) * 100) }}%</span>
            </div>
            </div>
            

          </div>

          <div v-if="!allQuestionsAnswered" class="bg-yellow-50 border border-yellow-200 rounded-lg p-4">
            <div class="flex items-start space-x-3">
              <svg class="h-5 w-5 text-yellow-600 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.732-.833-2.5 0L4.268 15.5c-.77.833.192 2.5 1.732 2.5z"></path>
              </svg>
              <div>
                <h4 class="font-medium text-yellow-900">Perhatian</h4>
                <p class="text-yellow-800 text-sm">
                  Masih ada {{ quizQuestions.length - answeredQuestions }} soal yang belum dijawab. 
                  Soal yang tidak dijawab akan dianggap salah.
                </p>
              </div>
            </div>
          </div>
        </div>
        
        <template #footer>
          <div class="flex justify-end space-x-3">
            <OutlineButton @click="cancelSubmit" type="secondary">
              Batal
            </OutlineButton>
            <el-button 
              @click="submitQuiz" 
              type="primary" 
              :loading="form.processing"
            >
              Ya, Submit Kuis
            </el-button>
          </div>
        </template>
      </el-dialog>
    </template>
  </OfficeLayout>
</template> 