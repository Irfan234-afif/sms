<script setup>
import DefaultButton from './DefaultButton.vue';
import axios from 'axios';
import fieldValidation from '@/Helpers/fieldValidation';
import { ElNotification, timeSelectProps } from 'element-plus';
import { UploadFilled } from '@element-plus/icons-vue'
import OutlineButton from './OutlineButton.vue';
import { familyRelationTypes } from '@/Helpers/options';
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
                name: null,
                national_id: null,
                relation: null,
                birth_place: null,
                birth_date: null,
                education: null,
                occupation: null,
            },
            fileList: [],
            field: {
                name: {
                    label: "Nama",
                    rules: [fieldValidation.isRequired("Nama")],
                    error: null,
                },
                national_id: {
                    label: "Nomor Identitas Penduduk",
                    rules: [fieldValidation.isRequired("Nomor Identitas Penduduk")],
                    error: null,
                },
                relation: {
                    label: "Hubungan",
                    rules: [fieldValidation.isRequired("Hubungan")],
                    error: null,
                    options: familyRelationTypes,
                },
                birth_place: {
                    label: "Tempat Lahir",
                    rules: [fieldValidation.isRequired("Tempat Lahir")],
                    error: null,
                },
                birth_date: {
                    label: 'Tanggal Lahir',
                    rules: [fieldValidation.isRequired("Tanggal Lahir")],
                    error: null,
                    disabled: false,
                },
                education: {
                    label: 'Pendidikan',
                    rules: [fieldValidation.isRequired("Pendidikan")],
                    error: null,
                    disabled: false,
                },
                occupation: {
                    label: 'Pekerjaan',
                    rules: [fieldValidation.isRequired("Pekerjaan")],
                    error: null,
                    disabled: false,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-family') {
            this.form.id = this.propertyModal.data.family.id;
            this.form.profile_id = this.propertyModal.data.family.profile_id;
            this.form.name = this.propertyModal.data.family.name;
            this.form.relation = this.propertyModal.data.family.relation;
            this.form.national_id = this.propertyModal.data.family.national_id;
            this.form.birth_place = this.propertyModal.data.family.birth_place;
            this.form.birth_date = this.propertyModal.data.family.birth_date;
            this.form.education = this.propertyModal.data.family.education;
            this.form.occupation = this.propertyModal.data.family.occupation;
        }else {
            this.form.profile_id = this.propertyModal.data.profile_id;
            console.log(this.form.profile_id);
        }
    },
    methods: {
        async deleteData(){
            this.loading = true;
            axios
                .delete(route('office.myProfile.qualification.family.delete', {
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
                    formData.append("name", this.form.name);
                    formData.append("relation", this.form.relation);
                    formData.append("national_id", this.form.national_id);
                    formData.append("birth_place", this.form.birth_place);
                    formData.append("birth_date", this.form.birth_date);
                    formData.append("education", this.form.education);
                    formData.append("occupation", this.form.occupation);
                    axios
                        .post(route('office.myProfile.qualification.family.save'), formData, {
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
                        :label="field.name.label"
                        :rules="field.name.rules"
                        :error="field.name.error"
                        prop="name"
                        >
                            <el-input v-model="form.name" :placeholder="field.name.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.national_id.label"
                        :rules="field.national_id.rules"
                        :error="field.national_id.error"
                        prop="national_id"
                        >
                            <el-input v-model="form.national_id" :placeholder="field.national_id.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.relation.label"
                        :rules="field.relation.rules"
                        :error="field.relation.error"
                        prop="relation"
                        >
                            <el-select v-model="form.relation" :placeholder="field.relation.label">
                                <el-option v-for="option in field.relation.options" :label="option.label" :value="option.value"/>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.birth_place.label"
                        :rules="field.birth_place.rules"
                        :error="field.birth_place.error"
                        prop="birth_place"
                        >
                            <el-input v-model="form.birth_place" :placeholder="field.birth_place.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.birth_date.label"
                        :rules="field.birth_date.rules"
                        :error="field.birth_date.error"
                        prop="birth_date"
                        >
                            <el-date-picker
                                v-model="form.birth_date"
                                :placeholder="field.birth_date.label"
                                type="date"
                                format="DD-MM-YYYY"
                                value-format="YYYY-MM-DD"
                            >
                            </el-date-picker>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.education.label"
                        :rules="field.education.rules"
                        :error="field.education.error"
                        prop="education"
                        >
                            <el-input v-model="form.education" :placeholder="field.education.label"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.occupation.label"
                        :rules="field.occupation.rules"
                        :error="field.occupation.error"
                        prop="occupation"
                        >
                            <el-input v-model="form.occupation" :placeholder="field.occupation.label"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex gap-2 items-center border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-family'"
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