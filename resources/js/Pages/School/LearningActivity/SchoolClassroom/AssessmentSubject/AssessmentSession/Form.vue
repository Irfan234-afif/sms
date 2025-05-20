<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import axios from 'axios';
import { ElNotification } from 'element-plus';
</script>

<script>
export default {
  props: {
    assessment_record: Object,
    assessment_aspect: Object,
    assessment_sessions: Array,
  },
  data() {
    return {
      process: false,
      loaded: true,
      isValid: false,
      sessions: [],
      type_options: [
        {
          label: 'Skor',
          value: 'SCORE',
        },
        {
          label: 'Rubrik',
          value: 'RUBRIC',
        },
      ],
    };
  },
  created() {
    let assessment_sessions = this.assessment_sessions.filter((session) => {
      return session.aspect_id == this.assessment_aspect.id;
    });
    if (assessment_sessions) {
      this.sessions = assessment_sessions.map((item, index) => ({
        uuid: item.uuid,
        record_id: this.assessment_record.uuid,
        aspect_id: this.assessment_aspect.uuid,
        learning_objective_id: item.learning_objective ? item.learning_objective.uuid : null,
        learning_objective_id_options: item.learning_objective ? [item.learning_objective] : [],
        rubric_id: item.rubric ? item.rubric.uuid : null,
        rubric_id_options: item.rubric ? [item.rubric] : [],
        sort_number: index + 1,
        name: item.name,
        type: item.type,
        date: item.date,
        portion_score: item.portion_score,
      }));
    }
  },
  methods: {
    optionLearningObjective(search, index) {
      axios
        .get(
          route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentRecord.optionLearningObjective', {
            search: search,
            assessment_record_id: this.assessment_record.uuid,
            school_classroom_id: this.assessment_record.classroom.uuid,
            learning_objective_category_id: this.assessment_aspect.learning_objective_category?.uuid,
          }),
        )
        .then((response) => {
          this.sessions[index].learning_objective_id_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionAssessmentRubric(search, index) {
      axios
        .get(
          route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentRecord.optionAssessmentRubric', {
            search: search,
            assessment_record_id: this.assessment_record.uuid,
            school_classroom_id: this.assessment_record.classroom.uuid,
            assessment_module_id: this.assessment_record.module.uuid,
          }),
        )
        .then((response) => {
          this.sessions[index].rubric_id_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    addNewAssessmentSession() {
      let newObj = {
        uuid: null,
        record_id: this.assessment_record.uuid,
        aspect_id: this.assessment_aspect.uuid,
        learning_objective_id: null,
        learning_objective_id_options: [],
        rubric_id: null,
        rubric_id_options: [],
        sort_number: this.sessions.length + 1,
        name: null,
        type: 'SCORE',
        date: null,
        portion_score: 100,
      };
      this.sessions.push(newObj);
    },
    removeAssessmentSession(index) {
      this.sessions.splice(index, 1);
      this.renumberSortNumbers();
    },
    renumberSortNumbers() {
      this.sessions.forEach((item, index) => {
        item.sort_number = index + 1;
      });
    },
    submit() {
      this.process = true;

      axios
        .post(
          route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentRecord.save', {
            assessment_record_id: this.assessment_record.uuid,
            school_classroom_id: this.assessment_record.classroom.uuid,
          }),
          {
            sessions: this.sessions,
          },
          {
            headers: { 'Content-Type': 'application/json' },
          },
        )
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
          // if (error.response?.data?.errors) {
          //   for (let field in error.response.data.errors) {
          //     this.field[field].error = error.response.data.errors[field][0];
          //     this.$refs['assessmentSessionForm'].validateField(field);
          //     message = error.response.data.errors[field][0];
          //   }
          // }

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
    },
    close() {
      this.$emit('close');
    },
  },
};
</script>

<template>
  <div class="space-y-6 py-5">
    <el-form v-if="loaded" ref="assessmentSessionForm" label-position="top" :disabled="process" class="space-y-4">
      <template v-for="(session, index) in sessions" :key="index">
        <div class="rounded-lg border p-4 shadow-sm">
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">
            {{ 'Sesi ' + session.sort_number }}
          </h2>
          <div class="flex space-x-3">
            <el-form-item class="w-full font-medium md:w-1/4" label="Judul">
              <el-input v-model="session.name" autocomplete="off" />
            </el-form-item>
            <el-form-item
              v-if="assessment_aspect.use_learning_objective"
              class="w-full font-medium md:w-1/4"
              label="Objektif Pembelajaran"
            >
              <el-select
                v-model="session.learning_objective_id"
                placeholder="Pilih Objektif Pembelajaran"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="(search) => optionLearningObjective(search, index)"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
              >
                <el-option
                  v-for="option in session.learning_objective_id_options"
                  :key="option.uuid"
                  :label="option.title"
                  :value="option.uuid"
                />
              </el-select>
            </el-form-item>
            <el-form-item class="w-full font-medium md:w-1/4" label="Jenis Penilaian">
              <el-select v-model="session.type" placeholder="Pilih Jenis Penilaian">
                <el-option
                  v-for="option in type_options"
                  :key="option.value"
                  :label="option.label"
                  :value="option.value"
                />
              </el-select>
            </el-form-item>
            <el-form-item class="w-full font-medium md:w-1/4" label="Rubrik" v-if="session.type === 'RUBRIC'">
              <el-select
                v-model="session.rubric_id"
                placeholder="Pilih Rubrik"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
                :remote-method="(search) => optionAssessmentRubric(search, index)"
                remote
                filterable
                reserve-keyword
                clearable
                autocomplete="off"
              >
                <el-option
                  v-for="option in session.rubric_id_options"
                  :key="option.uuid"
                  :label="option.name"
                  :value="option.uuid"
                />
              </el-select>
            </el-form-item>
            <el-form-item class="w-full font-medium md:w-1/5" label="Porsi Nilai">
              <el-input type="number" v-model="session.portion_score" autocomplete="off">
                <template #append>
                  <div>%</div>
                </template>
              </el-input>
            </el-form-item>
            <div v-if="index == sessions.length - 1" class="pt-7">
              <OutlineButton type="red" @click="removeAssessmentSession(index)" class="flex space-x-1">
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
              </OutlineButton>
            </div>
          </div>
        </div>
      </template>
      <DefaultButton type="default" @click="addNewAssessmentSession(index)">Tambah Sesi</DefaultButton>
    </el-form>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
