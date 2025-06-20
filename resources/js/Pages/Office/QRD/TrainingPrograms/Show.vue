<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref } from 'vue';

const props = defineProps({
  program: {
    type: Object,
    required: true
  }
});

const activePhase = ref(null);
const activeModule = ref(null);
const activeAssessment = ref(null);

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'QRD', href: route('office.qrd') },
  { label: 'Program Pelatihan', href: route('office.qrd.manage.training-program.index') },
  { label: props.program.name, href: route('office.qrd.manage.training-program.show', props.program.id) }
];

const togglePhase = (phase) => {
  activePhase.value = activePhase.value === phase.id ? null : phase.id;
  activeModule.value = null;
  activeAssessment.value = null;
};

const toggleModule = (module) => {
  activeModule.value = activeModule.value === module.id ? null : module.id;
  activeAssessment.value = null;
};

const toggleAssessment = (assessment) => {
  activeAssessment.value = activeAssessment.value === assessment.id ? null : assessment.id;
};
</script>

<template>
  <Head :title="program.name" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 flex items-center justify-between py-3">
        <div class="flex-1"></div>
        <div class="flex space-x-3">
          <Link :href="route('office.qrd.manage.training-program.edit', program.uuid)">
            <OutlineButton type="yellow">
              <div class="flex items-center space-x-1">
                <svg class="h-4 w-4" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                  <path
                    d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z">
                  </path>
                </svg>
                <div>Edit</div>
              </div>
            </OutlineButton>
          </Link>
        </div>
      </div>
    </template>
    <template #sidebar>
      <QRDSidebar />
    </template>
    <template #content>
      <!-- Program Overview -->
      <div class="bg-white rounded-lg shadow-sm mb-6">
        <div class="p-6 border-b border-gray-200">
          <div class="flex items-center justify-between">
            <div>
              <h2 class="text-2xl font-bold text-gray-900">{{ program.name }}</h2>
              <p class="mt-1 text-sm text-gray-500">Program details and information</p>
            </div>
            <Badge v-if="program.status === 'active'" type="green">Active</Badge>
            <Badge v-else type="red">Inactive</Badge>
          </div>
        </div>
        
        <div class="p-6 grid grid-cols-1 md:grid-cols-2 gap-6">
          <div>
            <h4 class="text-sm font-medium text-gray-500">Type</h4>
            <p class="mt-1 text-sm text-gray-900">{{ program.type }}</p>
          </div>
          <div>
            <h4 class="text-sm font-medium text-gray-500">Level</h4>
            <p class="mt-1 text-sm text-gray-900">{{ program.level }}</p>
          </div>
          <div class="md:col-span-2">
            <h4 class="text-sm font-medium text-gray-500">Description</h4>
            <p class="mt-1 text-sm text-gray-900 whitespace-pre-line">{{ program.description }}</p>
          </div>
        </div>
      </div>

      <!-- Program Structure -->
      <div class="bg-white rounded-lg shadow-sm">
        <div class="p-6 border-b border-gray-200">
          <h3 class="text-lg font-semibold text-gray-900">Program Structure</h3>
        </div>

        <!-- Phases List -->
        <div class="divide-y divide-gray-200">
          <div v-for="phase in program.phases" :key="phase.id" class="p-6">
            <!-- Phase Header -->
            <div class="flex items-center justify-between cursor-pointer" @click="togglePhase(phase)">
              <div class="flex items-center space-x-4">
                <div class="flex-shrink-0">
                  <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center">
                    <span class="text-blue-600 font-medium">{{ phase.order }}</span>
                  </div>
                </div>
                <div>
                  <h4 class="text-lg font-medium text-gray-900">Phase {{ phase.order }}: {{ phase.name }}</h4>
                  <p class="text-sm text-gray-500">{{ phase.description }}</p>
                </div>
              </div>
              <div class="flex items-center space-x-4">
                <Badge v-if="phase.status === 'active'" type="green">Active</Badge>
                <Badge v-else type="red">Inactive</Badge>
                <svg class="w-5 h-5 text-gray-400 transform transition-transform"
                     :class="{ 'rotate-180': activePhase === phase.id }"
                     fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </div>
            </div>

            <!-- Phase Content -->
            <div v-if="activePhase === phase.id" class="mt-4 pl-12">
              <!-- Modules -->
              <div v-if="phase.modules && phase.modules.length > 0" class="space-y-4">
                <h5 class="text-md font-semibold text-gray-700 mb-4">Modules in Phase {{ phase.order }}</h5>
                <div v-for="module in phase.modules" :key="module.id" class="bg-gray-50 rounded-lg p-4">
                  <!-- Module Header -->
                  <div class="flex items-center justify-between cursor-pointer" @click="toggleModule(module)">
                    <div class="flex items-center space-x-4">
                      <div class="flex-shrink-0">
                        <div class="w-6 h-6 rounded-full bg-green-100 flex items-center justify-center">
                          <span class="text-green-600 text-sm font-medium">{{ module.order }}</span>
                        </div>
                      </div>
                      <div>
                        <h5 class="text-md font-medium text-gray-900">Module {{ module.order }}: {{ module.name }}</h5>
                        <p class="text-sm text-gray-500">{{ module.description }}</p>
                      </div>
                    </div>
                    <div class="flex items-center space-x-4">
                      <Badge v-if="module.status === 'active'" type="green">Active</Badge>
                      <Badge v-else type="red">Inactive</Badge>
                      <svg class="w-5 h-5 text-gray-400 transform transition-transform"
                           :class="{ 'rotate-180': activeModule === module.id }"
                           fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                      </svg>
                    </div>
                  </div>

                  <!-- Module Content -->
                  <div v-if="activeModule === module.id" class="mt-4 space-y-6">
                    <!-- Materials -->
                    <div v-if="module.materials && module.materials.length > 0">
                      <h6 class="text-sm font-semibold text-gray-700 mb-3">Learning Materials</h6>
                      <div class="space-y-4">
                        <div class="bg-white rounded-lg shadow p-4">
                          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div v-for="material in module.materials" :key="material.id" 
                                class="border rounded-lg p-4 hover:shadow-md transition-shadow">
                              <div class="flex justify-between items-start mb-2">
                                <h5 class="font-medium">{{ material.title }}</h5>
                                <el-tag :type="material.status === 'active' ? 'success' : 'info'" size="small">
                                  {{ material.status }}
                                </el-tag>
                              </div>
                              <p class="text-sm text-gray-600 mb-2">Type: {{ material.type }}</p>
                              <div class="text-sm">
                                <p v-if="material.type === 'text'" class="whitespace-pre-wrap">{{ material.content }}</p>
                                <a v-else :href="material.content" target="_blank" class="text-blue-600 hover:underline">
                                  {{ material.content }}
                                </a>
                              </div>
                              <div class="mt-2 text-sm text-gray-500">
                                Order: {{ material.order }}
                              </div>
                            </div>
                          </div>
                        </div>

                      </div>
                    </div>

                    <!-- Quizzes -->
                    <div v-if="module.quizzes && module.quizzes.length > 0">
                      <h6 class="text-sm font-semibold text-gray-700 mb-3">Module Quizzes</h6>
                      <div class="space-y-3">
                        <div v-for="quiz in module.quizzes" :key="quiz.id" 
                             class="bg-white rounded-lg p-3 border border-gray-200">
                          <div class="flex items-center justify-between">
                            <div>
                              <p class="text-sm font-medium text-gray-800">{{ quiz.title }}</p>
                              <p class="text-xs text-gray-500">{{ quiz.description }}</p>
                              <div class="flex items-center space-x-3 mt-1">
                                <span class="text-xs text-gray-500">Passing Score: {{ quiz.passing_score }}%</span>
                                <span v-if="quiz.time_limit" class="text-xs text-gray-500">Time Limit: {{ quiz.time_limit }} minutes</span>
                              </div>
                            </div>
                            <Badge v-if="quiz.status === 'active'" type="green">Active</Badge>
                            <Badge v-else type="red">Inactive</Badge>
                          </div>

                          <!-- Questions -->
                          <div v-if="quiz.questions && quiz.questions.length > 0" class="mt-3 space-y-2">
                            <h6 class="text-xs font-semibold text-gray-600 mb-2">Quiz Questions</h6>
                            <div v-for="question in quiz.questions" :key="question.id" 
                                 class="bg-gray-50 rounded-lg p-2">
                              <p class="text-sm text-gray-700">{{ question.question }}</p>
                              <div class="flex items-center space-x-2 mt-1">
                                <span class="text-xs text-gray-500">Type: {{ question.type }}</span>
                                <span class="text-xs text-gray-500">Points: {{ question.points }}</span>
                              </div>
                              
                              <!-- Options -->
                              <div v-if="question.options && question.options.length > 0" class="mt-2 space-y-1">
                                <div v-for="option in question.options" :key="option.id" 
                                     class="flex items-center space-x-2 text-xs"
                                     :class="option.is_correct ? 'text-green-600' : 'text-gray-500'">
                                  <span>{{ option.option_text }}</span>
                                  <span v-if="option.is_correct" class="text-green-600">✓</span>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Assessments -->
                    <div v-if="module.assessments && module.assessments.length > 0">
                      <h6 class="text-sm font-semibold text-gray-700 mb-3">Module Assessments</h6>
                      <div class="space-y-3">
                        <div v-for="assessment in module.assessments" :key="assessment.id" 
                             class="bg-white rounded-lg p-3 border border-gray-200">
                          <!-- Assessment Header -->
                          <div class="flex items-center justify-between cursor-pointer" @click="toggleAssessment(assessment)">
                            <div>
                              <p class="text-sm font-medium text-gray-800">{{ assessment.title }}</p>
                              <p class="text-xs text-gray-500">{{ assessment.description }}</p>
                            </div>
                            <div class="flex items-center space-x-4">
                              <Badge v-if="assessment.status === 'active'" type="green">Active</Badge>
                              <Badge v-else type="red">Inactive</Badge>
                              <svg class="w-5 h-5 text-gray-400 transform transition-transform"
                                   :class="{ 'rotate-180': activeAssessment === assessment.id }"
                                   fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                              </svg>
                            </div>
                          </div>

                          <!-- Assessment Content -->
                          <div v-if="activeAssessment === assessment.id" class="mt-3 space-y-4">
                            <!-- Group Indicators -->
                            <div v-if="assessment.group_indicators && assessment.group_indicators.length > 0">
                              <h6 class="text-xs font-semibold text-gray-600 mb-2">Assessment Criteria Groups</h6>
                              <div v-for="group in assessment.group_indicators" :key="group.id" 
                                   class="bg-gray-50 rounded-lg p-3">
                                <div class="flex items-center space-x-2">
                                  <div class="w-5 h-5 rounded-full bg-purple-100 flex items-center justify-center">
                                    <span class="text-purple-600 text-xs font-medium">{{ group.order }}</span>
                                  </div>
                                  <div>
                                    <p class="text-sm font-medium text-gray-800">Group {{ group.order }}: {{ group.name }}</p>
                                    <p class="text-xs text-gray-500">{{ group.description }}</p>
                                  </div>
                                </div>

                                <!-- Indicators -->
                                <div v-if="group.indicators && group.indicators.length > 0" class="mt-3 space-y-3">
                                  <h6 class="text-xs font-semibold text-gray-600 mb-2">Assessment Indicators</h6>
                                  <div v-for="indicator in group.indicators" :key="indicator.id" 
                                       class="bg-white rounded-lg p-3 border border-gray-200">
                                    <div class="flex items-center space-x-2">
                                      <div class="w-4 h-4 rounded-full bg-indigo-100 flex items-center justify-center">
                                        <span class="text-indigo-600 text-xs font-medium">{{ indicator.order }}</span>
                                      </div>
                                      <div>
                                        <p class="text-sm font-medium text-gray-800">Indicator {{ indicator.order }}: {{ indicator.name }}</p>
                                        <p class="text-xs text-gray-500">{{ indicator.description }}</p>
                                      </div>
                                    </div>

                                    <!-- Sessions -->
                                    <div v-if="indicator.sessions && indicator.sessions.length > 0" class="mt-3 space-y-2">
                                      <h6 class="text-xs font-semibold text-gray-600 mb-2">Assessment Sessions</h6>
                                      <div v-for="session in indicator.sessions" :key="session.id" 
                                           class="bg-gray-50 rounded-lg p-2">
                                        <div class="flex items-center space-x-2">
                                          <div class="w-4 h-4 rounded-full bg-pink-100 flex items-center justify-center">
                                            <span class="text-pink-600 text-xs font-medium">{{ session.order }}</span>
                                          </div>
                                          <div>
                                            <p class="text-sm font-medium text-gray-800">Session {{ session.order }}: {{ session.name }}</p>
                                            <p class="text-xs text-gray-500">{{ session.description }}</p>
                                          </div>
                                        </div>

                                        <!-- Rubrics -->
                                        <div v-if="session.rubrics && session.rubrics.length > 0" class="mt-2 space-y-2">
                                          <h6 class="text-xs font-semibold text-gray-600 mb-2">Session Rubrics</h6>
                                          <div v-for="rubric in session.rubrics" :key="rubric.id" 
                                               class="bg-white rounded-lg p-2 border border-gray-200">
                                            <div class="flex items-center justify-between">
                                              <div>
                                                <p class="text-sm font-medium text-gray-800">{{ rubric.level }}</p>
                                                <p class="text-xs text-gray-500">{{ rubric.description }}</p>
                                              </div>
                                              <span class="text-sm font-medium text-gray-600">Score: {{ rubric.score }}</span>
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
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div v-else class="text-sm text-gray-500">
                No modules available for this phase
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template>
