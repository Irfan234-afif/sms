<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import { admissionStagePostStatuses, admissionStagePreStatuses } from '@/Helpers/options';
</script>
<script>
export default {
    props: {
        propertyModal: {
            type: Object,
            default: null,
        },
    },
    data() {
        return {
            process: false,
            loaded: true,
            isValid: false,
            editorData: null,
            form: {
                admission_student_stage: this.propertyModal.data.admission_student_stage.uuid,
                scheduled_at: null,
                description: null,
                status: null,
            },
            field: {
                scheduled_at: {
                    label: 'Jadwal',
                    rules: [fieldValidation.isRequired('Jadwal')],
                    error: null,
                    disabled: true,
                },
                description: {
                    label: 'Keterangan',
                    rules: [fieldValidation.isRequired('Keterangan')],
                    error: null,
                },
                status: {
                    label: 'Pilih Status',
                    rules: [fieldValidation.isRequired('Pilih Status')],
                    error: null,
                    disabled: false,
                    options: [],
                },
            },
        };
    },
    created() {
        if (this.propertyModal.data.admission_student_stage) {
            let admission_student_stage = this.propertyModal.data.admission_student_stage;

            this.form.admission_student_stage = admission_student_stage.uuid;
            this.form.scheduled_at = admission_student_stage.scheduled_at;
            this.form.description = admission_student_stage.description;
            this.form.status = admission_student_stage.status;

            if (admission_student_stage.type == 'PRE') {
                this.field.status.options = admissionStagePreStatuses;
            }
            if (admission_student_stage.type == 'POST') {
                this.field.status.options = admissionStagePostStatuses;
            }
        }
    },
    methods: {
        submit() {
            this.$refs['stageForm'].validate((valid) => {
                if (valid) {
                    this.process = true;
                    let requestPayload = JSON.parse(JSON.stringify(this.form));

                    axios
                        .post(route('school.activity.admissionStudent.updateStage'), requestPayload, {
                            headers: { 'Content-Type': 'application/json' },
                        })
                        .then((response) => {
                            if (response.data.status === 'success') {
                                ElNotification({
                                    title: 'Berhasil',
                                    message: response.data.message,
                                    type: 'success',
                                });

                                setTimeout(() => {
                                    this.close();
                                    this.$inertia.reload();
                                }, 2000);
                            } else if (response.data.status === 'error') {
                                ElNotification({
                                    title: 'Error',
                                    message: response.data.message,
                                    type: 'error',
                                });
                            }
                        })
                        .catch((error) => {
                            ElNotification({
                                title: 'Error',
                                message: 'Terjadi kesalahan.',
                                type: 'error',
                            });

                            if (error.response?.data?.errors) {
                                for (let field in error.response.data.errors) {
                                    this.field[field].error = error.response.data.errors[field];
                                    this.$refs['stageForm'].validateField(field);
                                }
                            }
                        })
                        .finally(() => {
                            this.process = false;
                        });
                }
            });
        },
        close() {
            this.$emit('close');
        },
    },
};
</script>
<template>
    <div class="space-y-6 p-5">
        <h2 class="border-b pb-4 text-lg font-bold text-gray-900">
            {{ propertyModal?.title }}
        </h2>
        <div class="px-2">
            <el-form v-if="loaded" ref="stageForm" label-position="top" :model="form" :disabled="process">
                <el-form-item
                    class="font-bold"
                    :label="field.scheduled_at.label"
                    :rules="field.scheduled_at.rules"
                    :error="field.scheduled_at.error"
                    prop="scheduled_at"
                >
                    <el-date-picker
                        v-model="form.scheduled_at"
                        type="datetime"
                        :disabled="field.scheduled_at.disabled"
                        format="DD-MM-YYYY HH:mm"
                        value-format="YYYY-MM-DD HH:mm:ss"
                    />
                </el-form-item>
                <el-form-item
                    class="font-bold"
                    :label="field.status.label"
                    :rules="field.status.rules"
                    :error="field.status.error"
                    prop="status"
                >
                    <el-select
                        v-model="form.status"
                        :placeholder="`Pilih ${field.status.label}`"
                        loading-text="..."
                        no-match-text="Data tidak ditemukan"
                        no-data-text="Tidak ada data"
                        :disabled="field.status.disabled"
                        autocomplete="off"
                    >
                        <el-option
                            v-for="option in field.status.options"
                            :disabled="option.value == 'PENDING'"
                            :key="option.value"
                            :label="option.label"
                            :value="option.value"
                        />
                    </el-select>
                </el-form-item>
                <el-form-item
                    class="font-bold"
                    :label="field.description.label"
                    :rules="field.description.rules"
                    :error="field.description.error"
                    prop="description"
                >
                    <el-input type="textarea" v-model="form.description" rows="8" autocomplete="off" />
                </el-form-item>
            </el-form>
        </div>
        <div class="flex justify-end space-x-3">
            <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>

            <DefaultButton type="default" @click="submit" :disabled="process"> Perbarui Status </DefaultButton>
        </div>
    </div>
</template>
