<script setup>
import { ref, watch, computed } from 'vue';
import { ElNotification } from 'element-plus';
import Badge from '@/Components/Badge.vue';

const props = defineProps({
    propertyModal: {
        type: Object,
        required: true
    }
});

const emit = defineEmits(['close', 'update:assessment', 'remove']);

const formRef = ref();
const process = ref(false);

// Assessment data
const assessment = ref({
    title: '',
    description: '',
    calculation_method: 'AVERAGE',
    passing_score: 70,
    group_indicators: []
});

// Navigation state
const selectedGroup = ref(null);
const selectedIndicator = ref(null);
const selectedSession = ref(null);
const currentView = ref('assessment'); // 'assessment', 'group', 'indicator', 'session'
const expandedIndicator = ref(null); // Track which indicator is expanded to show sessions

// Rubric library
const rubricLibrary = ref([
    {
        id: 1,
        name: "Basic Performance (1-4)",
        description: "Standard 4-point performance scale",
        rubrics: [
            { level: "Excellent", description: "Exceeds expectations significantly", score: 4 },
            { level: "Good", description: "Meets all expectations", score: 3 },
            { level: "Fair", description: "Approaching expectations", score: 2 },
            { level: "Poor", description: "Below expectations", score: 1 }
        ]
    },
    {
        id: 2,
        name: "Percentage Based (A-D)",
        description: "Letter grade percentage system",
        rubrics: [
            { level: "A", description: "90-100% mastery", score: 95 },
            { level: "B", description: "80-89% proficient", score: 85 },
            { level: "C", description: "70-79% developing", score: 75 },
            { level: "D", description: "60-69% beginning", score: 65 }
        ]
    },
    {
        id: 3,
        name: "Competency Scale",
        description: "Competency-based assessment scale",
        rubrics: [
            { level: "Advanced", description: "Demonstrates mastery beyond expectations", score: 100 },
            { level: "Proficient", description: "Demonstrates competency as expected", score: 80 },
            { level: "Developing", description: "Approaching competency", score: 60 },
            { level: "Beginning", description: "Limited demonstration of competency", score: 40 }
        ]
    }
]);

// Show rubric library modal
const showRubricLibrary = ref(false);

// Validation rules
const rules = {
    title: [
        { required: true, message: 'Assessment title is required', trigger: 'blur' },
        { max: 255, message: 'Assessment title must not exceed 255 characters', trigger: 'blur' }
    ],
    calculation_method: [
        { required: true, message: 'Calculation method is required', trigger: 'change' }
    ],
    passing_score: [
        { required: true, message: 'Passing score is required', trigger: 'blur' },
        { type: 'number', min: 0, max: 100, message: 'Passing score must be between 0 and 100', trigger: 'blur' }
    ]
};

// Computed for current content based on selection
const currentContent = computed(() => {
    if (currentView.value === 'session' && selectedSession.value) {
        return selectedSession.value;
    } else if (currentView.value === 'indicator' && selectedIndicator.value) {
        return selectedIndicator.value;
    } else if (currentView.value === 'group' && selectedGroup.value) {
        return selectedGroup.value;
    }
    return assessment.value;
});

// Navigation functions
const selectAssessment = () => {
    currentView.value = 'assessment';
    selectedGroup.value = null;
    selectedIndicator.value = null;
    selectedSession.value = null;
    expandedIndicator.value = null;
};

const selectGroup = (group) => {
    currentView.value = 'group';
    selectedGroup.value = group;
    selectedIndicator.value = (group?.indicators?.length > 0) ? group.indicators[0] : null;
    selectedSession.value = null;
    expandedIndicator.value = null; // Reset expanded indicator when changing group
};

const selectIndicator = (indicator) => {
    currentView.value = 'indicator';
    selectedIndicator.value = indicator;
    selectedSession.value = (indicator?.sessions?.length > 0) ? indicator.sessions[0] : null;
    
    // Toggle expansion for sessions - if clicking same indicator, toggle; if different, expand new one
    if (expandedIndicator.value === indicator) {
        expandedIndicator.value = null; // Collapse if clicking same indicator
    } else {
        expandedIndicator.value = indicator; // Expand new indicator
    }
};

const selectSession = (session) => {
    currentView.value = 'session';
    selectedSession.value = session;
};

// Watch for changes in propertyModal.data
watch(() => props.propertyModal.data, (newData) => {
    if (newData) {
        const group_indicators = newData.group_indicators || [];
        assessment.value = {
            title: newData.title || '',
            description: newData.description || '',
            calculation_method: newData.calculation_method || 'AVERAGE',
            passing_score: newData.passing_score || 70,
            group_indicators: group_indicators.map((group, groupIndex) => {
                const indicators = group.indicators || [];
                return {
                    name: group.name || '',
                    description: group.description || '',
                    order: group.order || groupIndex + 1,
                    indicators: indicators.map((indicator, indicatorIndex) => {
                        const sessions = indicator.sessions || [];
                        return {
                            name: indicator.name || '',
                            description: indicator.description || '',
                            order: indicator.order || indicatorIndex + 1,
                            sessions: sessions.map((session, sessionIndex) => ({
                                name: session.name || '',
                                description: session.description || '',
                                order: session.order || sessionIndex + 1,
                                rubrics: Array.isArray(session.rubrics) ? session.rubrics : []
                            }))
                        };
                    })
                };
            })
        };
        
        // Initialize selection
        if (assessment.value.group_indicators.length > 0) {
            selectGroup(assessment.value.group_indicators[0]);
        }
    } else {
        // Initialize empty assessment if no data
        assessment.value = {
            title: '',
            description: '',
            calculation_method: 'AVERAGE',
            passing_score: 70,
            group_indicators: []
        };
    }
}, { immediate: true });

// CRUD Functions
const addGroupIndicator = () => {
    const maxOrder = assessment.value.group_indicators.reduce((max, group) => 
        Math.max(max, group.order || 0), 0);
    
    const newGroup = {
        name: '',
        description: '',
        order: maxOrder + 1,
        indicators: []
    };
    
    assessment.value.group_indicators.push(newGroup);
    selectGroup(newGroup);
};

const removeGroupIndicator = (index) => {
    if (assessment.value.group_indicators.length <= 1) return;
    
    const removedGroup = assessment.value.group_indicators[index];
    assessment.value.group_indicators.splice(index, 1);
    
    // Reorder remaining groups
    assessment.value.group_indicators.forEach((group, idx) => {
        group.order = idx + 1;
    });
    
    // Update selection if removed group was selected
    if (selectedGroup.value === removedGroup) {
        selectGroup(assessment.value.group_indicators[0] || null);
    }
};

const addIndicator = (groupIndex) => {
    // Get the group either from parameter or from currently selected
    let group;
    if (groupIndex !== undefined) {
        group = assessment.value.group_indicators[groupIndex];
    } else {
        group = selectedGroup.value;
    }
    
    if (!group) return;
    
    // Ensure indicators array exists
    if (!group.indicators) {
        group.indicators = [];
    }
    
    const maxOrder = group.indicators.reduce((max, indicator) => 
        Math.max(max, indicator.order || 0), 0);
    
    const newIndicator = {
        name: '',
        description: '',
        order: maxOrder + 1,
        sessions: []
    };
    
    group.indicators.push(newIndicator);
    selectIndicator(newIndicator);
    expandedIndicator.value = newIndicator; // Auto-expand newly added indicator
};

const removeIndicator = (groupIndex, indicatorIndex) => {
    // Find the group - try from parameter first, then from selection
    let group;
    if (groupIndex !== undefined) {
        group = assessment.value.group_indicators[groupIndex];
    } else {
        group = selectedGroup.value;
    }
    
    if (!group || !group.indicators || group.indicators.length <= 1) return;
    
    // Find indicator to remove
    let removedIndicator;
    if (indicatorIndex !== undefined) {
        removedIndicator = group.indicators[indicatorIndex];
        group.indicators.splice(indicatorIndex, 1);
    } else {
        // Remove currently selected indicator
        const currentIndicatorIndex = group.indicators.findIndex(i => i === selectedIndicator.value);
        if (currentIndicatorIndex >= 0) {
            removedIndicator = group.indicators[currentIndicatorIndex];
            group.indicators.splice(currentIndicatorIndex, 1);
        }
    }
    
    // Reorder remaining indicators
    group.indicators.forEach((indicator, idx) => {
        indicator.order = idx + 1;
    });
    
    // Update selection if removed indicator was selected
    if (selectedIndicator.value === removedIndicator) {
        selectIndicator(group.indicators[0] || null);
    }
};

const addSession = (groupIndex, indicatorIndex) => {
    // Get the indicator either from parameters or from currently selected
    let indicator;
    if (groupIndex !== undefined && indicatorIndex !== undefined) {
        indicator = assessment.value.group_indicators[groupIndex].indicators[indicatorIndex];
    } else {
        indicator = selectedIndicator.value;
    }
    
    if (!indicator) return;
    
    // Ensure sessions array exists
    if (!indicator.sessions) {
        indicator.sessions = [];
    }
    
    const maxOrder = indicator.sessions.reduce((max, session) => 
        Math.max(max, session.order || 0), 0);
    
    const newSession = {
        name: '',
        description: '',
        order: maxOrder + 1,
        rubrics: []
    };
    
    indicator.sessions.push(newSession);
    selectSession(newSession);
};

const removeSession = (groupIndex, indicatorIndex, sessionIndex) => {
    // Find the indicator - try from parameters first, then from selection
    let indicator;
    if (groupIndex !== undefined && indicatorIndex !== undefined) {
        indicator = assessment.value.group_indicators[groupIndex]?.indicators[indicatorIndex];
    } else {
        indicator = selectedIndicator.value;
    }
    
    if (!indicator || !indicator.sessions || indicator.sessions.length <= 1) return;
    
    // Find session to remove
    let removedSession;
    if (sessionIndex !== undefined) {
        removedSession = indicator.sessions[sessionIndex];
        indicator.sessions.splice(sessionIndex, 1);
    } else {
        // Remove currently selected session
        const currentSessionIndex = indicator.sessions.findIndex(s => s === selectedSession.value);
        if (currentSessionIndex >= 0) {
            removedSession = indicator.sessions[currentSessionIndex];
            indicator.sessions.splice(currentSessionIndex, 1);
        }
    }
    
    // Reorder remaining sessions
    indicator.sessions.forEach((session, idx) => {
        session.order = idx + 1;
    });
    
    // Update selection if removed session was selected
    if (selectedSession.value === removedSession) {
        selectSession(indicator.sessions[0] || null);
    }
};

const addRubric = () => {
    if (!selectedSession.value) return;
    
    // Ensure rubrics array exists
    if (!selectedSession.value.rubrics) {
        selectedSession.value.rubrics = [];
    }
    
    selectedSession.value.rubrics.push({
        level: '',
        description: '',
        score: 0
    });
};

const removeRubric = (rubricIndex) => {
    if (!selectedSession.value || !selectedSession.value.rubrics) return;
    if (rubricIndex < 0 || rubricIndex >= selectedSession.value.rubrics.length) return;
    
    selectedSession.value.rubrics.splice(rubricIndex, 1);
};

const useRubricTemplate = (template) => {
    if (!selectedSession.value) return;
    
    selectedSession.value.rubrics = template.rubrics.map(rubric => ({ ...rubric }));
    showRubricLibrary.value = false;
    
    ElNotification({
        title: 'Success',
        message: `Applied rubric template: ${template.name}`,
        type: 'success'
    });
};

const handleSubmit = () => {
    formRef.value.validate((valid) => {
        if (valid) {
            process.value = true;
            
            // Basic validation passed, now validate nested structures
            let hasErrors = false;
            let errorMessages = [];

            // Validate assessment
            if (!assessment.value.title.trim()) {
                hasErrors = true;
                errorMessages.push('Assessment title is required');
            }

            // Validate groups
            if (assessment.value.group_indicators.length === 0) {
                hasErrors = true;
                errorMessages.push('At least one group indicator is required');
            }

            assessment.value.group_indicators.forEach((group, groupIndex) => {
                if (!group.name.trim()) {
                    hasErrors = true;
                    errorMessages.push(`Group ${groupIndex + 1} name is required`);
                }

                if (group.indicators.length === 0) {
                    hasErrors = true;
                    errorMessages.push(`Group ${groupIndex + 1} must have at least one indicator`);
                }

                group.indicators.forEach((indicator, indicatorIndex) => {
                    if (!indicator.name.trim()) {
                        hasErrors = true;
                        errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1} name is required`);
                    }

                    if (indicator.sessions.length === 0) {
                        hasErrors = true;
                        errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1} must have at least one session`);
                    }

                    indicator.sessions.forEach((session, sessionIndex) => {
                        if (!session.name.trim()) {
                            hasErrors = true;
                            errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1} name is required`);
                        }

                        if (session.rubrics.length === 0) {
                            hasErrors = true;
                            errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1} must have at least one rubric`);
                        }

                        session.rubrics.forEach((rubric, rubricIndex) => {
                            if (!rubric.level.trim()) {
                                hasErrors = true;
                                errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1}, Rubric ${rubricIndex + 1} level is required`);
                            }
                            if (rubric.score < 0 || rubric.score > 100) {
                                hasErrors = true;
                                errorMessages.push(`Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1}, Rubric ${rubricIndex + 1} score must be between 0 and 100`);
                            }
                        });
                    });
                });
            });

            if (hasErrors) {
                ElNotification({
                    title: 'Validation Error',
                    message: errorMessages.slice(0, 3).join('\n') + (errorMessages.length > 3 ? '\n...' : ''),
                    type: 'error',
                    duration: 5000
                });
                process.value = false;
                return;
            }

            emit('update:assessment', { ...assessment.value });
            emit('close');
            process.value = false;
        }
    });
};

const handleRemove = () => {
    emit('remove');
};
</script>

<template>
    <div class="flex h-[80vh] bg-gray-50">
        <!-- Left Sidebar - Assessment Structure -->
        <div class="w-80 bg-white border-r border-gray-200 overflow-y-auto">
            <div class="p-4">
                <!-- Assessment Info -->
                <div class="mb-6">
                    <button 
                        @click="selectAssessment"
                        :class="[
                            'w-full text-left p-3 rounded-lg border transition-colors',
                            currentView === 'assessment' 
                                ? 'border-blue-500 bg-blue-50 text-blue-700' 
                                : 'border-gray-200 hover:border-gray-300'
                        ]"
                    >
                        <div class="flex items-center space-x-3">
                            <div class="flex-shrink-0 w-8 h-8 rounded-full bg-purple-100 flex items-center justify-center">
                                <span class="text-sm font-medium text-purple-600">📋</span>
                            </div>
                            <div>
                                <div class="font-medium">{{ assessment.title || 'Assessment Info' }}</div>
                                <div class="text-sm text-gray-500">Basic information</div>
                            </div>
                        </div>
                    </button>
                </div>

                <!-- Groups Navigation -->
                <div>
                    <div class="flex items-center justify-between mb-4">
                        <h3 class="text-lg font-medium text-gray-900">Assessment Structure</h3>
                        <el-button type="primary" plain @click="addGroupIndicator" :disabled="process" size="small">
                            + Group
                        </el-button>
                    </div>
                    
                    <div class="space-y-2">
                        <div v-for="(group, groupIndex) in assessment.group_indicators" :key="groupIndex">
                            <button 
                                @click="selectGroup(group)"
                                :class="[
                                    'w-full text-left p-3 rounded-lg border transition-colors',
                                    selectedGroup === group 
                                        ? 'border-blue-500 bg-blue-50 text-blue-700' 
                                        : 'border-gray-200 hover:border-gray-300'
                                ]"
                            >
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center space-x-3">
                                        <div class="flex-shrink-0 w-6 h-6 rounded-full bg-blue-100 flex items-center justify-center">
                                            <span class="text-xs font-medium text-blue-600">{{ groupIndex + 1 }}</span>
                                        </div>
                                        <div>
                                            <div class="font-medium">{{ group.name || `Group ${groupIndex + 1}` }}</div>
                                            <div class="text-sm text-gray-500">{{ group.indicators?.length || 0 }} indicators</div>
                                        </div>
                                    </div>
                                    <el-button
                                        v-if="assessment.group_indicators.length > 1"
                                        type="danger"
                                        plain
                                        size="small"
                                        @click.stop="removeGroupIndicator(groupIndex)"
                                        :disabled="process"
                                    >
                                        ×
                                    </el-button>
                                </div>
                            </button>

                            <!-- Indicators for selected group -->
                            <div v-if="selectedGroup === group && group.indicators" class="ml-4 mt-2 space-y-1">
                                <div v-for="(indicator, indicatorIndex) in group.indicators" :key="indicatorIndex" class="space-y-1">
                                    <button 
                                        @click="selectIndicator(indicator)"
                                        :class="[
                                            'w-full text-left p-2 rounded border text-sm transition-colors',
                                            selectedIndicator === indicator 
                                                ? 'border-green-300 bg-green-25 text-green-600' 
                                                : 'border-gray-100 hover:border-gray-200'
                                        ]"
                                    >
                                        <div class="flex items-center justify-between">
                                            <div class="flex items-center space-x-2">
                                                <span class="text-green-600">📊</span>
                                                <span>{{ indicator.name || `Indicator ${indicatorIndex + 1}` }}</span>
                                                <span v-if="expandedIndicator === indicator" class="text-xs text-gray-400">▼</span>
                                                <span v-else class="text-xs text-gray-400">▶</span>
                                            </div>
                                            <el-button
                                                v-if="group.indicators.length > 1"
                                                type="danger"
                                                plain
                                                size="small"
                                                @click.stop="removeIndicator(groupIndex, indicatorIndex)"
                                                :disabled="process"
                                            >
                                                ×
                                            </el-button>
                                        </div>
                                    </button>

                                    <!-- Sessions for this specific indicator -->
                                    <div v-if="expandedIndicator === indicator && indicator.sessions" class="ml-4 space-y-1">
                                        <button 
                                            v-for="(session, sessionIndex) in indicator.sessions" 
                                            :key="sessionIndex"
                                            @click="selectSession(session)"
                                            :class="[
                                                'w-full text-left p-2 rounded border text-sm transition-colors',
                                                selectedSession === session 
                                                    ? 'border-orange-300 bg-orange-25 text-orange-600' 
                                                    : 'border-gray-100 hover:border-gray-200'
                                            ]"
                                        >
                                            <div class="flex items-center justify-between">
                                                <div class="flex items-center space-x-2">
                                                    <span class="text-orange-600">🎯</span>
                                                    <span>{{ session.name || `Session ${sessionIndex + 1}` }}</span>
                                                </div>
                                                <el-button
                                                    v-if="indicator.sessions && indicator.sessions.length > 1"
                                                    type="danger"
                                                    plain
                                                    size="small"
                                                    @click.stop="removeSession(groupIndex, indicatorIndex, sessionIndex)"
                                                    :disabled="process"
                                                >
                                                    ×
                                                </el-button>
                                            </div>
                                        </button>
                                        
                                        <el-button
                                            type="primary"
                                            plain
                                            size="small"
                                            class="w-full"
                                            @click="addSession()"
                                            :disabled="process"
                                        >
                                            + Session
                                        </el-button>
                                    </div>
                                </div>
                                
                                <el-button
                                    type="primary"
                                    plain
                                    size="small"
                                    class="w-full mt-2"
                                    @click="addIndicator()"
                                    :disabled="process"
                                >
                                    + Indicator
                                </el-button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Main Content Area -->
        <div class="flex-1 flex flex-col">
            <!-- Content Header -->
            <div class="bg-white border-b border-gray-200 p-4">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-xl font-semibold text-gray-900">
                            {{ 
                                currentView === 'assessment' ? 'Assessment Information' :
                                currentView === 'group' ? `Group: ${selectedGroup?.name || 'New Group'}` :
                                currentView === 'indicator' ? `Indicator: ${selectedIndicator?.name || 'New Indicator'}` :
                                currentView === 'session' ? `Session: ${selectedSession?.name || 'New Session'}` :
                                'Assessment'
                            }}
                        </h2>
                        <p class="text-sm text-gray-600 mt-1">
                            {{ 
                                currentView === 'assessment' ? 'Configure basic assessment information' :
                                currentView === 'group' ? 'Configure group indicator details' :
                                currentView === 'indicator' ? 'Configure indicator details' :
                                currentView === 'session' ? 'Configure session details and rubrics' :
                                ''
                            }}
                        </p>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="flex items-center space-x-3">
                        <el-button @click="emit('close')" :disabled="process">Cancel</el-button>
                        <el-button 
                            v-if="propertyModal.mode === 'edit'" 
                            type="danger" 
                            @click="handleRemove"
                            :disabled="process"
                        >
                            Delete
                        </el-button>
                        <el-button 
                            type="primary" 
                            @click="handleSubmit"
                            :loading="process"
                        >
                            {{ propertyModal.mode === 'create' ? 'Create' : 'Update' }}
                        </el-button>
                    </div>
                </div>
            </div>

            <!-- Content Form -->
            <div class="flex-1 overflow-y-auto p-4">
                <div class="max-w-4xl">
                    <el-form 
                        ref="formRef"
                        :model="assessment"
                        :rules="rules"
                        label-position="top"
                        :disabled="process"
                        class="space-y-4"
                    >
                        <!-- Assessment Information -->
                        <div v-if="currentView === 'assessment'" class="space-y-4">
                            <el-form-item label="Assessment Title" prop="title" required>
                                <el-input
                                    v-model="assessment.title"
                                    placeholder="Enter assessment title"
                                    maxlength="255"
                                    show-word-limit
                                />
                            </el-form-item>

                            <el-form-item label="Description">
                                <el-input
                                    v-model="assessment.description"
                                    type="textarea"
                                    :rows="3"
                                    placeholder="Enter assessment description"
                                />
                            </el-form-item>

                            <div class="grid grid-cols-2 gap-4">
                                <el-form-item label="Calculation Method" prop="calculation_method" required>
                                    <el-select v-model="assessment.calculation_method" placeholder="Select method" class="w-full">
                                        <el-option label="Average (Rata-rata)" value="AVERAGE" />
                                        <el-option label="Sum (Penjumlahan)" value="SUM" />
                                    </el-select>
                                </el-form-item>

                                <el-form-item label="Passing Score" prop="passing_score" required>
                                    <el-input-number
                                        v-model="assessment.passing_score"
                                        :min="0"
                                        :max="100"
                                        :precision="0"
                                        class="w-full"
                                    />
                                </el-form-item>
                            </div>
                        </div>

                        <!-- Group Form -->
                        <div v-else-if="currentView === 'group' && selectedGroup" class="space-y-4">
                            <div class="grid grid-cols-2 gap-4">
                                <el-form-item label="Group Name" required>
                                    <el-input v-model="selectedGroup.name" placeholder="Enter group name" maxlength="255" show-word-limit />
                                </el-form-item>
                                <el-form-item label="Order" required>
                                    <el-input-number v-model="selectedGroup.order" :min="1" :precision="0" class="w-full" />
                                </el-form-item>
                            </div>
                            <el-form-item label="Description">
                                <el-input v-model="selectedGroup.description" type="textarea" :rows="3" placeholder="Enter group description" />
                            </el-form-item>
                        </div>

                        <!-- Indicator Form -->
                        <div v-else-if="currentView === 'indicator' && selectedIndicator" class="space-y-4">
                            <div class="grid grid-cols-2 gap-4">
                                <el-form-item label="Indicator Name" required>
                                    <el-input v-model="selectedIndicator.name" placeholder="Enter indicator name" maxlength="255" show-word-limit />
                                </el-form-item>
                                <el-form-item label="Order" required>
                                    <el-input-number v-model="selectedIndicator.order" :min="1" :precision="0" class="w-full" />
                                </el-form-item>
                            </div>
                            <el-form-item label="Description">
                                <el-input v-model="selectedIndicator.description" type="textarea" :rows="3" placeholder="Enter indicator description" />
                            </el-form-item>
                        </div>

                        <!-- Session Form with Rubrics -->
                        <div v-else-if="currentView === 'session' && selectedSession" class="space-y-6">
                            <!-- Session Info -->
                            <div class="space-y-4">
                                <div class="grid grid-cols-2 gap-4">
                                    <el-form-item label="Session Name" required>
                                        <el-input v-model="selectedSession.name" placeholder="Enter session name" maxlength="255" show-word-limit />
                                    </el-form-item>
                                    <el-form-item label="Order" required>
                                        <el-input-number v-model="selectedSession.order" :min="1" :precision="0" class="w-full" />
                                    </el-form-item>
                                </div>
                                <el-form-item label="Description">
                                    <el-input v-model="selectedSession.description" type="textarea" :rows="3" placeholder="Enter session description" />
                                </el-form-item>
                            </div>

                            <!-- Rubrics Section -->
                            <div class="border-t pt-6">
                                <div class="flex items-center justify-between mb-4">
                                    <h4 class="text-lg font-medium">Rubrics</h4>
                                    <div class="space-x-2">
                                        <el-button type="primary" plain @click="showRubricLibrary = true" :disabled="process">
                                            📚 Use Template
                                        </el-button>
                                        <el-button type="primary" @click="addRubric" :disabled="process">
                                            + Add Rubric
                                        </el-button>
                                    </div>
                                </div>

                                <div v-if="!selectedSession.rubrics || selectedSession.rubrics.length === 0" class="text-center py-8 text-gray-500">
                                    <div class="text-4xl mb-2">📝</div>
                                    <p>No rubrics added yet</p>
                                    <p class="text-sm">Add rubrics manually or use a template</p>
                                </div>

                                <div v-else-if="selectedSession.rubrics && selectedSession.rubrics.length > 0" class="space-y-3">
                                    <div 
                                        v-for="(rubric, rubricIndex) in selectedSession.rubrics" 
                                        :key="rubricIndex" 
                                        class="p-4 bg-white border rounded-lg"
                                    >
                                        <div class="flex items-center justify-between mb-3">
                                            <h6 class="font-medium">Rubric {{ rubricIndex + 1 }}</h6>
                                            <el-button type="danger" plain size="small" @click="removeRubric(rubricIndex)" :disabled="process">
                                                Remove
                                            </el-button>
                                        </div>

                                        <div class="grid grid-cols-4 gap-4">
                                            <el-form-item label="Level" required>
                                                <el-input v-model="rubric.level" placeholder="e.g., Excellent" maxlength="255" />
                                            </el-form-item>
                                            <el-form-item label="Score" required>
                                                <el-input-number v-model="rubric.score" :min="0" :max="100" :precision="0" class="w-full" />
                                            </el-form-item>
                                            <el-form-item label="Description" class="col-span-2">
                                                <el-input v-model="rubric.description" placeholder="Describe this performance level" />
                                            </el-form-item>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- No Selection State -->
                        <div v-else class="text-center py-16">
                            <div class="text-6xl mb-4">📋</div>
                            <h3 class="text-lg font-medium text-gray-900 mb-2">Select an Item to Edit</h3>
                            <p class="text-gray-600">Choose an assessment, group, indicator, or session from the sidebar to start editing.</p>
                        </div>
                    </el-form>
                </div>
            </div>
        </div>

        <!-- Rubric Library Modal -->
        <el-dialog
            v-model="showRubricLibrary"
            title="Rubric Library"
            width="50%"
            :close-on-click-modal="false"
        >
            <div class="space-y-4">
                <div 
                    v-for="template in rubricLibrary" 
                    :key="template.id"
                    class="p-4 border rounded-lg hover:border-blue-300 cursor-pointer transition-colors"
                    @click="useRubricTemplate(template)"
                >
                    <div class="flex items-center justify-between mb-2">
                        <h4 class="font-medium">{{ template.name }}</h4>
                        <Badge type="info">{{ template.rubrics.length }} levels</Badge>
                    </div>
                    <p class="text-sm text-gray-600 mb-3">{{ template.description }}</p>
                    
                    <div class="grid grid-cols-2 gap-2">
                        <div 
                            v-for="rubric in template.rubrics" 
                            :key="rubric.level"
                            class="text-xs p-2 bg-gray-50 rounded"
                        >
                            <div class="font-medium">{{ rubric.level }} ({{ rubric.score }})</div>
                            <div class="text-gray-600">{{ rubric.description }}</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <template #footer>
                <el-button @click="showRubricLibrary = false">Cancel</el-button>
            </template>
        </el-dialog>
    </div>
</template> 