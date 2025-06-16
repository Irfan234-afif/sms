<script setup>
import { ref, watch } from 'vue';
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

const assessment = ref({
    title: '',
    description: '',
    group_indicators: []
});

// Validation rules
const rules = {
    title: [
        { required: true, message: 'Assessment title is required', trigger: 'blur' },
        { max: 255, message: 'Assessment title must not exceed 255 characters', trigger: 'blur' }
    ]
};

// Watch for changes in propertyModal.data
watch(() => props.propertyModal.data, (newData) => {
    console.log(newData);
    if (newData) {
        const group_indicators = newData.group_indicators || [];
        assessment.value = {
            ...newData,
            group_indicators: group_indicators.map((group, groupIndex) => {
                const indicators = group.indicators || [];
                return {
                    ...group,
                    order: group.order || groupIndex + 1,
                    indicators: indicators.map((indicator, indicatorIndex) => {
                        const sessions = indicator.sessions || [];
                        return {
                            ...indicator,
                            order: indicator.order || indicatorIndex + 1,
                            sessions: sessions.map((session, sessionIndex) => ({
                                ...session,
                                order: session.order || sessionIndex + 1,
                                rubrics: session.rubrics || []
                            }))
                        };
                    })
                };
            })
        };
    }
}, { immediate: true });

const addGroupIndicator = () => {
    const maxOrder = assessment.value.group_indicators.reduce((max, group) => 
        Math.max(max, group.order || 0), 0);
    
    assessment.value.group_indicators.push({
        name: '',
        description: '',
        order: maxOrder + 1,
        indicators: []
    });
};

const removeGroupIndicator = (index) => {
    assessment.value.group_indicators.splice(index, 1);
    // Reorder remaining group indicators
    assessment.value.group_indicators.forEach((group, idx) => {
        group.order = idx + 1;
    });
};

const addIndicator = (groupIndex) => {
    const group = assessment.value.group_indicators[groupIndex];
    const maxOrder = group.indicators.reduce((max, indicator) => 
        Math.max(max, indicator.order || 0), 0);
    
    group.indicators.push({
        name: '',
        description: '',
        order: maxOrder + 1,
        sessions: []
    });
};

const removeIndicator = (groupIndex, indicatorIndex) => {
    const group = assessment.value.group_indicators[groupIndex];
    group.indicators.splice(indicatorIndex, 1);
    // Reorder remaining indicators
    group.indicators.forEach((indicator, idx) => {
        indicator.order = idx + 1;
    });
};

const addSession = (groupIndex, indicatorIndex) => {
    const indicator = assessment.value.group_indicators[groupIndex].indicators[indicatorIndex];
    const maxOrder = indicator.sessions.reduce((max, session) => 
        Math.max(max, session.order || 0), 0);
    
    indicator.sessions.push({
        name: '',
        description: '',
        order: maxOrder + 1,
        rubrics: []
    });
};

const removeSession = (groupIndex, indicatorIndex, sessionIndex) => {
    const indicator = assessment.value.group_indicators[groupIndex].indicators[indicatorIndex];
    indicator.sessions.splice(sessionIndex, 1);
    // Reorder remaining sessions
    indicator.sessions.forEach((session, idx) => {
        session.order = idx + 1;
    });
};

const addRubric = (groupIndex, indicatorIndex, sessionIndex) => {
    assessment.value.group_indicators[groupIndex].indicators[indicatorIndex].sessions[sessionIndex].rubrics.push({
        level: '',
        description: '',
        score: 0
    });
};

const removeRubric = (groupIndex, indicatorIndex, sessionIndex, rubricIndex) => {
    assessment.value.group_indicators[groupIndex].indicators[indicatorIndex].sessions[sessionIndex].rubrics.splice(rubricIndex, 1);
};

const handleSubmit = () => {
    formRef.value.validate((valid) => {
        if (valid) {
            process.value = true;
            
            // Additional validation for nested structures
            let hasErrors = false;
            let errorMessage = '';

            // Validate group indicators
            assessment.value.group_indicators.forEach((group, groupIndex) => {
                if (!group.name) {
                    hasErrors = true;
                    errorMessage += `Group ${groupIndex + 1} name is required\n`;
                }
                if (group.name && group.name.length > 255) {
                    hasErrors = true;
                    errorMessage += `Group ${groupIndex + 1} name must not exceed 255 characters\n`;
                }
                if (!group.order || group.order < 1) {
                    hasErrors = true;
                    errorMessage += `Group ${groupIndex + 1} order is required and must be at least 1\n`;
                }

                // Validate indicators
                group.indicators.forEach((indicator, indicatorIndex) => {
                    if (!indicator.name) {
                        hasErrors = true;
                        errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1} name is required\n`;
                    }
                    if (indicator.name && indicator.name.length > 255) {
                        hasErrors = true;
                        errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1} name must not exceed 255 characters\n`;
                    }
                    if (!indicator.order || indicator.order < 1) {
                        hasErrors = true;
                        errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1} order is required and must be at least 1\n`;
                    }

                    // Validate sessions
                    indicator.sessions.forEach((session, sessionIndex) => {
                        if (!session.name) {
                            hasErrors = true;
                            errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1} name is required\n`;
                        }
                        if (session.name && session.name.length > 255) {
                            hasErrors = true;
                            errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1} name must not exceed 255 characters\n`;
                        }
                        if (!session.order || session.order < 1) {
                            hasErrors = true;
                            errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1} order is required and must be at least 1\n`;
                        }

                        // Validate rubrics
                        session.rubrics.forEach((rubric, rubricIndex) => {
                            if (!rubric.level) {
                                hasErrors = true;
                                errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1}, Rubric ${rubricIndex + 1} level is required\n`;
                            }
                            if (rubric.level && rubric.level.length > 255) {
                                hasErrors = true;
                                errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1}, Rubric ${rubricIndex + 1} level must not exceed 255 characters\n`;
                            }
                            if (rubric.score === null || rubric.score === undefined || rubric.score < 0 || rubric.score > 100) {
                                hasErrors = true;
                                errorMessage += `Group ${groupIndex + 1}, Indicator ${indicatorIndex + 1}, Session ${sessionIndex + 1}, Rubric ${rubricIndex + 1} score must be between 0 and 100\n`;
                            }
                        });
                    });
                });
            });

            if (hasErrors) {
                ElNotification({
                    title: 'Validation Error',
                    message: errorMessage.trim(),
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
    <div class="p-6">
        <h3 class="text-lg font-semibold mb-4">Assessment Details</h3>
        
        <el-form 
            ref="formRef"
            :model="assessment"
            :rules="rules"
            label-position="top"
            :disabled="process"
            class="space-y-4"
        >
            <!-- Assessment Details -->
            <div class="space-y-4">
                <el-form-item
                    label="Title"
                    prop="title"
                    required
                >
                    <el-input
                        v-model="assessment.title"
                        type="text"
                        placeholder="Enter assessment title"
                        maxlength="255"
                        show-word-limit
                    />
                </el-form-item>

                <el-form-item
                    label="Description"
                    prop="description"
                >
                    <el-input
                        v-model="assessment.description"
                        type="textarea"
                        :rows="3"
                        placeholder="Enter assessment description"
                    />
                </el-form-item>
            </div>

            <!-- Group Indicators -->
            <div class="mt-6">
                <div class="flex items-center justify-between mb-4">
                    <h4 class="text-lg font-medium">Group Indicators</h4>
                    <el-button
                        type="primary"
                        plain
                        @click="addGroupIndicator"
                        :disabled="process"
                    >
                        Add Group Indicator
                    </el-button>
                </div>

                <div v-for="(group, groupIndex) in assessment.group_indicators" :key="groupIndex" class="mb-6 p-4 border rounded-lg">
                    <div class="flex items-center justify-between mb-4">
                        <h5 class="text-md font-medium">Group {{ groupIndex + 1 }}</h5>
                        <el-button
                            type="danger"
                            @click="removeGroupIndicator(groupIndex)"
                            :disabled="process"
                        >
                            Remove
                        </el-button>
                    </div>

                    <div class="space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <el-form-item
                                label="Name"
                                required
                            >
                                <el-input
                                    v-model="group.name"
                                    type="text"
                                    placeholder="Enter group name"
                                    maxlength="255"
                                    show-word-limit
                                />
                            </el-form-item>
                            <el-form-item
                                label="Order"
                                required
                            >
                                <el-input-number
                                    v-model="group.order"
                                    :min="1"
                                    :precision="0"
                                    class="w-full"
                                />
                            </el-form-item>
                        </div>

                        <el-form-item
                            label="Description"
                        >
                            <el-input
                                v-model="group.description"
                                type="textarea"
                                :rows="2"
                                placeholder="Enter group description"
                            />
                        </el-form-item>

                        <!-- Indicators -->
                        <div class="mt-4">
                            <div class="flex items-center justify-between mb-2">
                                <h6 class="text-sm font-medium">Indicators</h6>
                                <el-button
                                    type="primary"
                                    plain
                                    @click="addIndicator(groupIndex)"
                                    :disabled="process"
                                >
                                    Add Indicator
                                </el-button>
                            </div>

                            <div v-for="(indicator, indicatorIndex) in group.indicators" :key="indicatorIndex" class="mb-4 p-3 bg-gray-50 rounded">
                                <div class="flex items-center justify-between mb-2">
                                    <h6 class="text-sm font-medium">Indicator {{ indicatorIndex + 1 }}</h6>
                                    <el-button
                                        type="danger"
                                        @click="removeIndicator(groupIndex, indicatorIndex)"
                                        :disabled="process"
                                    >
                                        Remove
                                    </el-button>
                                </div>

                                <div class="space-y-3">
                                    <div class="grid grid-cols-2 gap-4">
                                        <el-form-item
                                            label="Name"
                                            required
                                        >
                                            <el-input
                                                v-model="indicator.name"
                                                type="text"
                                                placeholder="Enter indicator name"
                                                maxlength="255"
                                                show-word-limit
                                            />
                                        </el-form-item>
                                        <el-form-item
                                            label="Order"
                                            required
                                        >
                                            <el-input-number
                                                v-model="indicator.order"
                                                :min="1"
                                                :precision="0"
                                                class="w-full"
                                            />
                                        </el-form-item>
                                    </div>

                                    <el-form-item
                                        label="Description"
                                    >
                                        <el-input
                                            v-model="indicator.description"
                                            type="textarea"
                                            :rows="2"
                                            placeholder="Enter indicator description"
                                        />
                                    </el-form-item>

                                    <!-- Sessions -->
                                    <div class="mt-3">
                                        <div class="flex items-center justify-between mb-2">
                                            <h6 class="text-sm font-medium">Sessions</h6>
                                            <el-button
                                                type="primary"
                                                plain
                                                @click="addSession(groupIndex, indicatorIndex)"
                                                :disabled="process"
                                            >
                                                Add Session
                                            </el-button>
                                        </div>

                                        <div v-for="(session, sessionIndex) in indicator.sessions" :key="sessionIndex" class="mb-3 p-2 bg-white rounded border">
                                            <div class="flex items-center justify-between mb-2">
                                                <h6 class="text-sm font-medium">Session {{ sessionIndex + 1 }}</h6>
                                                <el-button
                                                    type="danger"
                                                    @click="removeSession(groupIndex, indicatorIndex, sessionIndex)"
                                                    :disabled="process"
                                                >
                                                    Remove
                                                </el-button>
                                            </div>

                                            <div class="space-y-3">
                                                <div class="grid grid-cols-2 gap-4">
                                                    <el-form-item
                                                        label="Name"
                                                        required
                                                    >
                                                        <el-input
                                                            v-model="session.name"
                                                            type="text"
                                                            placeholder="Enter session name"
                                                            maxlength="255"
                                                            show-word-limit
                                                        />
                                                    </el-form-item>
                                                    <el-form-item
                                                        label="Order"
                                                        required
                                                    >
                                                        <el-input-number
                                                            v-model="session.order"
                                                            :min="1"
                                                            :precision="0"
                                                            class="w-full"
                                                        />
                                                    </el-form-item>
                                                </div>

                                                <el-form-item
                                                    label="Description"
                                                >
                                                    <el-input
                                                        v-model="session.description"
                                                        type="textarea"
                                                        :rows="2"
                                                        placeholder="Enter session description"
                                                    />
                                                </el-form-item>

                                                <!-- Rubrics -->
                                                <div class="mt-2">
                                                    <div class="flex items-center justify-between mb-2">
                                                        <h6 class="text-sm font-medium">Rubrics</h6>
                                                        <el-button
                                                            type="primary"
                                                            plain
                                                            @click="addRubric(groupIndex, indicatorIndex, sessionIndex)"
                                                            :disabled="process"
                                                        >
                                                            Add Rubric
                                                        </el-button>
                                                    </div>

                                                    <div v-for="(rubric, rubricIndex) in session.rubrics" :key="rubricIndex" class="mb-2 p-2 bg-gray-50 rounded">
                                                        <div class="flex items-center justify-between mb-2">
                                                            <h6 class="text-sm font-medium">Rubric {{ rubricIndex + 1 }}</h6>
                                                            <el-button
                                                                type="danger"
                                                                @click="removeRubric(groupIndex, indicatorIndex, sessionIndex, rubricIndex)"
                                                                :disabled="process"
                                                            >
                                                                Remove
                                                            </el-button>
                                                        </div>

                                                        <div class="grid grid-cols-3 gap-3">
                                                            <el-form-item
                                                                label="Level"
                                                                required
                                                            >
                                                                <el-input
                                                                    v-model="rubric.level"
                                                                    type="text"
                                                                    placeholder="Enter level"
                                                                    maxlength="255"
                                                                    show-word-limit
                                                                />
                                                            </el-form-item>

                                                            <el-form-item
                                                                label="Description"
                                                                class="col-span-2"
                                                            >
                                                                <el-input
                                                                    v-model="rubric.description"
                                                                    type="textarea"
                                                                    :rows="2"
                                                                    placeholder="Enter rubric description"
                                                                />
                                                            </el-form-item>

                                                            <el-form-item
                                                                label="Score"
                                                                required
                                                            >
                                                                <el-input-number
                                                                    v-model="rubric.score"
                                                                    :min="0"
                                                                    :max="100"
                                                                    :precision="0"
                                                                    class="w-full"
                                                                />
                                                            </el-form-item>
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

            <!-- Action Buttons -->
            <div class="mt-6 flex justify-end space-x-3">
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
        </el-form>
    </div>
</template> 