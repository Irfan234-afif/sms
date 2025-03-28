<script setup>
import DefaultButton from './DefaultButton.vue';
import axios from 'axios';
import fieldValidation from '@/Helpers/fieldValidation';
import { ElNotification } from 'element-plus';
import { UploadFilled } from '@element-plus/icons-vue'
import OutlineButton from './OutlineButton.vue';
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
            url: new URL(document.URL),
            process: false,
            loaded: true,
            isValid: false,
            form: {
                id: null,
                profile_id: null,
                position: null,
                reason_out: null,
                institution: null,
                start_date: null,
                end_date: null,
            },
            fileList: [],
            field: {
                position: {
                    label: "Position",
                    rules: [fieldValidation.isRequired("Position")],
                    error: null,
                },
                reason_out: {
                    label: "Alasan Keluar",
                    rules: [fieldValidation.isRequired("Alasan Keluar")],
                    error: null,
                },
                institution: {
                    label: "Perusahaan",
                    rules: [fieldValidation.isRequired("Perusahaan")],
                    error: null,
                },
                start_date: {
                    label: "Tanggal Mulai",
                    rules: [fieldValidation.isRequired("Tanggal Mulai")],
                    error: null,
                },
                end_date: {
                    label: "Tanggal Akhir",
                    rules: [fieldValidation.isRequired("Tanggal Akhir")],
                    error: null,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-experience') {
            this.form.id = this.propertyModal.data.experience.id;
            this.form.profile_id = this.propertyModal.data.experience.profile_id;
            this.form.position = this.propertyModal.data.experience.position;
            this.form.reason_out = this.propertyModal.data.experience.reason_out;
            this.form.institution = this.propertyModal.data.experience.institution;
            this.form.start_date = this.propertyModal.data.experience.start_date;
            this.form.end_date = this.propertyModal.data.experience.end_date;
        }else {
            this.form.profile_id = this.propertyModal.data.profile_id;
            console.log(this.form.profile_id);
        }
    },
    methods: {
        handleChange(file, fileList) {
            if (fileList.length > 0) {
                this.fileList = fileList;
            } else {
                this.fileList = [];
            }
        },
        handleRemove(file, fileList) {
            if (fileList.length > 0) {
                this.fileList = fileList;
            } else {
                this.fileList = [];
            }
        },
        async deleteData(){
            this.loading = true;
            axios
                .delete(route('office.myProfile.qualification.experience.delete', {
                id: this.form.id,
            }))
                .then((response) => {
                    this.loading = false;
                    if (response.data.status === "success") {
                        ElNotification({
                            title: 'Berhasil',
                            message: response.data.message,
                            type: 'success',
                        });
                        setTimeout(() => {
                            window.location.reload();
                        }, 1500);
                    } else {
                        ElNotification({
                            title: 'Error',
                            message: response.data.message,
                            type: 'error',
                        });
                    }
                })
                .catch((error) => {
                    this.loading = false;
                    if (error.response.status) {
                        ElNotification({
                            title: 'Error',
                            message: response.data.message,
                            type: 'error',
                        });
                    }
                });
        },
        async submit() {
            this.$refs["experienceForm"].validate((valid) => {
                if (valid) {
                    // todo: ref request body filter
                    this.loading = true;

                    const formData = new FormData();
                    formData.append("id", this.form.id);
                    formData.append("profile_id", this.form.profile_id);
                    formData.append("position", this.form.position);
                    formData.append("reason_out", this.form.reason_out);
                    formData.append("institution", this.form.institution);
                    formData.append("start_date", this.form.start_date);
                    formData.append("end_date", this.form.end_date);
                    axios
                        .post(route('office.myProfile.qualification.experience.save'), formData, {
                            headers: {
                                "Content-Type": "multipart/form-data",
                            },
                        })
                        .then((response) => {
                            this.loading = false;
                            if (response.data.status === "success") {
                                ElNotification({
                                    title: 'Berhasil',
                                    message: response.data.message,
                                    type: 'success',
                                });
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            } else {
                                ElNotification({
                                    title: 'Error',
                                    message: response.data.message,
                                    type: 'error',
                                });
                            }
                        })
                        .catch((error) => {
                            this.loading = false;
                            if (error.response.status) {
                                ElNotification({
                                    title: 'Error',
                                    message: response.data.message,
                                    type: 'error',
                                });
                            }
                        });
                }
            });
        },
    },
}
</script>

<template>
    <div class="space-y-6 p-5">
        <h2 class="border-b pb-4 text-base font-medium text-gray-900">
            {{ propertyModal?.title }}
        </h2>
        <div class="px-2">
            <el-form
            v-if="loaded"
            ref="experienceForm"
            label-position="top"
            :model="form"
            :disabled="process"
            >
                <el-row :gutter="12">
                    <el-col :span="24">
                        <el-form-item
                        :label="field.position.label"
                        :rules="field.position.rules"
                        :error="field.position.error"
                        prop="position"
                        >
                            <el-input v-model="form.position" :placeholder="field.position.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.institution.label"
                        :rules="field.institution.rules"
                        :error="field.institution.error"
                        prop="institution"
                        >
                            <el-input v-model="form.institution" :placeholder="field.institution.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.start_date.label"
                        :rules="field.start_date.rules"
                        :error="field.start_date.error"
                        prop="start_date"
                        >
                            <el-date-picker
                                v-model="form.start_date"
                                :placeholder="field.start_date.label"
                                type="date"
                                format="DD-MM-YYYY"
                                value-format="YYYY-MM-DD"
                            >
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.end_date.label"
                        :rules="field.end_date.rules"
                        :error="field.end_date.error"
                        prop="end_date"
                        >
                            <el-date-picker
                                v-model="form.end_date"
                                :placeholder="field.end_date.label"
                                type="date"
                                format="DD-MM-YYYY"
                                value-format="YYYY-MM-DD"
                            >
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.reason_out.label"
                        :rules="field.reason_out.rules"
                        :error="field.reason_out.error"
                        prop="reason_out"
                        >
                            <el-input v-model="form.reason_out" :placeholder="field.reason_out.label" type="textarea" autosize></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex items-center gap-2 border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-experience'"
                type="red"
                @click="deleteData()"
                >
                <div class="flex items-center space-x-1">
                    <svg
                    xmlns="http://www.w3.org/2000/svg"
                    viewBox="0 0 24 24"
                    fill="none"
                    stroke="currentColor"
                    stroke-width="1.5"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    class="h-4"
                    >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path d="M4 7l16 0" />
                    <path d="M10 11l0 6" />
                    <path d="M14 11l0 6" />
                    <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" />
                    <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" />
                    </svg>
                    <div>Hapus</div>
                </div>
            </OutlineButton>
        </div>
    </div>
</template>