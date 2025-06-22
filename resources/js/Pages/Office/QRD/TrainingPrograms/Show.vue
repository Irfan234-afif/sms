<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, computed, onMounted } from 'vue';

const props = defineProps({
  program: {
    type: Object,
    required: true
  }
});

// Navigation state
const selectedPhase = ref(null);
const selectedModule = ref(null);
const selectedContentType = ref('materials'); // 'materials', 'quizzes', 'assessments'

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Program Pelatihan', href: route('office.qrd.manage.training-program.index') },
  { label: props.program.name, href: route('office.qrd.manage.training-program.show', props.program.uuid) }
];

// Navigation functions
const selectPhase = (phase) => {
  if (!phase) return;
  selectedPhase.value = phase;
  selectedModule.value = (phase?.modules?.length > 0) ? phase.modules[0] : null;
  selectedContentType.value = 'materials';
};

const selectModule = (module) => {
  if (!module) return;
  selectedModule.value = module;
  selectedContentType.value = 'materials';
};

// Content management based on selected type
const currentContent = computed(() => {
  if (!selectedModule.value || !selectedContentType.value) return [];
  
  try {
    switch(selectedContentType.value) {
      case 'quizzes':
        return selectedModule.value.quizzes || [];
      case 'assessments':
        return selectedModule.value.assessments || [];
      default:
        return selectedModule.value.materials || [];
    }
  } catch (error) {
    console.error('Error in currentContent computed:', error);
    return [];
  }
});

// Initialize selection
onMounted(() => {
  if (props.program?.phases && props.program.phases.length > 0) {
    selectPhase(props.program.phases[0]);
  }
});

// Helper functions for quiz display
const getQuestionTypeLabel = (type) => {
  const types = {
    'multiple_choice': 'Pilihan Ganda',
    'multiple_select': 'Pilihan Ganda (Multiple)',
    'essay': 'Essay',
    'true_false': 'Benar/Salah'
  };
  return types[type] || type;
};

const getStatusBadge = (status) => {
  return status === 'active' ? 'success' : 'info';
};
</script>

<template>
  <Head :title="program.name" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ program.name }}</h1>
            <p class="mt-1 text-sm text-gray-600">Detail program pelatihan dan struktur konten</p>
          </div>
          <div class="flex items-center space-x-3">
          <Link :href="route('office.qrd.manage.training-program.edit', program.uuid)">
            <OutlineButton type="yellow">
              <div class="flex items-center space-x-1">
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                    <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z"></path>
                </svg>
                <div>Edit</div>
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
      <div class="flex h-full bg-gray-50">
        <!-- Left Sidebar - Program Structure -->
        <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
          <div class="p-4">
            <!-- Basic Program Info -->
            <div class="mb-6">
              <h3 class="text-lg font-medium text-gray-900 mb-4">Informasi Program</h3>
              <div class="space-y-4">
                <div class="bg-gray-50 rounded-lg p-3">
                  <div class="grid grid-cols-2 gap-3 text-sm">
                    <div>
                      <span class="font-medium text-gray-700">Tipe:</span>
                      <p class="text-gray-900">{{ program.type }}</p>
                    </div>
            <div>
                      <span class="font-medium text-gray-700">Level:</span>
                      <p class="text-gray-900">{{ program.level }}</p>
            </div>
                    <div class="col-span-2">
                      <span class="font-medium text-gray-700">Status:</span>
                      <div class="mt-1">
                        <el-tag :type="getStatusBadge(program.status)" size="small">
                          {{ program.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                        </el-tag>
          </div>
        </div>
                    <div class="col-span-2">
                      <span class="font-medium text-gray-700">Deskripsi:</span>
                      <p class="text-gray-900 text-sm mt-1 whitespace-pre-line">{{ program.description || 'Tidak ada deskripsi' }}</p>
          </div>
          </div>
          </div>
        </div>
      </div>

            <!-- Phases Navigation -->
            <div>
              <div class="flex items-center justify-between mb-4">
                <h3 class="text-lg font-medium text-gray-900">Struktur Program</h3>
                <span class="text-sm text-gray-500">{{ program.phases?.length || 0 }} Phase</span>
        </div>

              <div class="space-y-2">
                <div v-for="(phase, phaseIndex) in program.phases" :key="phaseIndex">
                  <button 
                    @click="selectPhase(phase)"
                    :class="[
                      'w-full text-left p-3 rounded-lg border transition-colors',
                      selectedPhase === phase 
                        ? 'border-blue-500 bg-blue-50 text-blue-700' 
                        : 'border-gray-200 hover:border-gray-300'
                    ]"
                  >
                    <div class="flex items-center justify-between">
                      <div class="flex items-center space-x-3">
                        <div class="flex-shrink-0 w-6 h-6 rounded-full bg-blue-100 flex items-center justify-center">
                          <span class="text-xs font-medium text-blue-600">{{ phaseIndex + 1 }}</span>
                        </div>
                        <div>
                          <div class="font-medium">{{ phase.name || `Phase ${phaseIndex + 1}` }}</div>
                          <div class="text-sm text-gray-500">{{ phase.modules?.length || 0 }} modul</div>
                        </div>
                      </div>
                      <el-tag :type="getStatusBadge(phase.status)" size="small">
                        {{ phase.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                      </el-tag>
                    </div>
                  </button>

                  <!-- Modules for selected phase -->
                  <div v-if="selectedPhase === phase && phase.modules" class="ml-4 mt-2 space-y-1">
                    <button 
                      v-for="(module, moduleIndex) in phase.modules" 
                      :key="moduleIndex"
                      @click="selectModule(module)"
                      :class="[
                        'w-full text-left p-2 rounded border text-sm transition-colors',
                        selectedModule === module 
                          ? 'border-blue-300 bg-blue-25 text-blue-600' 
                          : 'border-gray-100 hover:border-gray-200'
                      ]"
                    >
                      <div class="flex items-center justify-between">
                        <div class="flex items-center space-x-2">
                          <span>📚</span>
                          <span>{{ module.name || `Module ${moduleIndex + 1}` }}</span>
                        </div>
                        <el-tag :type="getStatusBadge(module.status)" size="small">
                          {{ module.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                        </el-tag>
                      </div>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col">
          <!-- Content Header -->
          <div v-if="selectedPhase" class="bg-white border-b border-gray-200 p-4">
            <div class="mb-4">
              <h2 class="text-xl font-semibold text-gray-900">{{ selectedPhase.name || 'Phase Configuration' }}</h2>
              <p v-if="selectedPhase.description" class="text-sm text-gray-600 mt-1">{{ selectedPhase.description }}</p>
              <div class="flex items-center space-x-4 mt-2 text-sm text-gray-500">
                <span>Order: {{ selectedPhase.order }}</span>
                <span>Status: {{ selectedPhase.status }}</span>
              </div>
            </div>

            <!-- Module Header -->
            <div v-if="selectedModule">
              <div class="border-t pt-4">
                <h3 class="text-lg font-medium text-gray-900 mb-2">{{ selectedModule.name || 'Module Configuration' }}</h3>
                <p v-if="selectedModule.description" class="text-sm text-gray-600 mb-3">{{ selectedModule.description }}</p>
                <div class="flex items-center space-x-4 text-sm text-gray-500 mb-4">
                  <span>Order: {{ selectedModule.order }}</span>
                  <span>Status: {{ selectedModule.status }}</span>
                </div>
              </div>

              <!-- Content Type Tabs -->
              <div class="flex border rounded-lg overflow-hidden">
                <button 
                  @click="selectedContentType = 'materials'"
                  :class="[
                    'px-4 py-2 text-sm font-medium',
                    selectedContentType === 'materials' 
                      ? 'bg-blue-600 text-white' 
                      : 'bg-white text-gray-700 hover:bg-gray-50'
                  ]"
                >
                  Materi ({{ selectedModule.materials?.length || 0 }})
                </button>
                <button 
                  @click="selectedContentType = 'quizzes'"
                  :class="[
                    'px-4 py-2 text-sm font-medium border-l',
                    selectedContentType === 'quizzes' 
                      ? 'bg-blue-600 text-white' 
                      : 'bg-white text-gray-700 hover:bg-gray-50'
                  ]"
                >
                  Kuis ({{ selectedModule.quizzes?.length || 0 }})
                </button>
                <button 
                  @click="selectedContentType = 'assessments'"
                  :class="[
                    'px-4 py-2 text-sm font-medium border-l',
                    selectedContentType === 'assessments' 
                      ? 'bg-blue-600 text-white' 
                      : 'bg-white text-gray-700 hover:bg-gray-50'
                  ]"
                >
                  Penilaian ({{ selectedModule.assessments?.length || 0 }})
                </button>
              </div>
              </div>
            </div>

          <!-- Content Display -->
          <div class="flex-1 overflow-y-auto p-4" v-if="selectedModule">
            <div class="max-w-5xl">
              <!-- Content Header -->
              <div class="mb-4">
                <h4 class="text-lg font-medium">
                  {{ 
                    selectedContentType === 'materials' ? 'Materi Pembelajaran' : 
                    selectedContentType === 'quizzes' ? 'Kuis' : 'Penilaian' 
                  }}
                </h4>
                        </div>

              <!-- Materials -->
              <div v-if="selectedContentType === 'materials'" class="space-y-4">
                <div v-for="(material, index) in currentContent" :key="index" class="bg-white border rounded-lg p-4">
                  <div class="flex items-start justify-between mb-3">
                    <div>
                      <h5 class="font-medium text-lg">{{ material.title }}</h5>
                      <div class="flex items-center space-x-4 mt-1 text-sm text-gray-500">
                        <span>Tipe: {{ material.type }}</span>
                        <span>Order: {{ material.order }}</span>
                      </div>
                    </div>
                    <el-tag :type="getStatusBadge(material.status)" size="small">
                      {{ material.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                    </el-tag>
                  </div>
                  <div class="mt-3">
                    <div v-if="material.type === 'text'" class="prose max-w-none">
                      <div class="whitespace-pre-wrap text-gray-700">{{ material.content }}</div>
                    </div>
                    <div v-else class="text-blue-600">
                      <a :href="material.content" target="_blank" class="hover:underline flex items-center space-x-1">
                        <span>{{ material.content }}</span>
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"/>
                        </svg>
                      </a>
                    </div>
                  </div>
                </div>

                <!-- Empty State for Materials -->
                <div v-if="currentContent.length === 0" class="text-center py-12 bg-white rounded-lg border border-gray-200">
                  <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                  <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak ada materi</h3>
                  <p class="mt-1 text-sm text-gray-500">Modul ini belum memiliki materi pembelajaran.</p>
                </div>
              </div>

              <!-- Quizzes -->
              <div v-else-if="selectedContentType === 'quizzes'" class="space-y-6">
                <div v-for="(quiz, quizIndex) in currentContent" :key="quizIndex" class="bg-white border rounded-lg overflow-hidden">
                  <!-- Quiz Header -->
                  <div class="bg-gray-50 p-4 border-b">
                    <div class="flex items-start justify-between mb-3">
                      <div>
                        <h5 class="font-medium text-lg">{{ quiz.title }}</h5>
                        <p v-if="quiz.description" class="text-sm text-gray-600 mt-1">{{ quiz.description }}</p>
                      </div>
                      <el-tag :type="getStatusBadge(quiz.status)" size="small">
                        {{ quiz.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                      </el-tag>
                    </div>
                    <div class="flex items-center space-x-6 text-sm text-gray-500">
                      <span>Passing Score: {{ quiz.passing_score }}%</span>
                      <span>{{ quiz.questions?.length || 0 }} Pertanyaan</span>
                    </div>
                  </div>

                  <!-- Quiz Questions -->
                  <div class="p-4">
                    <div v-if="quiz.questions && quiz.questions.length > 0" class="space-y-4">
                      <div v-for="(question, questionIndex) in quiz.questions" :key="questionIndex" 
                           class="border rounded-lg p-4 bg-gray-50">
                        <div class="flex items-start justify-between mb-3">
                          <div class="flex-1">
                            <div class="flex items-center space-x-3 mb-2">
                              <span class="inline-flex items-center justify-center w-6 h-6 rounded-full bg-blue-100 text-blue-600 text-sm font-medium">
                                {{ questionIndex + 1 }}
                              </span>
                              <span class="text-sm font-medium text-gray-900">{{ getQuestionTypeLabel(question.type) }}</span>
                              <span class="text-sm text-gray-500">{{ question.points }} poin</span>
                            </div>
                            <p class="text-gray-900 font-medium">{{ question.question }}</p>
                            <p v-if="question.explanation" class="text-sm text-gray-600 mt-2">
                              <span class="font-medium">Penjelasan:</span> {{ question.explanation }}
                            </p>
                          </div>
                        </div>

                        <!-- Question Options/Answers -->
                        <div class="mt-4">
                          <!-- Multiple Choice/Select Options -->
                          <div v-if="question.type === 'multiple_choice' || question.type === 'multiple_select'" 
                               class="bg-white rounded-lg p-3 border">
                            <h6 class="font-medium text-sm mb-3 text-gray-700">Pilihan Jawaban:</h6>
                            <div class="space-y-2">
                              <div v-for="(option, optionIndex) in question.options" :key="optionIndex" 
                                   :class="[
                                     'flex items-center gap-3 p-2 rounded border',
                                     option.is_correct ? 'border-green-200 bg-green-50' : 'border-gray-200'
                                   ]">
                                <div class="flex-shrink-0">
                                  <div v-if="question.type === 'multiple_select'" 
                                       :class="[
                                         'w-4 h-4 rounded border-2 flex items-center justify-center',
                                         option.is_correct ? 'border-green-500 bg-green-500' : 'border-gray-300'
                                       ]">
                                    <svg v-if="option.is_correct" class="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                                      <path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"/>
                                    </svg>
                                  </div>
                                  <div v-else 
                                       :class="[
                                         'w-4 h-4 rounded-full border-2 flex items-center justify-center',
                                         option.is_correct ? 'border-green-500' : 'border-gray-300'
                                       ]">
                                    <div v-if="option.is_correct" class="w-2 h-2 rounded-full bg-green-500"></div>
                      </div>
                    </div>
                                <div class="flex-1">
                                  <span :class="option.is_correct ? 'text-green-700 font-medium' : 'text-gray-700'">
                                    {{ option.option_text }}
                                  </span>
                                  <p v-if="option.explanation" class="text-xs text-gray-500 mt-1">
                                    {{ option.explanation }}
                                  </p>
                                </div>
                                <div v-if="option.is_correct" class="flex-shrink-0">
                                  <span class="text-green-600 text-sm font-medium">✓ Benar</span>
                                </div>
                              </div>
                            </div>
                          </div>

                          <!-- Essay Answer -->
                          <div v-else-if="question.type === 'essay'" class="bg-white rounded-lg p-3 border">
                            <h6 class="font-medium text-sm mb-2 text-gray-700">Model Jawaban:</h6>
                            <div class="text-gray-700 whitespace-pre-wrap">
                              {{ question.correct_answer || 'Tidak ada model jawaban yang disediakan' }}
                            </div>
                              </div>
                              
                          <!-- True/False Answer -->
                          <div v-else-if="question.type === 'true_false'" class="bg-white rounded-lg p-3 border">
                            <h6 class="font-medium text-sm mb-2 text-gray-700">Jawaban yang Benar:</h6>
                            <div class="flex items-center space-x-2">
                              <span :class="[
                                'px-3 py-1 rounded-full text-sm font-medium',
                                question.correct_answer === 'true' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                              ]">
                                {{ question.correct_answer === 'true' ? 'Benar' : 'Salah' }}
                              </span>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Empty State for Questions -->
                    <div v-else class="text-center py-8 border-2 border-dashed border-gray-300 rounded-lg">
                      <svg class="mx-auto h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                      </svg>
                      <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak ada pertanyaan</h3>
                      <p class="mt-1 text-sm text-gray-500">Kuis ini belum memiliki pertanyaan.</p>
                    </div>
                  </div>
                </div>

                <!-- Empty State for Quizzes -->
                <div v-if="currentContent.length === 0" class="text-center py-12 bg-white rounded-lg border border-gray-200">
                  <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak ada kuis</h3>
                  <p class="mt-1 text-sm text-gray-500">Modul ini belum memiliki kuis.</p>
                      </div>
                    </div>

                    <!-- Assessments -->
              <div v-else-if="selectedContentType === 'assessments'" class="space-y-4">
                <div v-for="(assessment, index) in currentContent" :key="index" 
                     class="bg-white border rounded-lg">
                          <!-- Assessment Header -->
                  <div class="p-4 border-b bg-gray-50">
                    <div class="flex items-start justify-between">
                            <div>
                        <h5 class="font-medium text-lg">{{ assessment.title }}</h5>
                        <p v-if="assessment.description" class="text-sm text-gray-600 mt-1">{{ assessment.description }}</p>
                        <div class="flex items-center space-x-4 mt-2 text-sm text-gray-500">
                          <span>Metode: {{ assessment.calculation_method }}</span>
                          <span>Passing Score: {{ assessment.passing_score }}%</span>
                        </div>
                      </div>
                      <el-tag :type="getStatusBadge(assessment.status)" size="small">
                        {{ assessment.status === 'active' ? 'Aktif' : 'Nonaktif' }}
                      </el-tag>
                    </div>
                  </div>

                  <!-- Assessment Content -->
                  <div class="p-4">
                    <div v-if="assessment.group_indicators && assessment.group_indicators.length > 0" class="space-y-6">
                      <div v-for="(group, groupIndex) in assessment.group_indicators" :key="groupIndex" 
                           class="border rounded-lg">
                        <!-- Group Header -->
                        <div class="bg-purple-50 p-4 border-b">
                          <div class="flex items-center space-x-3">
                            <div class="w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center">
                              <span class="text-purple-600 font-medium">{{ group.order }}</span>
                            </div>
                            <div>
                              <h6 class="font-medium text-gray-900">{{ group.name }}</h6>
                              <p v-if="group.description" class="text-sm text-gray-600">{{ group.description }}</p>
                            </div>
                            </div>
                          </div>

                        <!-- Indicators -->
                        <div v-if="group.indicators && group.indicators.length > 0" class="p-4">
                          <div class="space-y-4">
                            <div v-for="(indicator, indicatorIndex) in group.indicators" :key="indicatorIndex" 
                                 class="border rounded-lg">
                              <!-- Indicator Header -->
                              <div class="bg-indigo-50 p-3 border-b">
                                <div class="flex items-center space-x-3">
                                  <div class="w-6 h-6 rounded-full bg-indigo-100 flex items-center justify-center">
                                    <span class="text-indigo-600 text-sm font-medium">{{ indicator.order }}</span>
                                  </div>
                                  <div>
                                    <h6 class="font-medium text-gray-900">{{ indicator.name }}</h6>
                                    <p v-if="indicator.description" class="text-sm text-gray-600">{{ indicator.description }}</p>
                                  </div>
                                  </div>
                                </div>

                              <!-- Sessions -->
                              <div v-if="indicator.sessions && indicator.sessions.length > 0" class="p-3">
                                <div class="space-y-3">
                                  <div v-for="(session, sessionIndex) in indicator.sessions" :key="sessionIndex" 
                                       class="border rounded-lg">
                                    <!-- Session Header -->
                                    <div class="bg-pink-50 p-3 border-b">
                                      <div class="flex items-center space-x-3">
                                        <div class="w-5 h-5 rounded-full bg-pink-100 flex items-center justify-center">
                                          <span class="text-pink-600 text-xs font-medium">{{ session.order }}</span>
                                      </div>
                                      <div>
                                          <h6 class="font-medium text-gray-900">{{ session.name }}</h6>
                                          <p v-if="session.description" class="text-sm text-gray-600">{{ session.description }}</p>
                                        </div>
                                      </div>
                                    </div>

                                    <!-- Rubrics -->
                                    <div v-if="session.rubrics && session.rubrics.length > 0" class="p-3">
                                      <h6 class="text-sm font-medium text-gray-700 mb-2">Rubrik Penilaian:</h6>
                                      <div class="space-y-2">
                                        <div v-for="(rubric, rubricIndex) in session.rubrics" :key="rubricIndex" 
                                             class="flex items-center justify-between p-2 bg-gray-50 rounded border">
                                          <div>
                                            <span class="font-medium text-gray-900">{{ rubric.level }}</span>
                                            <p class="text-sm text-gray-600">{{ rubric.description }}</p>
                                          </div>
                                          <span class="text-lg font-bold text-blue-600">{{ rubric.score }}</span>
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

                    <!-- Empty State for Assessment -->
                    <div v-else class="text-center py-8 border-2 border-dashed border-gray-300 rounded-lg">
                      <svg class="mx-auto h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                      </svg>
                      <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak ada kriteria penilaian</h3>
                      <p class="mt-1 text-sm text-gray-500">Assessment ini belum memiliki kriteria penilaian.</p>
                    </div>
                  </div>
                </div>

                <!-- Empty State for Assessments -->
                <div v-if="currentContent.length === 0" class="text-center py-12 bg-white rounded-lg border border-gray-200">
                  <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v10a2 2 0 002 2h8a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                  </svg>
                  <h3 class="mt-2 text-sm font-medium text-gray-900">Tidak ada penilaian</h3>
                  <p class="mt-1 text-sm text-gray-500">Modul ini belum memiliki sistem penilaian.</p>
              </div>
              </div>
            </div>
          </div>

          <!-- No Selection State -->
          <div v-else class="flex-1 flex items-center justify-center">
            <div class="text-center">
              <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10"/>
              </svg>
              <h3 class="mt-2 text-sm font-medium text-gray-900">Pilih Phase dan Module</h3>
              <p class="mt-1 text-sm text-gray-500">Pilih phase dan module dari sidebar untuk melihat detail konten.</p>
            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template>
