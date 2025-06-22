<script>
import { initFlowbite } from "flowbite";
export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import { Head, useForm, router } from "@inertiajs/vue3";
import OfficeLayout from "@/Layouts/OfficeLayout.vue";
import QRDSidebar from "@/Layouts/Sidebars/QRDSidebar.vue";
import Breadcrumb from "@/Components/Breadcrumb.vue";
import Badge from "@/Components/Badge.vue";
import OutlineButton from "@/Components/OutlineButton.vue";
import { ElNotification } from "element-plus";
import { computed, ref } from "vue";

const props = defineProps({
    activity: Object,
    participant: Object,
    attempt: Object,
    quiz: Object,
    questions: Array,
});

const breadcrumbs = [
    { label: "Yayasan", href: route("office") },
    { label: "QRD", href: route("office.qrd") },
    { label: "Aktivitas Pelatihan", href: route("office.qrd.activity.training-program-activity.index") },
    { label: props.activity?.title || "Activity", href: route("office.qrd.activity.training-program-activity.show", props.activity?.uuid) },
    { label: `Detail ${props.participant?.profile?.name || "Participant"}`, href: route("office.qrd.activity.training-program-activity.participantDetail", [props.activity?.uuid, props.participant?.uuid]) },
    { label: `Koreksi Quiz: ${props.quiz?.title || "Quiz"}` },
];

const currentQuestionIndex = ref(0);
const questionScores = ref({});

// Initialize scores for each question
props.questions?.forEach(question => {
    questionScores.value[question.id] = parseFloat(question.manual_score || 0);
});

const form = useForm({
    scores: questionScores.value,
    total_score: 0,
    feedback: props.attempt?.grader_feedback || "",
});

const currentQuestion = computed(() => {
    return props.questions?.[currentQuestionIndex.value] || {};
});

const totalScore = computed(() => {
    const total = Object.values(questionScores.value).reduce((sum, score) => sum + parseFloat(score || 0), 0);
    return props.questions?.length > 0 ? (total / props.questions.length) : 0;
});

const isPassed = computed(() => {
    return totalScore.value >= (props.quiz?.passing_score || 70);
});

const isEditing = computed(() => {
    return props.attempt?.graded_at !== null;
});

const updateQuestionScore = (questionId, score) => {
    questionScores.value[questionId] = parseFloat(score || 0);
    form.scores = { ...questionScores.value };
    form.total_score = totalScore.value;
};

const submitGrading = () => {
    form.scores = { ...questionScores.value };
    form.total_score = totalScore.value;
    
    form.post(route("office.qrd.activity.training-program-activity.storeQuizGrade", [
        props.activity.uuid,
        props.participant.uuid,
        props.attempt.id
    ]), {
        onSuccess: () => {
            ElNotification({
                title: "Berhasil",
                message: "Penilaian quiz berhasil disimpan",
                type: "success",
                duration: 3000,
            });
        },
        onError: (errors) => {
            ElNotification({
                title: "Error",
                message: "Terjadi kesalahan saat menyimpan penilaian",
                type: "error",
                duration: 5000,
            });
        }
    });
};

const goBack = () => {
    router.get(route("office.qrd.activity.training-program-activity.participantDetail", [
        props.activity.uuid,
        props.participant.uuid
    ]));
};

// Helper functions for option analysis
const isOptionSelected = (question, option) => {
    const userAnswer = props.attempt?.answers?.[question.id];
    
    if (question.type === 'multiple_choice') {
        return parseInt(userAnswer) === parseInt(option.id);
    } else if (question.type === 'multiple_select') {
        return Array.isArray(userAnswer) && userAnswer.some(id => parseInt(id) === parseInt(option.id));
    }
    
    return false;
};

const getOptionStatus = (question, option) => {
    const isSelected = isOptionSelected(question, option);
    const isCorrect = option.is_correct;
    
    if (isSelected && isCorrect) return 'correct-selected';
    if (isSelected && !isCorrect) return 'incorrect-selected';
    if (!isSelected && isCorrect) return 'correct-not-selected';
    return 'not-selected';
};

// Debug logging (can be removed in production)
// console.log('GradeQuiz Props:', props);
</script>

<template>
    <Head :title="`Koreksi Quiz: ${quiz?.title || 'Quiz'}`" />

    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
            <div class="mx-4 py-3">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">Koreksi Quiz: {{ quiz?.title }}</h1>
                        <p class="mt-1 text-sm text-gray-600">Peserta: {{ participant?.profile?.name }}</p>
                        <div v-if="isEditing" class="mt-2">
                            <Badge type="blue">Mode Edit - Sudah Dikoreksi</Badge>
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <div class="text-right text-sm">
                            <div class="text-gray-600">Nilai Saat Ini:</div>
                            <div class="text-2xl font-bold" :class="isPassed ? 'text-green-600' : 'text-red-600'">
                                {{ Math.round(totalScore) }}%
                            </div>
                            <div class="text-xs text-gray-500">
                                Passing Score: {{ quiz?.passing_score || 70 }}%
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </template>
        
        <template #sidebar>
            <QRDSidebar />
        </template>
        
        <template #content>
            <div class="max-w-6xl mx-auto py-6 px-4">
                <!-- Quiz Info -->
                <div class="bg-white rounded-lg shadow-sm p-6 mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
                        <div>
                            <div class="text-sm text-gray-500">Total Soal</div>
                            <div class="text-lg font-semibold">{{ questions?.length || 0 }}</div>
                        </div>
                        <div>
                            <div class="text-sm text-gray-500">Percobaan ke</div>
                            <div class="text-lg font-semibold">{{ attempt?.attempt_number || 1 }}</div>
                        </div>
                        <div>
                            <div class="text-sm text-gray-500">Dikerjakan</div>
                            <div class="text-lg font-semibold">{{ attempt?.completed_at ? new Date(attempt.completed_at).toLocaleDateString('id-ID') : '-' }}</div>
                        </div>
                        <div>
                            <div class="text-sm text-gray-500">Status</div>
                            <div class="text-lg font-semibold">
                                <Badge :type="isPassed ? 'green' : 'red'">
                                    {{ isPassed ? 'Lulus' : 'Tidak Lulus' }}
                                </Badge>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Questions -->
                <div v-if="questions && questions.length > 0" class="space-y-6">
                    <div v-for="(question, index) in questions" :key="question.id" class="bg-white rounded-lg shadow-sm p-6">
                        <div class="flex justify-between items-start mb-4">
                            <h3 class="text-lg font-medium text-gray-900">
                                Soal {{ index + 1 }}
                            </h3>
                            <Badge type="blue">
                                {{ question.type === 'multiple_choice' ? 'Pilihan Ganda' :
                                   question.type === 'multiple_select' ? 'Pilihan Ganda (Multiple)' :
                                   question.type === 'essay' ? 'Essay' :
                                   question.type === 'true_false' ? 'Benar/Salah' : question.type }}
                            </Badge>
                        </div>

                        <!-- Question Text -->
                        <div class="mb-4 p-4 bg-gray-50 rounded-lg">
                            <div class="text-gray-900">
                                {{ question.question || question.question_text || 'Pertanyaan tidak tersedia' }}
                            </div>
                        </div>

                        <!-- All Options with Answer Analysis -->
                        <div class="mb-4">
                            <h4 class="font-medium text-gray-900 mb-2">Analisis Jawaban:</h4>
                            
                            <!-- Multiple Choice / Multiple Select Options -->
                            <div v-if="(question.type === 'multiple_choice' || question.type === 'multiple_select') && question.options && question.options.length > 0">
                                <div class="space-y-3">
                                    <div v-for="(option, optionIndex) in question.options" :key="option.id" 
                                         :class="[
                                             'p-3 rounded-lg border-2 transition-colors',
                                             getOptionStatus(question, option) === 'correct-selected' ? 'border-green-500 bg-green-50' :
                                             getOptionStatus(question, option) === 'incorrect-selected' ? 'border-red-500 bg-red-50' :
                                             getOptionStatus(question, option) === 'correct-not-selected' ? 'border-green-300 bg-green-25' :
                                             'border-gray-200 bg-gray-50'
                                         ]">
                                        <div class="flex items-start space-x-3">
                                            <div class="flex-shrink-0 mt-0.5">
                                                <!-- Option letter/number -->
                                                <div class="w-6 h-6 rounded-full bg-gray-200 flex items-center justify-center text-sm font-medium">
                                                    {{ String.fromCharCode(65 + optionIndex) }}
                                                </div>
                                            </div>
                                            <div class="flex-1">
                                                <div class="text-gray-900">{{ option.option_text || option.text }}</div>
                                            </div>
                                            <div class="flex-shrink-0 flex items-center space-x-2">
                                                <!-- Selected indicator -->
                                                <div v-if="isOptionSelected(question, option)" class="flex items-center space-x-1">
                                                    <div class="w-4 h-4 rounded-full bg-blue-500"></div>
                                                    <span class="text-sm font-medium text-blue-700">Dipilih</span>
                                                </div>
                                                <!-- Correct indicator -->
                                                <div v-if="option.is_correct" class="flex items-center space-x-1">
                                                    <div class="w-4 h-4 rounded-full bg-green-500"></div>
                                                    <span class="text-sm font-medium text-green-700">Benar</span>
                                                </div>
                                                <!-- Status indicator -->
                                                <div v-if="getOptionStatus(question, option) === 'correct-selected'" class="text-green-600 font-bold">
                                                    ✓
                                                </div>
                                                <div v-else-if="getOptionStatus(question, option) === 'incorrect-selected'" class="text-red-600 font-bold">
                                                    ✗
                                                </div>
                                                <div v-else-if="getOptionStatus(question, option) === 'correct-not-selected'" class="text-orange-600 font-bold">
                                                    !
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Legend -->
                                <div class="mt-4 p-3 bg-gray-50 rounded-lg">
                                    <div class="text-sm text-gray-600">
                                        <div class="grid grid-cols-2 gap-2">
                                            <div class="flex items-center space-x-2">
                                                <div class="w-3 h-3 bg-blue-500 rounded-full"></div>
                                                <span>Dipilih Peserta</span>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <div class="w-3 h-3 bg-green-500 rounded-full"></div>
                                                <span>Jawaban Benar</span>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <span class="text-green-600 font-bold">✓</span>
                                                <span>Dipilih & Benar</span>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <span class="text-red-600 font-bold">✗</span>
                                                <span>Dipilih & Salah</span>
                                            </div>
                                            <div class="flex items-center space-x-2">
                                                <span class="text-orange-600 font-bold">!</span>
                                                <span>Tidak Dipilih tapi Benar</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- True/False Answer -->
                            <div v-else-if="question.type === 'true_false'">
                                <div class="grid grid-cols-2 gap-4">
                                    <!-- True Option -->
                                    <div :class="[
                                        'p-4 rounded-lg border-2 text-center transition-colors',
                                        attempt?.answers?.[question.id] === 'true' && question.correct_answer === 'true' ? 'border-green-500 bg-green-50' :
                                        attempt?.answers?.[question.id] === 'true' && question.correct_answer !== 'true' ? 'border-red-500 bg-red-50' :
                                        attempt?.answers?.[question.id] !== 'true' && question.correct_answer === 'true' ? 'border-green-300 bg-green-25' :
                                        'border-gray-200 bg-gray-50'
                                    ]">
                                        <div class="flex flex-col items-center space-y-2">
                                            <div class="text-lg font-bold">BENAR</div>
                                            <div class="flex items-center space-x-2 text-sm">
                                                <div v-if="attempt?.answers?.[question.id] === 'true'" class="flex items-center space-x-1">
                                                    <div class="w-3 h-3 rounded-full bg-blue-500"></div>
                                                    <span class="text-blue-700">Dipilih</span>
                                                </div>
                                                <div v-if="question.correct_answer === 'true'" class="flex items-center space-x-1">
                                                    <div class="w-3 h-3 rounded-full bg-green-500"></div>
                                                    <span class="text-green-700">Benar</span>
                                                </div>
                                            </div>
                                            <div v-if="attempt?.answers?.[question.id] === 'true' && question.correct_answer === 'true'" class="text-green-600 font-bold">
                                                ✓ Benar
                                            </div>
                                            <div v-else-if="attempt?.answers?.[question.id] === 'true' && question.correct_answer !== 'true'" class="text-red-600 font-bold">
                                                ✗ Salah
                                            </div>
                                            <div v-else-if="attempt?.answers?.[question.id] !== 'true' && question.correct_answer === 'true'" class="text-orange-600 font-bold">
                                                ! Seharusnya Dipilih
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- False Option -->
                                    <div :class="[
                                        'p-4 rounded-lg border-2 text-center transition-colors',
                                        attempt?.answers?.[question.id] === 'false' && question.correct_answer === 'false' ? 'border-green-500 bg-green-50' :
                                        attempt?.answers?.[question.id] === 'false' && question.correct_answer !== 'false' ? 'border-red-500 bg-red-50' :
                                        attempt?.answers?.[question.id] !== 'false' && question.correct_answer === 'false' ? 'border-green-300 bg-green-25' :
                                        'border-gray-200 bg-gray-50'
                                    ]">
                                        <div class="flex flex-col items-center space-y-2">
                                            <div class="text-lg font-bold">SALAH</div>
                                            <div class="flex items-center space-x-2 text-sm">
                                                <div v-if="attempt?.answers?.[question.id] === 'false'" class="flex items-center space-x-1">
                                                    <div class="w-3 h-3 rounded-full bg-blue-500"></div>
                                                    <span class="text-blue-700">Dipilih</span>
                                                </div>
                                                <div v-if="question.correct_answer === 'false'" class="flex items-center space-x-1">
                                                    <div class="w-3 h-3 rounded-full bg-green-500"></div>
                                                    <span class="text-green-700">Benar</span>
                                                </div>
                                            </div>
                                            <div v-if="attempt?.answers?.[question.id] === 'false' && question.correct_answer === 'false'" class="text-green-600 font-bold">
                                                ✓ Benar
                                            </div>
                                            <div v-else-if="attempt?.answers?.[question.id] === 'false' && question.correct_answer !== 'false'" class="text-red-600 font-bold">
                                                ✗ Salah
                                            </div>
                                            <div v-else-if="attempt?.answers?.[question.id] !== 'false' && question.correct_answer === 'false'" class="text-orange-600 font-bold">
                                                ! Seharusnya Dipilih
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div v-if="!attempt?.answers?.[question.id]" class="mt-2 p-3 bg-yellow-50 border border-yellow-200 rounded-lg">
                                    <div class="text-yellow-800 text-sm">
                                        <strong>Tidak ada jawaban:</strong> Peserta tidak menjawab pertanyaan ini.
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Essay Answer -->
                            <div v-else-if="question.type === 'essay'">
                                <div class="space-y-4">
                                    <!-- Student Answer -->
                                    <div>
                                        <div class="text-sm font-medium text-gray-700 mb-2">Jawaban Peserta:</div>
                                        <div class="p-4 bg-blue-50 rounded-lg border border-blue-200">
                                            <div v-if="attempt?.answers?.[question.id]" class="whitespace-pre-wrap">
                                                {{ attempt.answers[question.id] }}
                                            </div>
                                            <div v-else class="text-gray-500 italic">
                                                Tidak ada jawaban
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Model Answer -->
                                    <div v-if="question.correct_answer">
                                        <div class="text-sm font-medium text-gray-700 mb-2">Model Jawaban:</div>
                                        <div class="p-4 bg-green-50 rounded-lg border border-green-200">
                                            <div class="whitespace-pre-wrap">{{ question.correct_answer }}</div>
                                        </div>
                                    </div>
                                    <div v-else>
                                        <div class="p-3 bg-gray-50 rounded-lg border border-gray-200">
                                            <div class="text-gray-600 text-sm italic">
                                                Model jawaban tidak tersedia - Dinilai secara manual oleh grader
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Unknown Type -->
                            <div v-else>
                                <div class="p-4 bg-gray-50 rounded-lg border border-gray-200">
                                    <div class="text-gray-600 text-sm">
                                        Tipe pertanyaan tidak dikenali: {{ question.type }}
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Manual Scoring -->
                        <div class="border-t pt-4">
                            <div class="flex items-center justify-between">
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">
                                        Nilai (0-100):
                                    </label>
                                    <el-input-number
                                        v-model="questionScores[question.id]"
                                        @change="updateQuestionScore(question.id, $event)"
                                        :min="0"
                                        :max="100"
                                        :precision="1"
                                        :step="1"
                                        controls-position="right"
                                        class="w-32"
                                    />
                                </div>
                                <div v-if="question.type !== 'essay'" class="flex space-x-2">
                                    <el-button 
                                        @click="updateQuestionScore(question.id, 100)"
                                        size="small"
                                        type="success"
                                        plain
                                    >
                                        100 (Benar)
                                    </el-button>
                                    <el-button 
                                        @click="updateQuestionScore(question.id, 0)"
                                        size="small"
                                        type="danger"
                                        plain
                                    >
                                        0 (Salah)
                                    </el-button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Global Feedback -->
                <div class="bg-white rounded-lg shadow-sm p-6">
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Feedback untuk Peserta</h3>
                    <el-input
                        v-model="form.feedback"
                        type="textarea"
                        :rows="4"
                        placeholder="Masukkan feedback untuk peserta (opsional)..."
                    />
                </div>

                <!-- Actions -->
                <div class="flex justify-between items-center mt-6">
                    <OutlineButton @click="goBack" type="secondary">
                        Kembali
                    </OutlineButton>
                    
                    <div class="flex items-center space-x-4">
                        <div class="text-right text-sm">
                            <div class="text-gray-600">Total Nilai:</div>
                            <div class="text-xl font-bold" :class="isPassed ? 'text-green-600' : 'text-red-600'">
                                {{ Math.round(totalScore) }}%
                            </div>
                        </div>
                        
                        <el-button 
                            @click="submitGrading"
                            type="primary"
                            :loading="form.processing"
                        >
                            {{ isEditing ? 'Update Penilaian' : 'Simpan Penilaian' }}
                        </el-button>
                    </div>
                </div>
            </div>
        </template>
    </OfficeLayout>
</template> 