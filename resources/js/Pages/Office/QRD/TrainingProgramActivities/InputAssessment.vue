<script>
import { initFlowbite } from "flowbite";
export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import { Head, useForm } from "@inertiajs/vue3";
import OfficeLayout from "@/Layouts/OfficeLayout.vue";
import QRDSidebar from "@/Layouts/Sidebars/QRDSidebar.vue";
import Breadcrumb from "@/Components/Breadcrumb.vue";
import { ElNotification } from "element-plus";
import { computed } from "vue";

const props = defineProps({
    activity: Object,
    participant: Object,
    assessment: Object,
    existing_result: Object,
});

const breadcrumbs = [
    { label: "Yayasan", href: route("office") },
    { label: "QRD", href: route("office.qrd") },
    { label: "Aktivitas Pelatihan", href: route("office.qrd.activity.training-program-activity.index") },
    { label: props.activity?.title || "Activity", href: route("office.qrd.activity.training-program-activity.show", props.activity?.uuid) },
    { label: `Detail ${props.participant?.profile?.name || "Participant"}`, href: route("office.qrd.activity.training-program-activity.participantDetail", [props.activity?.uuid, props.participant?.uuid]) },
    { label: `Input Assessment: ${props.assessment?.title || "Assessment"}` },
];

// Initialize form with existing rubric selections if available
const initializeScores = () => {
    const scores = {};
    if (props.existing_result?.scores) {
        return props.existing_result.scores;
    }
    
    // Initialize empty scores for all sessions
    props.assessment.group_indicators?.forEach(group => {
        group.indicators?.forEach(indicator => {
            indicator.sessions?.forEach(session => {
                scores[session.id] = null;
            });
        });
    });
    
    return scores;
};

const form = useForm({
    scores: initializeScores(),
    feedback: props.existing_result?.feedback || "",
});

const isEditing = computed(() => {
    return props.existing_result !== null;
});

const finalScore = computed(() => {
    const sessionScores = [];
    
    // Get scores from selected rubrics
    props.assessment.group_indicators?.forEach(group => {
        group.indicators?.forEach(indicator => {
            indicator.sessions?.forEach(session => {
                const selectedRubricId = form.scores[session.id];
                if (selectedRubricId) {
                    const selectedRubric = session.rubrics.find(r => r.id === selectedRubricId);
                    if (selectedRubric) {
                        sessionScores.push(parseFloat(selectedRubric.score));
                    }
                }
            });
        });
    });
    
    if (sessionScores.length === 0) return 0;
    
    // Calculate based on assessment calculation method
    const calculationMethod = props.assessment.calculation_method || 'AVERAGE';
    
    if (calculationMethod === 'SUM') {
        return sessionScores.reduce((sum, score) => sum + score, 0).toFixed(2);
    } else {
        // AVERAGE
        return (sessionScores.reduce((sum, score) => sum + score, 0) / sessionScores.length).toFixed(2);
    }
});

const isPassing = computed(() => {
    const passingScore = props.assessment.passing_score || 70;
    return parseFloat(finalScore.value) >= passingScore;
});

const submit = () => {
    // Validate that all sessions have rubric selections
    const missingSelections = [];
    props.assessment.group_indicators?.forEach(group => {
        group.indicators?.forEach(indicator => {
            indicator.sessions?.forEach(session => {
                if (!form.scores[session.id]) {
                    missingSelections.push(`${group.name} - ${indicator.name} - ${session.name}`);
                }
            });
        });
    });
    
    if (missingSelections.length > 0) {
        ElNotification({
            title: "Validasi Error",
            message: `Harap pilih rubric untuk: ${missingSelections.join(", ")}`,
            type: "error",
            duration: 5000,
        });
        return;
    }
    
    form.post(route("office.qrd.activity.training-program-activity.storeAssessment", [
        props.activity.uuid,
        props.participant.uuid,
        props.assessment.id
    ]), {
        onSuccess: () => {
            ElNotification({
                title: "Berhasil",
                message: "Assessment berhasil disimpan",
                type: "success",
                duration: 3000,
            });
        },
        onError: (errors) => {
            ElNotification({
                title: "Error",
                message: "Terjadi kesalahan saat menyimpan assessment",
                type: "error",
                duration: 5000,
            });
        }
    });
};

const getScoreColor = (score) => {
    if (score >= 90) return "text-green-600";
    if (score >= 80) return "text-blue-600";
    if (score >= 70) return "text-yellow-600";
    if (score >= 60) return "text-orange-600";
    return "text-red-600";
};

const getRubricColor = (score) => {
    if (score >= 90) return "bg-green-100 text-green-800 border-green-200";
    if (score >= 80) return "bg-blue-100 text-blue-800 border-blue-200";
    if (score >= 70) return "bg-yellow-100 text-yellow-800 border-yellow-200";
    if (score >= 60) return "bg-orange-100 text-orange-800 border-orange-200";
    return "bg-red-100 text-red-800 border-red-200";
};
</script>

<template>
    <Head :title="`Input Assessment: ${assessment?.title || 'Assessment'}`" />

    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
            <div class="mx-4 py-3">
                <div class="flex justify-between items-start">
                    <div>
                        <h1 class="text-2xl font-bold text-gray-900">Input Assessment</h1>
                        <p class="mt-1 text-sm text-gray-600">
                            Berikan penilaian untuk {{ participant?.profile?.name }} pada assessment {{ assessment?.title }}
                        </p>
                    </div>
                    <div class="text-right">
                        <div class="text-sm text-gray-500">
                            {{ isEditing ? "Mengedit" : "Membuat" }} Assessment
                        </div>
                        <div v-if="existing_result" class="text-xs text-gray-400">
                            Terakhir diupdate: {{ existing_result.assessed_at }}
                        </div>
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
                    <!-- Assessment Info -->
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="bg-white border border-gray-200 rounded-lg p-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Assessment</h3>
                            <div class="space-y-3">
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Judul Assessment</label>
                                    <div class="text-gray-900">{{ assessment.title }}</div>
                                </div>
                                <div v-if="assessment.description">
                                    <label class="text-sm font-medium text-gray-500">Deskripsi</label>
                                    <div class="text-gray-900">{{ assessment.description }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Modul</label>
                                    <div class="text-gray-900">{{ assessment.module?.name }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Fase</label>
                                    <div class="text-gray-900">{{ assessment.module?.phase?.name }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Metode Kalkulasi</label>
                                    <div class="text-gray-900">
                                        {{ assessment.calculation_method === 'SUM' ? 'Penjumlahan' : 'Rata-rata' }}
                                    </div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Nilai Kelulusan</label>
                                    <div class="text-gray-900">{{ assessment.passing_score || 70 }}</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="bg-white border border-gray-200 rounded-lg p-6">
                            <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Participant</h3>
                            <div class="space-y-3">
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Nama</label>
                                    <div class="text-gray-900">{{ participant.profile?.name }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Email</label>
                                    <div class="text-gray-900">{{ participant.profile?.email }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Area</label>
                                    <div class="text-gray-900">{{ participant.profile?.employee?.area?.name || "N/A" }}</div>
                                </div>
                                <div>
                                    <label class="text-sm font-medium text-gray-500">Posisi</label>
                                    <div class="text-gray-900">{{ participant.profile?.employee?.position?.name || "N/A" }}</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Assessment Form -->
                    <div class="bg-white border border-gray-200 rounded-lg p-6">
                        <h3 class="text-lg font-medium text-gray-900 mb-6">Penilaian Rubric</h3>
                        
                        <form @submit.prevent="submit" class="space-y-8">
                            <!-- Group Indicators -->
                            <div v-for="(group, groupIndex) in assessment.group_indicators" :key="group.id" class="border rounded-lg p-6">
                                <h4 class="text-md font-semibold text-gray-900 mb-4">
                                    {{ group.name }}
                                </h4>
                                <p v-if="group.description" class="text-sm text-gray-600 mb-4">
                                    {{ group.description }}
                                </p>
                                
                                <!-- Indicators -->
                                <div class="space-y-6">
                                    <div v-for="(indicator, indicatorIndex) in group.indicators" :key="indicator.id" class="border-l-4 border-blue-200 pl-4">
                                        <div class="mb-4">
                                            <h5 class="font-medium text-gray-900">{{ indicator.name }}</h5>
                                            <p v-if="indicator.description" class="text-sm text-gray-600 mt-1">
                                                {{ indicator.description }}
                                            </p>
                                        </div>
                                        
                                        <!-- Sessions -->
                                        <div class="space-y-4">
                                            <div v-for="(session, sessionIndex) in indicator.sessions" :key="session.id" class="bg-gray-50 rounded-lg p-4">
                                                <div class="mb-3">
                                                    <h6 class="font-medium text-gray-800">{{ session.name }}</h6>
                                                    <p v-if="session.description" class="text-sm text-gray-600 mt-1">
                                                        {{ session.description }}
                                                    </p>
                                                </div>
                                                
                                                <!-- Rubric Selection -->
                                                <div class="mt-4">
                                                    <label class="block text-sm font-medium text-gray-700 mb-3">
                                                        Pilih Rubric
                                                    </label>
                                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-3">
                                                        <div v-for="rubric in session.rubrics" :key="rubric.id"
                                                             @click="form.scores[session.id] = rubric.id"
                                                             :class="[
                                                                 'p-3 rounded-lg border-2 cursor-pointer transition-all',
                                                                 getRubricColor(rubric.score),
                                                                 form.scores[session.id] === rubric.id 
                                                                     ? 'ring-2 ring-blue-500 border-blue-500' 
                                                                     : 'hover:shadow-md'
                                                             ]">
                                                            <div class="flex justify-between items-start mb-2">
                                                                <div class="font-medium text-sm">{{ rubric.level }}</div>
                                                                <div class="font-bold text-lg">{{ rubric.score }}</div>
                                                            </div>
                                                            <div class="text-xs">{{ rubric.description }}</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Feedback -->
                            <div class="border rounded-lg p-6">
                                <label class="block text-sm font-medium text-gray-700 mb-2">
                                    Feedback (Opsional)
                                </label>
                                <el-input
                                    v-model="form.feedback"
                                    type="textarea"
                                    :rows="4"
                                    placeholder="Berikan feedback untuk participant..."
                                    maxlength="1000"
                                    show-word-limit
                                />
                            </div>

                            <!-- Final Score Preview -->
                            <div class="bg-gray-50 rounded-lg p-6">
                                <h4 class="text-lg font-semibold text-gray-900 mb-4">Preview Hasil</h4>
                                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                    <div class="text-center">
                                        <div class="text-2xl font-bold" :class="getScoreColor(finalScore)">
                                            {{ finalScore }}
                                        </div>
                                        <div class="text-sm text-gray-600">Skor Akhir</div>
                                    </div>
                                    <div class="text-center">
                                        <div class="text-2xl font-bold" :class="isPassing ? 'text-green-600' : 'text-red-600'">
                                            {{ isPassing ? "LULUS" : "TIDAK LULUS" }}
                                        </div>
                                        <div class="text-sm text-gray-600">Status</div>
                                    </div>
                                    <div class="text-center">
                                        <div class="text-2xl font-bold text-gray-600">
                                            {{ assessment.passing_score || 70 }}
                                        </div>
                                        <div class="text-sm text-gray-600">Batas Kelulusan</div>
                                    </div>
                                    <div class="text-center">
                                        <div class="text-lg font-bold text-blue-600">
                                            {{ assessment.calculation_method === 'SUM' ? 'JUMLAH' : 'RATA-RATA' }}
                                        </div>
                                        <div class="text-sm text-gray-600">Metode Kalkulasi</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex items-center justify-end space-x-4 pt-6 border-t">
                                <el-button 
                                    @click="$inertia.visit(route('office.qrd.activity.training-program-activity.participantDetail', [activity.uuid, participant.uuid]))"
                                    plain
                                >
                                    Batal
                                </el-button>
                                <el-button 
                                    type="primary" 
                                    @click="submit"
                                    :loading="form.processing"
                                >
                                    {{ isEditing ? "Update Assessment" : "Simpan Assessment" }}
                                </el-button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </template>
    </OfficeLayout>
</template>
