<script setup>
import DefaultButton from './DefaultButton.vue';
import axios from 'axios';
import fieldValidation from '@/Helpers/fieldValidation';
import { ElNotification, timeSelectProps } from 'element-plus';
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
                type: null,
                major: null,
                minor: null,
                description: null,
            },
            fileList: [],
            field: {
                type: {
                    label: "Bidang",
                    rules: [fieldValidation.isRequired("Bidang")],
                    error: null,
                },
                major: {
                    label: "Keahlian Utama",
                    rules: [fieldValidation.isRequired("Keahlian Utama")],
                    error: null,
                },
                minor: {
                    label: "Keahlian Pendukung",
                    rules: [fieldValidation.isRequired("Keahlian Pendukung")],
                    error: null,
                },
                description: {
                    label: "Deskripsi",
                    rules: [],
                    error: null,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-specialization') {
            this.form.id = this.propertyModal.data.specialization.id;
            this.form.profile_id = this.propertyModal.data.specialization.profile_id;
            this.form.type = this.propertyModal.data.specialization.type;
            this.form.major = this.propertyModal.data.specialization.major;
            this.form.minor = this.propertyModal.data.specialization.minor;
            this.form.description = this.propertyModal.data.specialization.description;
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
                .delete(route('office.myProfile.qualification.specialization.delete', {
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
            this.$refs["specializationForm"].validate((valid) => {
                if (valid) {
                    // todo: ref request body filter
                    this.loading = true;

                    const formData = new FormData();
                    formData.append("id", this.form.id);
                    formData.append("profile_id", this.form.profile_id);
                    formData.append("type", this.form.type);
                    formData.append("major", this.form.major);
                    formData.append("minor", this.form.minor);
                    formData.append("description", this.form.description);
                    axios
                        .post(route('office.myProfile.qualification.specialization.save'), formData, {
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
                                    this.$inertia.reload();
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
            ref="specializationForm"
            label-position="top"
            :model="form"
            :disabled="process"
            >
                <el-row :gutter="12">
                    <el-col :span="24">
                        <el-form-item
                        :label="field.type.label"
                        :rules="field.type.rules"
                        :error="field.type.error"
                        prop="type"
                        >
                            <el-input v-model="form.type" :placeholder="field.type.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.major.label"
                        :rules="field.major.rules"
                        :error="field.major.error"
                        prop="major"
                        >
                            <el-input v-model="form.major" :placeholder="field.major.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.minor.label"
                        :rules="field.minor.rules"
                        :error="field.minor.error"
                        prop="minor"
                        >
                            <el-input v-model="form.minor" :placeholder="field.minor.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.description.label"
                        :rules="field.description.rules"
                        :error="field.description.error"
                        prop="description"
                        >
                            <el-input v-model="form.description" :placeholder="field.description.label" type="textarea" autosize></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex gap-2 items-center border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-specialization'"
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