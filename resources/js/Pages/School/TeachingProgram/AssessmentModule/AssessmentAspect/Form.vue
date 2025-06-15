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
        assessment_aspect_id: this.propertyModal.data?.assessment_aspect?.uuid,
        assessment_module_id: this.propertyModal.data.assessment_module.uuid,
        name: null,
        sort_order: this.propertyModal.data.sort_order,
        use_sessions: false,
        total_sessions: 1,
        use_final_score: false,
        final_score_method: null,
        use_learning_objective: false,
        learning_objective_category_id: null,
      },
      field: {
        name: {
          label: 'Penilaian Aspek',
          rules: [fieldValidation.isRequired('Penilaian Aspek')],
          error: null,
          disabled: false,
          options: [],
        },
        use_sessions: {
          label: 'Gunakan Sesi',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        total_sessions: {
          label: 'Jumlah Sesi',
          rules: [fieldValidation.isRequired('Jumlah Sesi')],
          error: null,
          disabled: false,
          options: [],
        },
        use_final_score: {
          label: 'Gunakan Skor Final',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        final_score_method: {
          label: 'Metode Skor Final',
          rules: [fieldValidation.isRequired('Metode Skor Final')],
          error: null,
          disabled: false,
          options: [
            {
              label: 'Rata-rata',
              value: 'AVERAGE',
            },
            {
              label: 'Penjumlahan',
              value: 'SUM',
            },
          ],
        },
        use_learning_objective: {
          label: 'Gunakan Objektif Pembelajaran',
          rules: [],
          error: null,
          disabled: false,
          options: [],
        },
        learning_objective_category_id: {
          label: 'Kategori Objektif Pembelajaran',
          rules: [fieldValidation.isRequired('Kategori Objektif Pembelajaran')],
          error: null,
          disabled: false,
          options: [],
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'assessment-aspect-edit-form') {
      this.form.name = this.propertyModal.data.assessment_aspect?.name;
      this.form.sort_order = this.propertyModal.data.assessment_aspect?.sort_order;
      this.form.use_sessions = !!this.propertyModal.data.assessment_aspect?.use_sessions;
      this.form.total_sessions = this.propertyModal.data.assessment_aspect?.total_sessions;
      this.form.use_final_score = !!this.propertyModal.data.assessment_aspect?.use_final_score;
      this.form.final_score_method = this.propertyModal.data.assessment_aspect?.final_score_method;
      this.form.use_learning_objective = !!this.propertyModal.data.assessment_aspect?.use_learning_objective;
      this.form.learning_objective_category_id =
        this.propertyModal.data.assessment_aspect?.learning_objective_category?.uuid;
      if (this.propertyModal.data.assessment_aspect?.learning_objective_category) {
        this.field.learning_objective_category_id.options = [
          this.propertyModal.data.assessment_aspect?.learning_objective_category,
        ];
      }
    }
  },
  methods: {
    optionLearningObjectiveCategory(search) {
      this.field.learning_objective_category_id.loading = true;
      axios
        .get(
          route('school.teachingProgram.assessmentModule.assessmentAspect.optionLearningObjectiveCategory', {
            search: search,
            assessment_module_id: this.propertyModal.data.assessment_module.uuid,
          }),
        )
        .then((response) => {
          this.field.learning_objective_category_id.options = response.data;
          this.field.learning_objective_category_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.learning_objective_category_id.loading = false;
        });
    },
    submit() {
      this.$refs['assessmentAspect'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('school.teachingProgram.assessmentModule.assessmentAspect.save'), requestPayload, {
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
              } else {
                ElNotification({
                  title: 'Error',
                  message: response.data.message,
                  type: 'error',
                });
              }
            })
            .catch((error) => {
              let message = 'Terjadi kesalahan';
              if (error.response?.data?.errors) {
                for (let field in error.response.data.errors) {
                  this.field[field].error = error.response.data.errors[field][0];
                  this.$refs['assessmentAspect'].validateField(field);
                  message = error.response.data.errors[field][0];
                }
              }

              ElNotification({
                title: 'Error',
                message: message,
                type: 'error',
              });
            })
            .finally(() => {
              this.process = false;
              this.loaded = false;
              this.$nextTick(() => {
                this.loaded = true;
              });
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
    <h2 class="border-b pb-4 text-base font-medium text-gray-900">
      {{ propertyModal?.title }}
    </h2>
    <div class="px-2">
      <el-form v-if="loaded" ref="assessmentAspect" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.name.label"
          :rules="field.name.rules"
          :error="field.name.error"
          prop="name"
        >
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.use_sessions.label"
          :rules="field.use_sessions.rules"
          :error="field.use_sessions.error"
          prop="use_sessions"
        >
          <el-checkbox border v-model="form.use_sessions" :label="form.use_sessions ? 'Ya' : 'Tidak'" />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.use_final_score.label"
          :rules="field.use_final_score.rules"
          :error="field.use_final_score.error"
          prop="use_final_score"
        >
          <el-checkbox border v-model="form.use_final_score" :label="form.use_final_score ? 'Ya' : 'Tidak'" />
        </el-form-item>
        <el-form-item
          v-if="form.use_final_score"
          class="font-medium"
          :label="field.total_sessions.label"
          :rules="field.total_sessions.rules"
          :error="field.total_sessions.error"
          prop="total_sessions"
        >
          <el-input type="number" v-model="form.total_sessions" autocomplete="off">
            <template #append>
              <div>Sesi</div>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item
          v-if="form.use_final_score"
          class="font-medium"
          :label="field.final_score_method.label"
          :rules="field.final_score_method.rules"
          :error="field.final_score_method.error"
          prop="final_score_method"
        >
          <el-select
            v-model="form.final_score_method"
            :placeholder="`Pilih ${field.final_score_method.label}`"
            clearable
          >
            <el-option
              v-for="option in field.final_score_method.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.use_learning_objective.label"
          :rules="field.use_learning_objective.rules"
          :error="field.use_learning_objective.error"
          prop="use_learning_objective"
        >
          <el-checkbox
            border
            v-model="form.use_learning_objective"
            :label="form.use_learning_objective ? 'Ya' : 'Tidak'"
          />
        </el-form-item>
        <el-form-item
          v-if="form.use_learning_objective"
          class="font-medium"
          :label="field.learning_objective_category_id.label"
          :rules="field.learning_objective_category_id.rules"
          :error="field.learning_objective_category_id.error"
          prop="learning_objective_category_id"
        >
          <el-select
            v-model="form.learning_objective_category_id"
            :placeholder="`Pilih ${field.learning_objective_category_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.learning_objective_category_id.disabled"
            :remote-method="optionLearningObjectiveCategory"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.learning_objective_category_id.options"
              :key="option.uuid"
              :label="option.title"
              :value="option.uuid"
            />
          </el-select>
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
