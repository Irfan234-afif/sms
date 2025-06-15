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
          label: 'Rubrik Tunggal',
          value: 'SINGLE_RUBRIC',
        },
        {
          label: 'Rubrik Ganda',
          value: 'MULTI_RUBRIC',
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
        learning_objective_ids: Array.isArray(item.learning_objectives)
          ? item.learning_objectives.map((learning_objective) => learning_objective.uuid)
          : [],
        learning_objective_ids_options: item.learning_objectives ? item.learning_objectives : [],
        rubric_id: item.rubric ? item.rubric.uuid : null,
        rubric_id_options: item.rubric ? [item.rubric] : [],
        rubric_ids: Array.isArray(item.rubrics) ? item.rubrics.map((rubric) => rubric.uuid) : [],
        rubric_ids_options: item.rubrics ? item.rubrics : [],
        sort_order: index + 1,
        name: item.name,
        description: item.description,
        type: item.type,
        method: item.method,
        date: item.date,
        portion_score: item.portion_score,
      }));
    }
  },
  methods: {
    updateAssessmentType(index) {
      if (this.sessions[index].type == 'SCORE') {
        this.sessions[index].method = null;
        this.sessions[index].rubric_id = null;
        this.sessions[index].rubric_id_options = [];
        this.sessions[index].rubric_ids = [];
        this.sessions[index].rubric_ids_options = [];
      }

      if (this.sessions[index].type == 'SINGLE_RUBRIC') {
        this.sessions[index].method = null;
        this.sessions[index].rubric_ids = [];
        this.sessions[index].rubric_ids_options = [];
      }

      if (this.sessions[index].type == 'MULTI_RUBRIC') {
        this.sessions[index].method = 'AVERAGE';
        this.sessions[index].rubric_id = null;
        this.sessions[index].rubric_id_options = [];
      }
    },
    optionLearningObjective(search, index) {
      axios
        .get(
          route(
            'school.learningActivity.schoolExtracurricular.assessmentExtracurricular.assessmentRecord.optionLearningObjective',
            {
              search: search,
              assessment_record_id: this.assessment_record.uuid,
              school_extracurricular_id: this.assessment_record.assessable.uuid,
              learning_objective_category_id: this.assessment_aspect.learning_objective_category?.uuid,
            },
          ),
        )
        .then((response) => {
          this.sessions[index].learning_objective_ids_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionAssessmentMultiRubric(search, index) {
      axios
        .get(
          route(
            'school.learningActivity.schoolExtracurricular.assessmentExtracurricular.assessmentRecord.optionAssessmentRubric',
            {
              search: search,
              assessment_record_id: this.assessment_record.uuid,
              school_extracurricular_id: this.assessment_record.assessable.uuid,
              assessment_module_id: this.assessment_record.module.uuid,
            },
          ),
        )
        .then((response) => {
          this.sessions[index].rubric_ids_options = response.data;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    optionAssessmentRubric(search, index) {
      axios
        .get(
          route(
            'school.learningActivity.schoolExtracurricular.assessmentExtracurricular.assessmentRecord.optionAssessmentRubric',
            {
              search: search,
              assessment_record_id: this.assessment_record.uuid,
              school_extracurricular_id: this.assessment_record.assessable.uuid,
              assessment_module_id: this.assessment_record.module.uuid,
            },
          ),
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
        learning_objective_ids: [],
        learning_objective_ids_options: [],
        rubric_id: null,
        rubric_id_options: [],
        rubric_ids: [],
        rubric_ids_options: [],
        sort_order: this.sessions.length + 1,
        name: null,
        description: null,
        type: 'SCORE',
        method: null,
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
        item.sort_order = index + 1;
      });
    },
    submit() {
      this.process = true;

      axios
        .post(
          route('school.learningActivity.schoolExtracurricular.assessmentExtracurricular.assessmentRecord.save', {
            assessment_record_id: this.assessment_record.uuid,
            school_extracurricular_id: this.assessment_record.assessable.uuid,
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
          console.error(error);

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
  <div>
    <div class="w-full overflow-x-auto">
      <table class="w-full min-w-max text-left text-xs text-gray-500 dark:text-gray-400">
        <thead>
          <tr>
            <th class="w-[2rem] px-1.5 py-2 text-center">#</th>
            <th class="w-[10rem] px-1.5 py-2">Sesi</th>
            <th class="w-[16rem] px-1.5 py-2">Keterangan</th>
            <th class="w-[14rem] px-1.5 py-2" v-if="assessment_aspect.use_learning_objective">Objektif Pembelajaran</th>
            <th class="w-[10rem] px-1.5 py-2">Jenis Penilaian</th>
            <th class="w-[14rem] px-1.5 py-2">Rubrik</th>
            <th class="w-[8rem] px-1.5 py-2">Porsi Nilai</th>
            <th class="w-[3rem] px-1.5 py-2 text-center"></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(session, index) in sessions" :key="index" class="whitespace-nowrap align-top">
            <td class="px-1.5 py-2 text-center">
              {{ session.sort_order }}
            </td>
            <td class="px-1.5 py-2">
              <el-input v-model="session.name" autocomplete="off" />
            </td>
            <td class="px-1.5 py-2">
              <el-input type="textarea" v-model="session.description" autocomplete="off" />
            </td>
            <td v-if="assessment_aspect.use_learning_objective" class="px-1.5 py-2">
              <el-select
                v-model="session.learning_objective_ids"
                placeholder="Pilih"
                :remote-method="(search) => optionLearningObjective(search, index)"
                multiple
                remote
                filterable
                autocomplete="off"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
              >
                <el-option
                  v-for="option in session.learning_objective_ids_options"
                  :key="option.uuid"
                  :label="option.code"
                  :value="option.uuid"
                />
              </el-select>
            </td>
            <td class="px-1.5 py-2">
              <el-select v-model="session.type" placeholder="Pilih" @change="updateAssessmentType(index)">
                <el-option
                  v-for="option in type_options"
                  :key="option.value"
                  :label="option.label"
                  :value="option.value"
                />
              </el-select>
            </td>
            <td class="px-1.5 py-2">
              <el-select
                v-if="session.type === 'SINGLE_RUBRIC'"
                v-model="session.rubric_id"
                placeholder="Pilih Rubrik"
                :remote-method="(search) => optionAssessmentRubric(search, index)"
                remote
                filterable
                clearable
                autocomplete="off"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
              >
                <el-option
                  v-for="option in session.rubric_id_options"
                  :key="option.uuid"
                  :label="option.name"
                  :value="option.uuid"
                />
              </el-select>
              <el-select
                v-if="session.type === 'MULTI_RUBRIC'"
                v-model="session.rubric_ids"
                placeholder="Pilih"
                :remote-method="(search) => optionAssessmentMultiRubric(search, index)"
                multiple
                remote
                filterable
                autocomplete="off"
                loading-text="..."
                no-match-text="Data tidak ditemukan"
                no-data-text="Tidak ada data"
              >
                <el-option
                  v-for="option in session.rubric_ids_options"
                  :key="option.uuid"
                  :label="option.name"
                  :value="option.uuid"
                />
              </el-select>
            </td>
            <td class="px-1.5 py-2">
              <el-input type="number" v-model="session.portion_score" autocomplete="off">
                <template #append>
                  <span>%</span>
                </template>
              </el-input>
            </td>
            <td class="px-1.5 py-2 text-center">
              <OutlineButton type="red" @click="removeAssessmentSession(index)">
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
            </td>
          </tr>
        </tbody>
      </table>
      <div class="mt-4">
        <DefaultButton type="default" @click="addNewAssessmentSession">Tambah Sesi</DefaultButton>
      </div>
      <div class="flex justify-end space-x-3">
        <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
      </div>
    </div>
  </div>
</template>
