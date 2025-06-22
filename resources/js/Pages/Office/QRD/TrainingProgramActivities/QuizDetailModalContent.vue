<script setup>
import { computed } from 'vue';
import { Link } from '@inertiajs/vue3';
import Badge from '@/Components/Badge.vue';

const props = defineProps({
    selectedQuizAttempt: {
        type: Object,
        required: true
    },
    participant: {
        type: Object,
        required: true
    },
    activity: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['close']);

// Helper functions for quiz detail display
const getAnswerText = (question, userAnswer) => {
    if (userAnswer === null || userAnswer === undefined) return 'Tidak ada jawaban';
    
    switch (question.type) {
        case 'multiple_choice':
            const option = question.options?.find(opt => opt.id == userAnswer);
            return option ? option.option_text || option.text : 'Jawaban tidak valid';
            
        case 'multiple_select':
            if (Array.isArray(userAnswer)) {
                if (userAnswer.length === 0) return 'Tidak ada jawaban';
                const selectedOptions = question.options?.filter(opt => 
                    userAnswer.includes(String(opt.id))
                ) || [];
                return selectedOptions.map(opt => opt.option_text || opt.text).join(', ') || 'Tidak ada pilihan';
            }
            return 'Format jawaban tidak valid';
            
        case 'true_false':
            return userAnswer === 'true' ? 'Benar' : (userAnswer === 'false' ? 'Salah' : 'Tidak ada jawaban');
            
        case 'essay':
            return userAnswer || 'Tidak ada jawaban';
            
        default:
            return userAnswer;
    }
};

const getCorrectAnswer = (question) => {
    switch (question.type) {
        case 'multiple_choice':
            const correctOption = question.options?.find(opt => opt.is_correct);
            return correctOption ? correctOption.option_text || correctOption.text : 'Tidak ada jawaban benar';
            
        case 'multiple_select':
            const correctOptions = question.options?.filter(opt => opt.is_correct) || [];
            return correctOptions.map(opt => opt.option_text || opt.text).join(', ') || 'Tidak ada jawaban benar';
            
        case 'true_false':
            return question.correct_answer === 'true' ? 'Benar' : 'Salah';
            
        case 'essay':
            return 'Jawaban subjektif - dinilai oleh grader';
            
        default:
            return question.correct_answer || 'Tidak tersedia';
    }
};

const getQuestionScore = (questionId, index) => {
    const scores = props.selectedQuizAttempt?.manual_scores;
    if (!scores || !props.selectedQuizAttempt?.graded_at) return 0;

    // 1. Handle associative array/object format (primary expected format)
    if (typeof scores === 'object' && !Array.isArray(scores)) {
        if (scores[questionId] !== undefined) return scores[questionId];
        if (scores[String(questionId)] !== undefined) return scores[String(questionId)];
    }

    // 2. Handle simple indexed array format
    if (Array.isArray(scores) && scores.length > index) {
        return scores[index];
    }
    
    return 0; // No score found
};

const isOptionSelected = (question, option, index) => {
    if (!props.selectedQuizAttempt?.answers) return false;
    
    const userAnswer = getUserAnswer(question, index);
    
    if (question.type === 'multiple_choice') {
        return String(userAnswer) === String(option.id);
    } else if (question.type === 'multiple_select') {
        return Array.isArray(userAnswer) && userAnswer.includes(String(option.id));
    }
    
    return false;
};

// Helper function to get user answer for a specific question
const getUserAnswer = (question, index) => {
    if (!props.selectedQuizAttempt?.answers) return null;
    const answers = props.selectedQuizAttempt.answers;

    // 1. Handle associative array/object format (primary expected format)
    if (typeof answers === 'object' && !Array.isArray(answers)) {
        if (answers[question.id] !== undefined) return answers[question.id];
        if (answers[String(question.id)] !== undefined) return answers[String(question.id)];
    }

    // 2. Handle simple indexed array format (based on user debug)
    if (Array.isArray(answers) && typeof answers[index] !== 'object' && answers.length > index) {
        return answers[index];
    }

    // 3. Handle legacy array of objects format
    if (Array.isArray(answers) && typeof answers[0] === 'object' && answers[0] !== null) {
        const answerObj = answers.find(ans =>
            ans.question_id == question.id || ans.questionId == question.id
        );
        return answerObj ? answerObj.answer : null;
    }
    
    return null; // No answer found
};
</script>

<template>
    <div class="flex h-[80vh] bg-gray-50">
        <!-- Modal Header -->
        <div class="flex-1 flex flex-col">
            <div class="bg-white border-b border-gray-200 p-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h3 class="text-lg font-medium text-gray-900">
                            Detail Jawaban Quiz: {{ selectedQuizAttempt.quiz?.title || 'Quiz' }}
                        </h3>
                        <p class="mt-1 text-sm text-gray-600">
                            Peserta: {{ participant?.profile?.name }}
                        </p>
                    </div>
                    <button @click="emit('close')" class="text-gray-400 hover:text-gray-600">
                        <svg class="h-6 w-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
            </div>

            <!-- Modal Body -->
            <div class="flex-1 overflow-y-auto p-6">
                <!-- Quiz Info -->
                <div class="bg-gray-50 rounded-lg p-4 mb-6">
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                        <div>
                            <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Skor Akhir</label>
                            <div class="text-lg font-semibold text-gray-900">
                                <template v-if="selectedQuizAttempt.graded_at">
                                    {{ selectedQuizAttempt.score || 0 }}/100
                                </template>
                                <template v-else>
                                    <span class="text-orange-600">Menunggu Koreksi</span>
                                </template>
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Status</label>
                            <div class="mt-1">
                                <template v-if="selectedQuizAttempt.graded_at">
                                    <Badge :type="selectedQuizAttempt.passed ? 'green' : 'red'">
                                        {{ selectedQuizAttempt.passed ? 'Lulus' : 'Tidak Lulus' }}
                                    </Badge>
                                </template>
                                <template v-else>
                                    <Badge type="orange">
                                        Menunggu Koreksi
                                    </Badge>
                                </template>
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">
                                <template v-if="selectedQuizAttempt.graded_at">Tanggal Dikoreksi</template>
                                <template v-else>Tanggal Selesai</template>
                            </label>
                            <div class="text-sm text-gray-900">
                                <template v-if="selectedQuizAttempt.graded_at">
                                    {{ selectedQuizAttempt.graded_at || '-' }}
                                </template>
                                <template v-else>
                                    {{ selectedQuizAttempt.completed_at || '-' }}
                                </template>
                            </div>
                        </div>
                        <div>
                            <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Dikoreksi Oleh</label>
                            <div class="text-sm text-gray-900">
                                <template v-if="selectedQuizAttempt.graded_at">
                                    {{ selectedQuizAttempt.grader?.name || 'Sistem' }}
                                </template>
                                <template v-else>
                                    <span class="text-orange-600">Belum Dikoreksi</span>
                                </template>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Grader Feedback -->
                    <div v-if="selectedQuizAttempt.graded_at && selectedQuizAttempt.grader_feedback" class="mt-4">
                        <label class="text-xs font-medium text-gray-500 uppercase tracking-wider">Feedback Grader</label>
                        <div class="mt-1 text-sm text-gray-700 bg-white rounded p-3 border">
                            {{ selectedQuizAttempt.grader_feedback }}
                        </div>
                    </div>
                </div>

                <!-- Questions and Answers -->
                <div v-if="selectedQuizAttempt.quiz?.questions" class="space-y-6">
                    <div v-for="(question, index) in selectedQuizAttempt.quiz.questions" :key="question.id" 
                         class="border border-gray-200 rounded-lg p-4 bg-white">
                        
                        <!-- Question Header -->
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex-1">
                                <h4 class="font-medium text-gray-900">
                                    Pertanyaan {{ index + 1 }}
                                </h4>
                                <div class="mt-1 text-sm text-gray-700" v-html="question.question_text || question.question"></div>
                            </div>
                            <div class="ml-4 text-right">
                                <template v-if="selectedQuizAttempt.graded_at">
                                    <div class="text-sm font-medium text-gray-900">
                                        Skor: {{ getQuestionScore(question.id, index) }}/100
                                    </div>
                                    <Badge :type="getQuestionScore(question.id, index) >= 70 ? 'green' : 'red'" class="mt-1">
                                        {{ getQuestionScore(question.id, index) >= 70 ? 'Benar' : 'Salah' }}
                                    </Badge>
                                </template>
                                <template v-else>
                                    <div class="text-sm font-medium text-orange-600">
                                        Belum Dikoreksi
                                    </div>
                                    <Badge type="orange" class="mt-1">
                                        Menunggu Koreksi
                                    </Badge>
                                </template>
                            </div>
                        </div>

                        <!-- Question Type Badge -->
                        <div class="mb-3">
                            <Badge type="blue" class="text-xs">
                                {{ question.type === 'multiple_choice' ? 'Pilihan Ganda' : 
                                   question.type === 'multiple_select' ? 'Pilihan Ganda (Multiple)' :
                                   question.type === 'true_false' ? 'Benar/Salah' :
                                   question.type === 'essay' ? 'Essay' : question.type }}
                            </Badge>
                        </div>

                        <!-- Options for Multiple Choice/Select -->
                        <div v-if="question.options && question.options.length > 0" class="mb-4">
                            <h5 class="text-sm font-medium text-gray-700 mb-2">Pilihan Jawaban:</h5>
                            <div class="space-y-2">
                                <div v-for="(option, optIndex) in question.options" :key="option.id" 
                                     class="flex items-center p-2 rounded border"
                                     :class="{
                                         'bg-green-50 border-green-200': option.is_correct,
                                         'bg-red-50 border-red-200': !option.is_correct && isOptionSelected(question, option, index),
                                         'bg-gray-50 border-gray-200': !option.is_correct && !isOptionSelected(question, option, index)
                                     }">
                                    <span class="flex-shrink-0 w-6 h-6 rounded-full border-2 border-gray-300 flex items-center justify-center text-xs font-medium mr-3">
                                        {{ String.fromCharCode(65 + optIndex) }}
                                    </span>
                                    <span class="flex-1 text-sm">{{ option.option_text || option.text }}</span>
                                    <div class="flex items-center space-x-2">
                                        <span v-if="option.is_correct" class="text-green-600 text-xs font-medium">✓ Benar</span>
                                        <span v-if="isOptionSelected(question, option, index)" class="text-blue-600 text-xs font-medium">👤 Dipilih</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- User Answer -->
                        <div class="mb-4">
                            <h5 class="text-sm font-medium text-gray-700 mb-2">Jawaban Peserta:</h5>
                            <div class="p-3 bg-blue-50 border border-blue-200 rounded">
                                <div class="text-sm text-gray-800">
                                    {{ getAnswerText(question, getUserAnswer(question, index)) }}
                                </div>
                            </div>
                        </div>

                        <!-- Correct Answer -->
                        <div class="mb-4">
                            <h5 class="text-sm font-medium text-gray-700 mb-2">Jawaban Benar:</h5>
                            <div class="p-3 bg-green-50 border border-green-200 rounded">
                                <div class="text-sm text-gray-800">
                                    {{ getCorrectAnswer(question) }}
                                </div>
                            </div>
                        </div>

                        <!-- Question Explanation -->
                        <div v-if="question.explanation" class="mt-4">
                            <h5 class="text-sm font-medium text-gray-700 mb-2">Penjelasan:</h5>
                            <div class="p-3 bg-yellow-50 border border-yellow-200 rounded">
                                <div class="text-sm text-gray-800" v-html="question.explanation"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- No Questions State -->
                <div v-else class="text-center py-8">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">Data Pertanyaan Tidak Tersedia</h3>
                    <p class="mt-1 text-sm text-gray-500">Detail pertanyaan quiz tidak dapat dimuat.</p>
                </div>
            </div>

            <!-- Modal Footer -->
            <div class="border-t border-gray-200 bg-gray-50 p-4">
                <div class="flex justify-end space-x-3">
                    <button 
                        @click="emit('close')"
                        class="px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                    >
                        Tutup
                    </button>
                    <Link 
                        v-if="selectedQuizAttempt && selectedQuizAttempt.graded_at"
                        :href="route('office.qrd.activity.training-program-activity.gradeQuiz', [activity.uuid, participant.uuid, selectedQuizAttempt.id])"
                        class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
                    >
                        Edit Koreksi
                    </Link>
                    <Link 
                        v-else-if="selectedQuizAttempt && selectedQuizAttempt.completed_at && !selectedQuizAttempt.graded_at"
                        :href="route('office.qrd.activity.training-program-activity.gradeQuiz', [activity.uuid, participant.uuid, selectedQuizAttempt.id])"
                        class="px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-orange-600 hover:bg-orange-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-orange-500"
                    >
                        Koreksi Quiz
                    </Link>
                </div>
            </div>
        </div>
    </div>
</template> 