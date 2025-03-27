<script setup>
import DefaultButton from './DefaultButton.vue';
import axios from 'axios';
import fieldValidation from '@/Helpers/fieldValidation';
import { ElNotification, timeSelectProps } from 'element-plus';
import { UploadFilled } from '@element-plus/icons-vue'
import OutlineButton from './OutlineButton.vue';
import { languageSkillLevel } from '@/Helpers/options';
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
                reading: null,
                writing: null,
                speaking: null,
            },
            fileList: [],
            field: {
                title: {
                    label: "Bahasa",
                    rules: [fieldValidation.isRequired("Bahasa")],
                    error: null,
                },
                reading: {
                    label: "Membaca",
                    rules: [fieldValidation.isRequired("Membaca")],
                    error: null,
                    options: languageSkillLevel,
                },
                writing: {
                    label: "Menulis",
                    rules: [fieldValidation.isRequired("Menulis")],
                    error: null,
                    options: languageSkillLevel,
                },
                speaking: {
                    label: 'Berbicara',
                    rules: [fieldValidation.isRequired("Berbicara")],
                    error: null,
                    disabled: false,
                    options: languageSkillLevel,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-language-skill') {
            this.form.id = this.propertyModal.data.languageSkill.id;
            this.form.profile_id = this.propertyModal.data.languageSkill.profile_id;
            this.form.title = this.propertyModal.data.languageSkill.title;
            this.form.reading = this.propertyModal.data.languageSkill.reading;
            this.form.writing = this.propertyModal.data.languageSkill.writing;
            this.form.speaking = this.propertyModal.data.languageSkill.speaking;
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
                .delete(route('office.myProfile.qualification.languageSkill.delete', {
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
                    formData.append("reading", this.form.reading);
                    formData.append("writing", this.form.writing);
                    formData.append("speaking", this.form.speaking);
                    axios
                        .post(route('office.myProfile.qualification.languageSkill.save'), formData, {
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
                        :label="field.reading.label"
                        :rules="field.reading.rules"
                        :error="field.reading.error"
                        prop="reading"
                        >
                            <el-select v-model="form.reading" :placeholder="field.reading.label">
                                <el-option v-for="option in field.reading.options" :label="option.label" :value="option.value"/>
                            </el-select>

                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.writing.label"
                        :rules="field.writing.rules"
                        :error="field.writing.error"
                        prop="writing"
                        >
                            <el-select v-model="form.writing" :placeholder="field.writing.label">
                                <el-option v-for="option in field.writing.options" :label="option.label" :value="option.value"/>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item 
                            :label="field.speaking.label"
                            :rules="field.speaking.rules"
                            :error="field.speaking.error"
                        >
                            <el-select v-model="form.speaking" :placeholder="field.speaking.label">
                                <el-option v-for="option in field.speaking.options" :label="option.label" :value="option.value"/>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex gap-2 items-center border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-language-skill'"
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