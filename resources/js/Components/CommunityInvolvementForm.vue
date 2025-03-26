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
                title: null,
                location: null,
                position: null,
                start_date: null,
                end_date: null,
                responsibility: null,
                status: null,
            },
            fileList: [],
            field: {
                position: {
                    label: "Posisi",
                    rules: [fieldValidation.isRequired("Posisi")],
                    error: null,
                },
                location: {
                    label: "Lokasi",
                    rules: [fieldValidation.isRequired("Lokasi")],
                    error: null,
                },
                title: {
                    label: "Nama Komunitas",
                    rules: [fieldValidation.isRequired("Nama Komunitas")],
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
                responsibility: {
                    label: "Tanggung Jawab",
                    rules: [fieldValidation.isRequired("Tanggung Jawab")],
                    error: null,
                },
                status: {
                    label: "Status",
                    rules: [fieldValidation.isRequired("Status")],
                    error: null,
                },
            },
        };
    },
    created(){
        if (this.propertyModal.mode == 'edit-community-involvement') {
            this.form.id = this.propertyModal.data.communityInvolvement.id;
            this.form.profile_id = this.propertyModal.data.communityInvolvement.profile_id;
            this.form.title = this.propertyModal.data.communityInvolvement.title;
            this.form.location = this.propertyModal.data.communityInvolvement.location;
            this.form.position = this.propertyModal.data.communityInvolvement.position;
            this.form.start_date = this.propertyModal.data.communityInvolvement.start_date;
            this.form.end_date = this.propertyModal.data.communityInvolvement.end_date;
            this.form.responsibility = this.propertyModal.data.communityInvolvement.responsibility;
            this.form.status = this.propertyModal.data.communityInvolvement.status;
        }else {
            this.form.profile_id = this.propertyModal.data.profile_id;
            console.log(this.form.profile_id);
        }
    },
    methods: {
        async deleteData(){
            this.loading = true;
            axios
                .delete(route('office.myProfile.qualification.communityInvolvement.delete', {
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
            this.$refs["communityInvolvementForm"].validate((valid) => {
                if (valid) {
                    // todo: ref request body filter
                    this.loading = true;

                    const formData = new FormData();
                    formData.append("id", this.form.id);
                    formData.append("profile_id", this.form.profile_id);
                    formData.append("title", this.form.title);
                    formData.append("location", this.form.location);
                    formData.append("position", this.form.position);
                    formData.append("start_date", this.form.start_date);
                    formData.append("end_date", this.form.end_date);
                    formData.append("responsibility", this.form.responsibility);
                    formData.append("status", this.form.status);
                    axios
                        .post(route('office.myProfile.qualification.communityInvolvement.save'), formData, {
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
            ref="communityInvolvementForm"
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
                        :label="field.location.label"
                        :rules="field.location.rules"
                        :error="field.location.error"
                        prop="location"
                        >
                            <el-input v-model="form.location" :placeholder="field.location.label" type="textarea" autosize></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="24">
                        <el-form-item
                        :label="field.responsibility.label"
                        :rules="field.responsibility.rules"
                        :error="field.responsibility.error"
                        prop="responsibility"
                        >
                            <el-input v-model="form.responsibility" :placeholder="field.responsibility.label" type="textarea" autosize></el-input>
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
                            prop="status"
                            :label="field.status.label"
                            :rules="field.status.rules"
                            :error="field.status.error"
                        >
                            <el-select v-model="form.status">
                                <el-option
                                    label="Aktif"
                                    value="active"
                                >
                                </el-option>
                                <el-option
                                    label="Nonaktif"
                                    value="inactive"
                                >
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                </el-row>
            </el-form>
        </div>

        <div class="flex items-center gap-2 border-t border-gray-200 px-3 py-2 dark:border-gray-600">
            <DefaultButton type="default" @click="submit" :disabled="process"> Submit </DefaultButton>
            <OutlineButton
                v-if="this.propertyModal.mode == 'edit-community-involvement'"
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