<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import MyProfileSidebar from '@/Layouts/Sidebars/MyProfileSidebar.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ref, computed, onMounted, reactive } from 'vue';
import { ElNotification } from 'element-plus';

const props = defineProps({
  activity: {
    type: Object,
    required: true
  },
  participant: {
    type: Object,
    required: true
  },
  current_phase: {
    type: Object,
    default: null
  },
  current_module: {
    type: Object,
    default: null
  },
  current_material: {
    type: Object,
    default: null
  }
});

// Create reactive participant data to enable updates
const participantData = reactive({
  ...props.participant,
  material_progress: [...(props.participant.material_progress || [])]
});

onMounted(() => {
  console.log('Activity data:', props.activity);
  console.log('Participant data:', props.participant);
  console.log('Participant overall_progress:', props.participant.overall_progress);
  console.log('Material progress:', props.participant.material_progress);
  console.log('Material progress count:', props.participant.material_progress?.length);
  
  // Debug individual materials
  if (props.participant.material_progress) {
    props.participant.material_progress.forEach((mp, index) => {
      console.log(`Material ${index + 1}:`, mp);
    });
  }
  
  // Debug training program phases
  if (props.activity.activity_training_program?.phases && Array.isArray(props.activity.activity_training_program.phases)) {
    console.log('Phases:', props.activity.activity_training_program.phases);
    try {
      props.activity.activity_training_program.phases.forEach((phase, phaseIndex) => {
        if (phase && phase.name) {
          console.log(`Phase ${phaseIndex + 1}: ${phase.name}`);
          if (phase.modules && Array.isArray(phase.modules)) {
            phase.modules.forEach((module, moduleIndex) => {
              if (module && module.name) {
                console.log(`  Module ${moduleIndex + 1}: ${module.name} (${module.materials?.length || 0} materials)`);
              }
            });
          }
        }
      });
    } catch (error) {
      console.error('Error debugging phases:', error);
    }
  } else {
    console.log('No activity training program phases found or phases is not an array');
  }
});

const breadcrumbs = [
  { label: 'Yayasan', href: route('office') },
  { label: 'Profil Saya', href: route('office.myProfile') },
  { label: 'Aktivitas Pelatihan', href: route('office.myProfile.activity.trainingProgram.index') },
  { label: props.activity.title, href: route('office.myProfile.activity.trainingProgram.learn', { activityUuid: props.activity.uuid }) }
];

const selectedPhase = ref(props.current_phase);
const selectedModule = ref(props.current_module);
const selectedMaterial = ref(props.current_material);
const selectedContentType = ref('materials'); // 'materials', 'quizzes', 'assessments'

// Computed properties for real-time progress calculation
const calculateModuleProgress = (module) => {
  try {
    if (!module || !module.materials || !Array.isArray(module.materials)) return 0;
    
    const totalMaterials = module.materials.length;
    if (totalMaterials === 0) return 0;
    
    // Ensure participantData.material_progress is an array
    if (!participantData.material_progress || !Array.isArray(participantData.material_progress)) {
      return 0;
    }
    
    console.log(`Calculating progress for module: ${module.name}`);
    console.log('Module materials:', module.materials);
    
    const completedMaterials = module.materials.filter(material => {
      if (!material || !material.id) return false;
      console.log(`Checking material: ${material.title} (ID: ${material.id})`);
      
      const progress = participantData.material_progress.find(mp => {
        console.log(`Comparing with progress: mp.material_id=${mp.material_id}, mp.activity_material_id=${mp.activity_material_id}`);
        return mp && mp.material_id === material.id;
      });
      
      const isCompleted = progress && progress.completed_at;
      console.log(`Material ${material.title}: progress found=${!!progress}, completed=${isCompleted}`);
      
      return isCompleted;
    }).length;
    
    const progressPercentage = Math.round((completedMaterials / totalMaterials) * 100);
    console.log(`Module ${module.name}: ${completedMaterials}/${totalMaterials} completed = ${progressPercentage}%`);
    
    return progressPercentage;
  } catch (error) {
    console.error('Error calculating module progress:', error, module);
    return 0;
  }
};

const calculatePhaseProgress = (phase) => {
  try {
    if (!phase || !phase.modules || !Array.isArray(phase.modules)) return 0;
    
    const totalModules = phase.modules.length;
    if (totalModules === 0) return 0;
    
    const completedModules = phase.modules.filter(module => {
      if (!module) return false;
      return calculateModuleProgress(module) >= 100;
    }).length;
    
    return Math.round((completedModules / totalModules) * 100);
  } catch (error) {
    console.error('Error calculating phase progress:', error, phase);
    return 0;
  }
};

const getModuleStatus = (module) => {
  const progress = calculateModuleProgress(module);
  if (progress >= 100) return 'completed';
  if (progress > 0) return 'in_progress';
  return 'not_started';
};

const getPhaseStatus = (phase) => {
  const progress = calculatePhaseProgress(phase);
  if (progress >= 100) return 'completed';
  if (progress > 0) return 'in_progress';
  return 'not_started';
};

const getProgressColor = (progress) => {
  if (progress >= 100) return 'bg-green-500';
  if (progress >= 50) return 'bg-blue-500';
  return 'bg-gray-300';
};

const getStatusIcon = (status) => {
  switch(status) {
    case 'completed':
      return '✓';
    case 'in_progress':
      return '▶';
    default:
      return '○';
  }
};

const getStatusColor = (status) => {
  switch(status) {
    case 'completed':
      return 'text-green-600';
    case 'in_progress':
      return 'text-blue-600';
    default:
      return 'text-gray-400';
  }
};

const selectPhase = (phase) => {
  try {
    selectedPhase.value = phase;
    selectedModule.value = (phase && phase.modules && Array.isArray(phase.modules) && phase.modules.length > 0) 
      ? phase.modules[0] 
      : null;
    selectedMaterial.value = null;
    selectedContentType.value = 'materials';
  } catch (error) {
    console.error('Error selecting phase:', error);
  }
};

const selectModule = (module) => {
  selectedModule.value = module;
  selectedMaterial.value = null;
  selectedContentType.value = 'materials';
};

const selectMaterial = (material) => {
  selectedMaterial.value = material;
  
  // Mark material as viewed
  markMaterialAsViewed(material.id);
};

const markMaterialAsViewed = async (materialId) => {
  try {
    // Find the material object to get master_material_id
    const material = selectedModule.value?.materials?.find(m => m.id === materialId);
    if (!material) {
      console.error('Material not found:', materialId);
      return;
    }

    // Send master_material_id instead of activity material id
    const response = await window.axios.post(route('office.myProfile.activity.trainingProgram.markMaterialViewed'), {
      activity_uuid: props.activity.uuid,
      material_id: material.master_material_id  // Use master_material_id
    });
    
    // Update local material progress data
    // updateMaterialProgress(materialId, 'viewed');
  } catch (error) {
    console.error('Error marking material as viewed:', error);
  }
};

const markMaterialAsCompleted = async (materialId) => {
  try {
    // Find the material object to get master_material_id
    const material = selectedModule.value?.materials?.find(m => m.id === materialId);
    if (!material) {
      console.error('Material not found:', materialId);
      return;
    }

    // Send master_material_id instead of activity material id
    const response = await window.axios.post(route('office.myProfile.activity.trainingProgram.markMaterialCompleted'), {
      activity_uuid: props.activity.uuid,
      material_id: material.master_material_id  // Use master_material_id
    });
    
    // Update local material progress data using original materialId (activity material id)
    updateMaterialProgress(materialId, 'completed');
    
    // Show success notification
    ElNotification({
      title: 'Berhasil!',
      message: response.data.message || 'Materi berhasil ditandai selesai',
      type: 'success',
      position: 'top-right',
      duration: 3000
    });
    
    // Find next material to navigate to
    const currentModule = selectedModule.value;
    if (currentModule && currentModule.materials) {
      const currentIndex = currentModule.materials.findIndex(m => m.id === materialId);
      if (currentIndex < currentModule.materials.length - 1) {
        // Next material in same module
        setTimeout(() => {
          selectMaterial(currentModule.materials[currentIndex + 1]);
        }, 1000); // Small delay to show the success state
      } else {
        // Next module or phase
        setTimeout(() => {
          navigateToNextModule();
        }, 1000);
      }
    }
  } catch (error) {
    console.error('Error marking material as completed:', error);
    
    // Show error notification
    ElNotification({
      title: 'Error!',
      message: 'Gagal menandai materi selesai. Silakan coba lagi.',
      type: 'error',
      position: 'top-right',
      duration: 4000
    });
  }
};

// Helper function to update material progress
const updateMaterialProgress = (materialId, action) => {
  const existingProgressIndex = participantData.material_progress.findIndex(mp => mp.material_id === materialId);
  const currentTime = new Date().toISOString().slice(0, 19).replace('T', ' ');
  
  if (existingProgressIndex >= 0) {
    // Update existing progress
    const existingProgress = participantData.material_progress[existingProgressIndex];
    if (action === 'viewed' && !existingProgress.viewed_at) {
      existingProgress.viewed_at = currentTime;
    } else if (action === 'completed') {
      existingProgress.completed_at = currentTime;
      if (!existingProgress.viewed_at) {
        existingProgress.viewed_at = currentTime;
      }
    }
  } else {
    // Create new progress entry
    const newProgress = {
      id: Date.now(), // temporary ID
      material_id: materialId,
      participant_id: participantData.id,
      viewed_at: action === 'viewed' || action === 'completed' ? currentTime : null,
      completed_at: action === 'completed' ? currentTime : null,
      time_spent: 0
    };
    participantData.material_progress.push(newProgress);
  }
  
  // Update overall progress in participantData to sync with computed value
  participantData.overall_progress = calculateOverallProgress.value;
  console.log('Updated overall progress to:', participantData.overall_progress);
};

const navigateToNextModule = () => {
  try {
    const currentPhase = selectedPhase.value;
    if (!currentPhase || !currentPhase.modules || !Array.isArray(currentPhase.modules)) return;
    
    const currentModuleIndex = currentPhase.modules.findIndex(m => m && m.uuid === selectedModule.value?.uuid);
    if (currentModuleIndex < currentPhase.modules.length - 1) {
      // Next module in same phase
      selectModule(currentPhase.modules[currentModuleIndex + 1]);
    } else {
      // Next phase
      const phases = props.activity.activity_training_program?.phases;
      if (!phases || !Array.isArray(phases)) return;
      
      const currentPhaseIndex = phases.findIndex(p => p && p.uuid === currentPhase.uuid);
      if (currentPhaseIndex >= 0 && currentPhaseIndex < phases.length - 1) {
        selectPhase(phases[currentPhaseIndex + 1]);
      }
    }
  } catch (error) {
    console.error('Error navigating to next module:', error);
  }
};

const takeQuiz = (quiz) => {
  router.get(route('office.myProfile.activity.trainingProgram.takeQuiz', {
    activityUuid: props.activity.uuid,
    quizId: quiz.id
  }));
};

const viewAssessment = (assessment) => {
  router.get(route('office.myProfile.activity.trainingProgram.viewAssessment', {
    activityUuid: props.activity.uuid,
    assessmentId: assessment.id
  }));
};

const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 Bytes';
  const k = 1024;
  const sizes = ['Bytes', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
};

const downloadMaterial = (material) => {
  if (material.file_path) {
    window.open(material.file_path, '_blank');
  }
};

// Initialize with first available content
onMounted(() => {
  try {
    if (!selectedPhase.value && 
        props.activity.activity_training_program?.phases && 
        Array.isArray(props.activity.activity_training_program.phases) && 
        props.activity.activity_training_program.phases.length > 0) {
      selectPhase(props.activity.activity_training_program.phases[0]);
    }
  } catch (error) {
    console.error('Error initializing phase:', error);
  }
});

const currentContent = computed(() => {
  if (!selectedModule.value) return [];
  
  switch(selectedContentType.value) {
    case 'quizzes':
      return selectedModule.value.quizzes || [];
    case 'assessments':
      return selectedModule.value.assessments || [];
    default:
      return selectedModule.value.materials || [];
  }
});

// Function to get material progress status
const getMaterialProgressStatus = (materialId) => {
  console.log('Getting material progress status for materialId:', materialId);
  console.log('Available material progress:', participantData.material_progress);
  
  const materialProgress = participantData.material_progress?.find(mp => {
    console.log(`Checking progress: mp.material_id=${mp.material_id}, mp.activity_material_id=${mp.activity_material_id}, mp.master_material_id=${mp.master_material_id}, mp.old_material_id=${mp.old_material_id}`);
    return mp.material_id === materialId;
  });
  
  console.log('Found material progress:', materialProgress);
  
  if (!materialProgress) {
    return 'not_started';
  }
  
  if (materialProgress.completed_at) {
    return 'completed';
  } else if (materialProgress.viewed_at) {
    return 'viewed';
  } else {
    return 'not_started';
  }
};

// Computed overall progress based on phase completion
const calculateOverallProgress = computed(() => {
  // Check if activity training program exists and has phases
  if (!props.activity.activity_training_program?.phases || !Array.isArray(props.activity.activity_training_program.phases)) {
    return participantData.overall_progress || 0;
  }
  
  const phases = props.activity.activity_training_program.phases;
  const totalPhases = phases.length;
  if (totalPhases === 0) return participantData.overall_progress || 0;
  
  // Calculate average progress across all phases
  let totalProgress = 0;
  try {
    phases.forEach(phase => {
      if (phase && typeof phase === 'object') {
        totalProgress += calculatePhaseProgress(phase);
      }
    });
    
    const calculatedProgress = Math.round(totalProgress / totalPhases);
    console.log(`Overall Progress Calculation: Total Progress ${totalProgress} / ${totalPhases} phases = ${calculatedProgress}%`);
    return calculatedProgress;
  } catch (error) {
    console.error('Error calculating overall progress:', error);
    return participantData.overall_progress || 0;
  }
});

// Computed participant status based on progress
const participantStatus = computed(() => {
  const progress = calculateOverallProgress.value;
  if (progress >= 100) return 'completed';
  if (progress > 0) return 'in_progress';
  return 'not_started';
});
</script>

<template>
  <Head :title="`Belajar - ${activity.title}`" />

  <OfficeLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
      <div class="mx-4 py-3">
        <div class="flex justify-between items-start">
          <div>
            <h1 class="text-2xl font-bold text-gray-900">{{ activity.title }}</h1>
            <p class="mt-1 text-sm text-gray-600" v-if="activity.description">{{ activity.description }}</p>
          </div>
          <div class="flex items-center space-x-4">
            <div class="text-right">
              <p class="text-sm text-gray-600">Progress Keseluruhan</p>
              <div class="flex items-center space-x-2">
                <div class="w-32 bg-gray-200 rounded-full h-2">
                  <div class="bg-blue-600 h-2 rounded-full" 
                       :style="`width: ${calculateOverallProgress}%`"></div>
                </div>
                <span class="text-sm font-medium">{{ calculateOverallProgress }}%</span>
              </div>
            </div>
            <Badge v-if="participantStatus === 'completed'" type="green">Selesai</Badge>
            <Badge v-else-if="participantStatus === 'in_progress'" type="yellow">Sedang Belajar</Badge>
            <Badge v-else type="blue">Terdaftar</Badge>
          </div>
        </div>
      </div>
    </template>
    <template #sidebar>
      <MyProfileSidebar />
    </template>
    <template #content>
      <div class="flex h-screen bg-gray-50">
        <!-- Sidebar Navigation -->
        <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
          <div class="p-4">
            <h3 class="text-lg font-medium text-gray-900 mb-4">Kurikulum Pelatihan</h3>
            
            <!-- Phases Navigation -->
            <div v-if="activity.activity_training_program?.phases && Array.isArray(activity.activity_training_program.phases) && activity.activity_training_program.phases.length > 0" class="space-y-2">
              <div v-for="(phase, phaseIndex) in activity.activity_training_program.phases" :key="phase.uuid || phaseIndex">
                <button 
                  @click="selectPhase(phase)"
                  :class="[
                    'w-full text-left p-3 rounded-lg border transition-colors',
                    selectedPhase?.uuid === phase.uuid 
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
                        <div class="font-medium">{{ phase.name || 'Untitled Phase' }}</div>
                        <div class="text-sm text-gray-500">{{ (phase.modules && Array.isArray(phase.modules) ? phase.modules.length : 0) }} modul</div>
                      </div>
                    </div>
                    <div class="text-right">
                      <div class="text-xs text-gray-500">{{ calculatePhaseProgress(phase) }}%</div>
                      <div class="w-12 bg-gray-200 rounded-full h-1">
                        <div :class="getProgressColor(calculatePhaseProgress(phase))" 
                             class="h-1 rounded-full" 
                             :style="`width: ${calculatePhaseProgress(phase)}%`"></div>
                      </div>
                    </div>
                  </div>
                </button>

                <!-- Modules for selected phase -->
                <div v-if="selectedPhase?.uuid === phase.uuid && phase.modules && Array.isArray(phase.modules)" class="ml-4 mt-2 space-y-1">
                  <button 
                    v-for="(module, moduleIndex) in phase.modules" 
                    :key="module.uuid || moduleIndex"
                    @click="selectModule(module)"
                    :class="[
                      'w-full text-left p-2 rounded border text-sm transition-colors',
                      selectedModule?.uuid === module.uuid 
                        ? 'border-blue-300 bg-blue-25 text-blue-600' 
                        : 'border-gray-100 hover:border-gray-200'
                    ]"
                  >
                    <div class="flex items-center justify-between">
                      <div class="flex items-center space-x-2">
                        <span :class="getStatusColor(getModuleStatus(module))">{{ getStatusIcon(getModuleStatus(module)) }}</span>
                        <span>{{ module.name || 'Untitled Module' }}</span>
                      </div>
                      <div class="text-xs text-gray-500">{{ calculateModuleProgress(module) }}%</div>
                    </div>
                  </button>
                </div>
              </div>
            </div>

            <!-- Manual Activity Message -->
            <div v-else class="text-center py-8">
              <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.663 17h4.673M12 3v1m6.364 1.636l-.707.707M21 12h-1M4 12H3m3.343-5.657l-.707-.707m2.828 9.9a5 5 0 117.072 0l-.548.547A3.374 3.374 0 0014 18.469V19a2 2 0 11-4 0v-.531c0-.895-.356-1.754-.988-2.386l-.548-.547z"></path>
              </svg>
              <h3 class="mt-2 text-sm font-medium text-gray-900">Aktivitas Manual</h3>
              <p class="mt-1 text-sm text-gray-500">Aktivitas ini tidak memiliki kurikulum terstruktur.</p>
            </div>
          </div>
        </div>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col">
          <!-- Content Navigation -->
          <div v-if="selectedModule" class="bg-white border-b border-gray-200 p-4">
            <div class="flex items-center justify-between">
              <div>
                <h2 class="text-xl font-semibold text-gray-900">{{ selectedModule.name }}</h2>
                <p class="text-sm text-gray-600" v-if="selectedModule.description">{{ selectedModule.description }}</p>
              </div>
              <div class="flex items-center space-x-4">
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
          </div>

          <!-- Content Display -->
          <div class="flex-1 overflow-hidden">
            <div class="h-full flex">
              <!-- Content List -->
              <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
                <div class="p-4">
                  <div v-if="currentContent.length > 0" class="space-y-2">
                    <!-- Materials -->
                    <div v-if="selectedContentType === 'materials'" class="space-y-2">
                      <div 
                        v-for="(material, index) in currentContent" 
                        :key="material.uuid"
                        @click="selectMaterial(material)"
                        :class="[
                          'p-3 rounded-lg border cursor-pointer transition-colors',
                          selectedMaterial?.uuid === material.uuid 
                            ? 'border-blue-500 bg-blue-50' 
                            : 'border-gray-200 hover:border-gray-300'
                        ]"
                      >
                        <div class="flex items-start space-x-3">
                          <div class="flex-shrink-0 mt-1">
                            <span :class="getStatusColor(getMaterialProgressStatus(material.id))">
                              {{ getStatusIcon(getMaterialProgressStatus(material.id)) }}
                            </span>
                          </div>
                          <div class="flex-1 min-w-0">
                            <div class="font-medium text-sm">{{ material.title }}</div>
                            <div class="text-xs text-gray-500">{{ material.type }}</div>
                            <div v-if="material.file_size" class="text-xs text-gray-400">
                              {{ formatFileSize(material.file_size) }}
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Quizzes -->
                    <div v-else-if="selectedContentType === 'quizzes'" class="space-y-2">
                      <div 
                        v-for="quiz in currentContent" 
                        :key="quiz.uuid"
                        :class="[
                          'p-3 rounded-lg border cursor-pointer transition-colors',
                          quiz.passed 
                            ? 'border-green-500 bg-green-50 hover:bg-green-100' 
                            : quiz.completed
                            ? 'border-orange-500 bg-orange-50 hover:bg-orange-100'
                            : 'border-gray-200 hover:border-gray-300'
                        ]"
                        @click="takeQuiz(quiz)"
                      >
                        <div class="flex items-start space-x-3">
                          <div class="flex-shrink-0 mt-1">
                            <span :class="quiz.passed ? 'text-green-600' : quiz.completed ? 'text-orange-600' : 'text-gray-400'">
                              {{ quiz.passed ? '✓' : quiz.completed ? '!' : '○' }}
                            </span>
                          </div>
                          <div class="flex-1">
                            <div class="flex items-center space-x-2">
                              <div class="font-medium text-sm">{{ quiz.title }}</div>
                              <Badge v-if="quiz.passed" type="green" class="text-xs">
                                Lulus
                              </Badge>
                              <Badge v-else-if="quiz.completed" type="orange" class="text-xs">
                                Selesai
                              </Badge>
                            </div>
                            <div class="text-xs text-gray-500">{{ quiz.questions?.length || 0 }} pertanyaan</div>
                            <div class="text-xs text-gray-500" v-if="quiz.time_limit">
                              Waktu: {{ quiz.time_limit }} menit
                            </div>
                            <div v-if="quiz.attempt_count > 0" class="text-xs text-gray-500">
                              Percobaan: {{ quiz.attempt_count }}x
                            </div>
                          </div>
                          <div class="text-right">
                            <div v-if="quiz.best_score !== null" class="text-xs font-medium" 
                                 :class="quiz.passed ? 'text-green-600' : 'text-orange-600'">
                              Terbaik: {{ Math.round(quiz.best_score) }}%
                            </div>
                            <div v-if="quiz.latest_score !== null && quiz.latest_score !== quiz.best_score" 
                                 class="text-xs text-gray-500">
                              Terakhir: {{ Math.round(quiz.latest_score) }}%
                            </div>
                            <div v-if="quiz.passed" class="text-xs text-green-600">
                              Lulus
                            </div>
                            <div v-else-if="quiz.completed" class="text-xs text-orange-600">
                              Belum Lulus
                            </div>
                            <div v-else class="text-xs text-gray-500">
                              Belum dikerjakan
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- Assessments -->
                    <div v-else-if="selectedContentType === 'assessments'" class="space-y-2">
                      <div 
                        v-for="assessment in currentContent" 
                        :key="assessment.uuid"
                        :class="[
                          'p-3 rounded-lg border cursor-pointer transition-colors',
                          assessment.completed 
                            ? 'border-green-500 bg-green-50 hover:bg-green-100' 
                            : 'border-gray-200 hover:border-gray-300'
                        ]"
                        @click="viewAssessment(assessment)"
                      >
                        <div class="flex items-start justify-between">
                          <div class="flex-1">
                            <div class="flex items-center space-x-2">
                              <div class="font-medium text-sm">{{ assessment.title }}</div>
                              <Badge v-if="assessment.completed" type="green" class="text-xs">
                                Sudah Dinilai
                              </Badge>
                              <Badge v-else type="gray" class="text-xs">
                                Belum Dinilai
                              </Badge>
                            </div>
                            <div class="text-xs text-gray-500">{{ assessment.type }}</div>
                            <div class="text-xs text-gray-500" v-if="assessment.description">
                              {{ assessment.description.substring(0, 80) }}...
                            </div>
                          </div>
                          <div class="text-right">
                            <div v-if="assessment.score !== null && assessment.score !== undefined" class="text-xs font-medium text-blue-600">
                              Nilai: {{ Math.round(assessment.score) }}
                            </div>
                            <div v-if="assessment.assessed_at" class="text-xs text-gray-400">
                              {{ assessment.assessed_at }}
                            </div>
                            <div class="text-xs" :class="assessment.completed ? 'text-green-600' : 'text-gray-500'">
                              {{ assessment.status || 'Belum dinilai' }}
                            </div>
                            <div v-if="assessment.completed && assessment.is_passed !== undefined" class="text-xs font-medium mt-1" 
                                 :class="assessment.is_passed ? 'text-green-600' : 'text-red-600'">
                              {{ assessment.is_passed ? 'Lulus' : 'Tidak Lulus' }}
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div v-else class="text-center py-8">
                    <p class="text-sm text-gray-500">
                      Tidak ada {{ 
                        selectedContentType === 'materials' ? 'materi' : 
                        selectedContentType === 'quizzes' ? 'kuis' : 'penilaian' 
                      }} dalam modul ini.
                    </p>
                  </div>
                </div>
              </div>

              <!-- Material Viewer -->
              <div class="flex-1 bg-white overflow-y-auto">
                <div v-if="selectedMaterial" class="p-6">
                  <div class="max-w-4xl mx-auto">
                    <div class="mb-6">
                      <h3 class="text-2xl font-bold text-gray-900">{{ selectedMaterial.title }}</h3>
                      <p class="text-gray-600 mt-2" v-if="selectedMaterial.description">
                        {{ selectedMaterial.description }}
                      </p>
                    </div>

                    <!-- Material Content -->
                    <div class="space-y-6">
                      <!-- Text Content -->
                      <div v-if="selectedMaterial.content" class="prose max-w-none" v-html="selectedMaterial.content"></div>

                      <!-- Video Content -->
                      <div v-if="selectedMaterial.video_url" class="aspect-video">
                        <iframe 
                          :src="selectedMaterial.video_url" 
                          class="w-full h-full rounded-lg"
                          frameborder="0" 
                          allowfullscreen
                        ></iframe>
                      </div>

                      <!-- File Download -->
                      <div v-if="selectedMaterial.file_path" class="bg-gray-50 rounded-lg p-4">
                        <div class="flex items-center justify-between">
                          <div class="flex items-center space-x-3">
                            <svg class="h-8 w-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                            <div>
                              <div class="font-medium">{{ selectedMaterial.file_name || 'Download File' }}</div>
                              <div class="text-sm text-gray-500" v-if="selectedMaterial.file_size">
                                {{ formatFileSize(selectedMaterial.file_size) }}
                              </div>
                            </div>
                          </div>
                          <OutlineButton @click="downloadMaterial(selectedMaterial)" type="primary">
                            Download
                          </OutlineButton>
                        </div>
                      </div>

                      <!-- External Link -->
                      <div v-if="selectedMaterial.external_url" class="bg-blue-50 rounded-lg p-4">
                        <div class="flex items-center justify-between">
                          <div class="flex items-center space-x-3">
                            <svg class="h-8 w-8 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path>
                            </svg>
                            <div>
                              <div class="font-medium">Tautan Eksternal</div>
                              <div class="text-sm text-gray-600">Buka dalam tab baru</div>
                            </div>
                          </div>
                          <a :href="selectedMaterial.external_url" target="_blank" rel="noopener noreferrer">
                            <OutlineButton type="primary">
                              Buka Tautan
                            </OutlineButton>
                          </a>
                        </div>
                      </div>
                    </div>

                    <!-- Material Actions -->
                    <div class="mt-8 flex justify-between items-center">
                      <div>
                        <Badge v-if="getMaterialProgressStatus(selectedMaterial.id) === 'completed'" type="green">
                          Selesai
                        </Badge>
                        <Badge v-else-if="getMaterialProgressStatus(selectedMaterial.id) === 'viewed'" type="yellow">
                          Sudah Dilihat
                        </Badge>
                        <Badge v-else type="gray">
                          Belum Dilihat
                        </Badge>
                      </div>
                      <div class="space-x-2">
                        <OutlineButton 
                          v-if="getMaterialProgressStatus(selectedMaterial.id) !== 'completed'"
                          @click="markMaterialAsCompleted(selectedMaterial.id)" 
                          type="green"
                        >
                          Tandai Selesai
                        </OutlineButton>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- No Material Selected -->
                <div v-else class="flex items-center justify-center h-full">
                  <div class="text-center">
                    <svg class="mx-auto h-12 w-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    <h3 class="mt-2 text-sm font-medium text-gray-900">Pilih Materi</h3>
                    <p class="mt-1 text-sm text-gray-500">Pilih materi dari sidebar untuk mulai belajar.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>
  </OfficeLayout>
</template> 