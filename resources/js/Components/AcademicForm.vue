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
                title: null,
                institution: null,
                graduation_date: null,
                attachment: null,
            },
            fileList: [],
            field: {
                title: {
                    label: "Tingkat Pendidikan",
                    rules: [fieldValidation.isRequired("Tingkat Pendidikan")],
                    error: null,
                },
                institution: {
                    label: "Institusi",
                    rules: [fieldValidation.isRequired("Institusi")],
                    error: null,
                },
                graduation_date: {
                    label: "Tanggal Lulus",
                    rules: [fieldValidation.isRequired("Tanggal Lulus")],
                    error: null,
                },
                attachment: {
                    label: 'Berkas',
                    rules: [],
                    error: null,
                    disabled: false,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-academic') {
            this.form.id = this.propertyModal.data.academic.id;
            this.form.profile_id = this.propertyModal.data.academic.profile_id;
            this.form.title = this.propertyModal.data.academic.title;
            this.form.institution = this.propertyModal.data.academic.institution;
            this.form.graduation_date = this.propertyModal.data.academic.graduation_date;
            if (this.propertyModal.data.academic.attachment != null) {
                this.fileList = [
                    {
                        url: `${this.url.origin}/storage/attachment/${this.propertyModal.data.academic.attachment}`,
                    },
                ];
            }
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
                .delete(route('office.myProfile.qualification.academic.delete', {
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
            this.$refs["academicForm"].validate((valid) => {
                if (valid) {
                    // todo: ref request body filter
                    this.loading = true;

                    const formData = new FormData();
                    formData.append("id", this.form.id);
                    formData.append("profile_id", this.form.profile_id);
                    formData.append("title", this.form.title);
                    formData.append("institution", this.form.institution);
                    formData.append("graduation_date", this.form.graduation_date);
                    formData.append(
                        "attachment",
                        this.fileList.length > 0 ? this.fileList[0].raw : null
                    );
                    axios
                        .post(route('office.myProfile.qualification.academic.save'), formData, {
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
            ref="academicForm"
            label-position="top"
            :model="form"
            :disabled="process"
            >
                <el-row :gutter="12">
                    <el-col :span="24">
                        <el-form-item
                        :label="field.title.label"
                        :rules="field.title.rules"
                        :error="field.title.error"
                        prop="title"
                        >
                            <el-input v-model="form.title" :placeholder="field.title.label"></el-input>
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
                        :label="field.graduation_date.label"
                        :rules="field.graduation_date.rules"
                        :error="field.graduation_date.error"
                        prop="graduation_date"
                        >
                            <el-date-picker
                                v-model="form.graduation_date"
                                :placeholder="field.graduation_date.label"
                                type="date"
                                format="DD-MM-YYYY"
                                value-format="YYYY-MM-DD"
                            >
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item 
                            :label="field.attachment.label"
                            :rules="field.attachment.rules"
                            :error="field.attachment.error"
                        >
                            <el-upload
                                ref="uploadFile"
                                list-type="picture"
                                accept=" .jpg, .jpeg, .png, .pdf"
                                action=""
                                :auto-upload="false"
                                :limit="1"
                                :file-list="fileList"
                                :on-change="handleChange"
                                :on-remove="handleRemove"
                                class="w-full"
                                drag
                            >
                                <el-icon class="el-icon--upload"><upload-filled /></el-icon>
                                <div class="el-upload__text">
                                    Drop file here or <em>click to upload</em>
                                </div>
                                <template #tip>
                                    <div class="el-upload__tip">
                                        JPG, PNG, or PDF files with max size 2MB
                                    </div>
                                </template>
                            </el-upload>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex gap-2 items-center border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-academic'"
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