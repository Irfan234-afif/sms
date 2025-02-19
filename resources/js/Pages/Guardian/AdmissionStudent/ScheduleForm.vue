<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
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
            form: {
                admission_student_stage: this.propertyModal.data.admission_student_stage,
                scheduled_at: null,
            },
            field: {
                scheduled_at: {
                    label: 'Pilih Jadwal',
                    rules: [fieldValidation.isRequired('Pilih Jadwal')],
                    error: null,
                },
            },
        };
    },
    methods: {
        submit() {
            this.$refs['scheduleForm'].validate((valid) => {
                if (valid) {
                    this.process = true;
                    let requestPayload = JSON.parse(JSON.stringify(this.form));

                    axios
                        .post(route('guardian.admissionStudent.setSchedule'), requestPayload, {
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
                                    this.$refs['scheduleForm'].validateField(field);
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
            <el-form v-if="loaded" ref="scheduleForm" label-position="top" :model="form" :disabled="process">
                <el-form-item
                    class="font-bold"
                    :label="field.scheduled_at.label"
                    :rules="field.scheduled_at.rules"
                    :error="field.scheduled_at.error"
                    prop="scheduled_at"
                >
                    <el-date-picker
                        style="width: 100%"
                        v-model="form.scheduled_at"
                        type="datetime"
                        format="DD-MM-YYYY HH:mm"
                        value-format="YYYY-MM-DD HH:mm:ss"
                    />
                </el-form-item>
            </el-form>
        </div>
        <div class="flex justify-end space-x-3">
            <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>

            <DefaultButton type="default" @click="submit" :disabled="process"> Atur jadwal </DefaultButton>
        </div>
    </div>
</template>
