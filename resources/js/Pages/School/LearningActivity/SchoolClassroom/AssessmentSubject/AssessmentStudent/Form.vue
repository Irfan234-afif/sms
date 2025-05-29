<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import _ from 'lodash';
</script>

<script>
export default {
  props: {
    assessment_record: Object,
    students: Array,
  },
  data() {
    return {
      process: false,
      loaded: true,
      isValid: false,
      assessment_students: JSON.parse(JSON.stringify(this.students)),
    };
  },
  watch: {
    assessment_students: {
      handler: _.debounce(function (newVal) {
        newVal.forEach((assessment_student) => {
          (assessment_student.aspect_results || []).forEach((aspect_result) => {
            (aspect_result.sessions || []).forEach((session) => {
              this.handleRawScoreChange(session, aspect_result, assessment_student);
            });
          });
        });
      }, 300), // tunggu 300ms setelah perubahan terakhir
      deep: true,
      immediate: true,
    },
  },
  methods: {
    updateAspectResult(aspect_result) {
      aspect_result.final_score = null;
      let total_sessions = 0;
      let total_score = 0;

      aspect_result.sessions.forEach((session) => {
        const score = parseFloat(session.final_score);
        if (!isNaN(score) && score !== 0) {
          total_sessions += 1;
          total_score += score;
        }
      });

      if (total_sessions > 0) {
        if (aspect_result.final_score_method === 'AVERAGE') {
          aspect_result.final_score = parseFloat(total_score / total_sessions).toFixed();
        } else if (aspect_result.final_score_method === 'SUM') {
          aspect_result.final_score = total_score;
        } else {
          aspect_result.final_score = null;
        }
      } else {
        aspect_result.final_score = null;
      }
    },

    updateFinalResult(student) {
      this.getFinalResultScore(student);
      this.getFinalResultLearningObjectives(student);
    },

    getFinalResultScore(student) {
      student.final_results.forEach((final_result) => {
        let total_aspects = 0;
        let total_score = 0;

        final_result.rule_scores.forEach((rule_score) => {
          const aspect_result = student.aspect_results.find((x) => x.aspect_uuid === rule_score.aspect_uuid);
          total_aspects += 1;
          if (aspect_result && aspect_result.final_score != null) {
            total_score += aspect_result.final_score * (rule_score.portion_score / 100);
          }
        });

        if (total_aspects > 0) {
          if (final_result.score_method === 'AVERAGE_ASPECT') {
            final_result.final_score = parseFloat((total_score / total_aspects).toFixed(2));
          } else if (final_result.score_method === 'SUM_ASPECT') {
            final_result.final_score = parseFloat(total_score.toFixed(2));
          } else {
            final_result.final_score = null;
          }
        } else {
          final_result.final_score = null;
        }
      });
    },

    getFinalResultNarrative(final_result) {
      final_result.final_narrative = null;

      const threshold_scale_passed = final_result.threshold_scale_passed_options.find(
        (x) => x.uuid === final_result.threshold_scale_passed_id,
      );
      const threshold_scale_failed = final_result.threshold_scale_failed_options.find(
        (x) => x.uuid === final_result.threshold_scale_failed_id,
      );
      const learning_objective_passed = final_result.learning_objective_passed_options.find(
        (x) => x.uuid === final_result.learning_objective_passed_id,
      );
      const learning_objective_failed = final_result.learning_objective_failed_options.find(
        (x) => x.uuid === final_result.learning_objective_failed_id,
      );

      final_result.final_predicate = threshold_scale_passed?.predicate ?? null;

      const narrative_parts = [
        threshold_scale_passed?.narrative ?? '',
        learning_objective_passed?.narrative ?? '',
        threshold_scale_failed?.narrative ?? '',
        learning_objective_failed?.narrative ?? '',
      ];

      final_result.final_narrative = narrative_parts.filter((part) => part.trim() !== '').join(' ');

      if (final_result.final_narrative === '') {
        final_result.final_narrative = null;
      }
    },

    getFinalResultLearningObjectives(student) {
      student.final_results.forEach((final_result) => {
        final_result.learning_objective_passed_options = [];
        final_result.learning_objective_failed_options = [];

        let all_valid_sessions = [];
        final_result.rule_narratives.forEach((rule_narrative) => {
          const aspect_result = student.aspect_results.find((x) => x.aspect_uuid === rule_narrative.aspect_uuid);

          if (aspect_result && aspect_result.sessions.length > 0) {
            const valid_sessions = aspect_result.sessions.filter(
              (session) =>
                Array.isArray(session.learning_objectives) &&
                session.learning_objectives.length > 0 &&
                session.final_score != null &&
                session.final_score !== '',
            );
            all_valid_sessions = all_valid_sessions.concat(valid_sessions);
          }
        });

        if (all_valid_sessions.length === 0) {
          return;
        }

        const max_score = Math.max(...all_valid_sessions.map((s) => s.final_score));
        const min_score = Math.min(...all_valid_sessions.map((s) => s.final_score));

        const sessions_with_max = all_valid_sessions.filter((s) => s.final_score === max_score);
        sessions_with_max.forEach((session) => {
          session.learning_objectives.forEach((obj) => {
            if (!final_result.learning_objective_passed_options.some((o) => o.uuid === obj.uuid)) {
              final_result.learning_objective_passed_options.push(obj);
            }
          });
        });

        const sessions_with_min = all_valid_sessions.filter((s) => s.final_score === min_score);
        sessions_with_min.forEach((session) => {
          session.learning_objectives.forEach((obj) => {
            if (!final_result.learning_objective_failed_options.some((o) => o.uuid === obj.uuid)) {
              final_result.learning_objective_failed_options.push(obj);
            }
          });
        });
      });
    },

    handleRawScoreChange(aspect_session, aspect_result, student) {
      if (aspect_session.type == 'SCORE') {
        if (aspect_session.raw_score != null && aspect_session.raw_score != '') {
          aspect_session.final_score = aspect_session.raw_score * (aspect_session.portion_score / 100);
        } else {
          aspect_session.final_score = null;
        }
      } else if (aspect_session.type == 'RUBRIC') {
        let rubric_scale = aspect_session.rubric_scale_options.find((x) => x.uuid === aspect_session.rubric_scale_id);
        if (rubric_scale) {
          aspect_session.raw_score = rubric_scale.score;
          aspect_session.final_score = aspect_session.raw_score * (aspect_session.portion_score / 100);
          aspect_session.final_predicate = rubric_scale.predicate;
          aspect_session.final_narrative = rubric_scale.narrative;
        } else {
          aspect_session.raw_score = null;
          aspect_session.final_score = null;
        }
      } else {
        aspect_session.final_score = null;
      }
      this.updateAspectResult(aspect_result);
      this.updateFinalResult(student);

      console.log(aspect_session.final_score);
    },

    async submit() {
      axios
        .post(
          route('school.learningActivity.schoolClassroom.assessmentSubject.assessmentStudent.save', {
            assessment_record_id: this.assessment_record.uuid,
            school_classroom_id: this.assessment_record.classroom_uuid,
          }),
          {
            assessment_students: this.assessment_students,
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
  },
};
</script>

<template>
  <div class="space-y-3">
    <div class="overflow-x-auto">
      <table class="w-full text-left text-xs text-gray-500 dark:text-gray-400">
        <thead>
          <tr>
            <th class="p-4">Siswa</th>
            <th
              v-for="(aspect_result, idx) in assessment_students[0].aspect_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
              class="p-4"
            >
              {{ aspect_result.aspect_name }}
            </th>
            <th
              v-for="(final_result, idx) in assessment_students[0].final_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
              class="p-4"
            >
              {{ final_result.final_rule_name }}
            </th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(student, index) in assessment_students" :key="index" class="border-b hover:bg-gray-100">
            <th class="px-4 py-3 align-top text-sm">
              <div class="w-72">
                {{ student.student_name }}
              </div>
            </th>
            <td
              v-for="(aspect_result, idx) in student.aspect_results.sort((a, b) => a.sort_order - b.sort_order)"
              :key="idx"
              class="px-4 py-3 align-top"
            >
              <div class="flex space-x-3">
                <template
                  v-for="(session, sidx) in aspect_result.sessions.sort((a, b) => a.sort_order - b.sort_order)"
                  :key="sidx"
                >
                  <div class="flex space-x-3" style="width: 200px">
                    <el-popover :title="session.session_name" placement="top-start" :width="500" trigger="click">
                      <template #reference>
                        <el-button style="width: 100px" type="primary" plain>{{ session.session_name }}</el-button>
                      </template>
                      <template #default>
                        <div v-if="session.learning_objectives">
                          <div v-for="lo in session.learning_objectives" :key="lo.uuid">
                            <span class="font-semibold">{{ lo.code }}</span> {{ lo.narrative }}
                          </div>
                        </div>
                      </template>
                    </el-popover>
                    <el-input
                      v-if="session.type == 'SCORE'"
                      type="number"
                      style="width: 80px"
                      v-model.number="session.raw_score"
                      @input="handleRawScoreChange(session, aspect_result, student)"
                    />
                    <el-select
                      v-if="session.type == 'RUBRIC'"
                      class="w-full"
                      v-model="session.rubric_scale_id"
                      placeholder="Pilih"
                      @input="handleRawScoreChange(session, aspect_result, student)"
                      clearable
                    >
                      <el-option
                        v-for="option in session.rubric_scale_options"
                        :key="option.uuid"
                        :label="option.predicate"
                        :value="option.uuid"
                      />
                    </el-select>
                  </div>
                </template>
                <div class="col-span-1 flex space-x-3" v-if="aspect_result.use_final_score">
                  <el-button style="width: 100px" type="warning" plain>Nilai Akhir</el-button>
                  <el-input type="number" style="width: 80px" v-model.number="aspect_result.final_score" readonly />
                </div>
              </div>
            </td>
            <td
              v-for="(final_result, idx) in student.final_results.sort((a, b) => a.sort_order - b.sort_order)"
              :key="idx"
              class="px-4 py-3 align-top"
            >
              <div class="flex space-x-3">
                <div class="flex space-x-3" v-if="final_result.use_score">
                  <el-button style="width: 100px" type="success" plain>Nilai Akhir</el-button>
                  <div style="width: 80px">
                    <el-input type="number" v-model.number="final_result.final_score" readonly />
                  </div>
                  <el-button plain v-if="final_result.use_predicate">{{
                    final_result.final_predicate ?? '-'
                  }}</el-button>
                </div>
                <div class="flex space-x-3" v-if="final_result.use_narrative">
                  <el-button style="width: 240px" plain>KKTP Tuntas</el-button>
                  <el-select
                    v-model="final_result.threshold_scale_passed_id"
                    placeholder="Pilih"
                    @change="getFinalResultNarrative(final_result)"
                    clearable
                  >
                    <el-option
                      v-for="option in final_result.threshold_scale_passed_options"
                      :key="option.uuid"
                      :label="option.narrative"
                      :value="option.uuid"
                    />
                  </el-select>
                </div>
                <div class="flex space-x-3" v-if="final_result.use_narrative">
                  <el-button style="width: 240px" plain>Objektif Tuntas</el-button>
                  <el-select
                    v-model="final_result.learning_objective_passed_id"
                    placeholder="Pilih"
                    @change="getFinalResultNarrative(final_result)"
                    clearable
                  >
                    <el-option
                      v-for="option in final_result.learning_objective_passed_options"
                      :key="option.uuid"
                      :label="option.code"
                      :value="option.uuid"
                    />
                  </el-select>
                </div>
                <div class="flex space-x-3" v-if="final_result.use_narrative">
                  <el-button style="width: 240px" plain>KKTP Tidak Tuntas</el-button>
                  <el-select
                    v-model="final_result.threshold_scale_failed_id"
                    placeholder="Pilih"
                    @change="getFinalResultNarrative(final_result)"
                    clearable
                  >
                    <el-option
                      v-for="option in final_result.threshold_scale_failed_options"
                      :key="option.uuid"
                      :label="option.narrative"
                      :value="option.uuid"
                    />
                  </el-select>
                </div>
                <div class="flex space-x-3" v-if="final_result.use_narrative">
                  <el-button style="width: 240px" plain>Objektif Tidak Tuntas</el-button>
                  <el-select
                    v-model="final_result.learning_objective_failed_id"
                    placeholder="Pilih"
                    @change="getFinalResultNarrative(final_result)"
                    clearable
                  >
                    <el-option
                      v-for="option in final_result.learning_objective_failed_options"
                      :key="option.uuid"
                      :label="option.code"
                      :value="option.uuid"
                    />
                  </el-select>
                </div>
                <div v-if="final_result.use_narrative" class="flex space-x-3" style="width: 480px">
                  <el-input type="textarea" :rows="5" v-model="final_result.final_narrative" readonly />
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
