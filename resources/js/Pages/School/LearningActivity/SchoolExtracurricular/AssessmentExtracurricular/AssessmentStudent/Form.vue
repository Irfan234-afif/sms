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
      }, 300),
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
          aspect_result.final_score = parseFloat((total_score / total_sessions).toFixed(2));
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
      [
        'threshold_scale_passed_id',
        'threshold_scale_failed_id',
        'learning_objective_passed_id',
        'learning_objective_failed_id',
      ].forEach((key) => {
        if (final_result[key] === undefined) {
          final_result[key] = null;
        }
      });

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

      final_result.predicate_passed = threshold_scale_passed?.predicate ?? null;
      final_result.predicate_failed = threshold_scale_failed?.predicate ?? null;

      const narrative_passed_parts = [
        threshold_scale_passed?.narrative ?? '',
        learning_objective_passed?.narrative ?? '',
      ];

      final_result.narrative_passed = narrative_passed_parts.filter((part) => part.trim() !== '').join(' ') || null;

      const narrative_failed_parts = [
        threshold_scale_failed?.narrative ?? '',
        learning_objective_failed?.narrative ?? '',
      ];

      final_result.narrative_failed = narrative_failed_parts.filter((part) => part.trim() !== '').join(' ') || null;

      const final_narrative_parts = [final_result.narrative_passed ?? '', final_result.narrative_failed ?? ''];

      final_result.final_narrative = final_narrative_parts.filter((part) => part.trim() !== '').join(' ') || null;

      final_result.final_predicate = final_result.predicate_passed ?? null;
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
                session.learning_objectives.length > 0 && session.final_score != null && session.final_score !== '',
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
      } else if (aspect_session.type == 'SINGLE_RUBRIC') {
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
      } else if (aspect_session.type == 'MULTI_RUBRIC') {
        aspect_session.rubrics.forEach((aspect_session_rubric) => {
          let rubric_scale = aspect_session_rubric.rubric_scale_options.find(
            (x) => x.uuid === aspect_session_rubric.rubric_scale_id,
          );

          if (rubric_scale) {
            aspect_session_rubric.score = rubric_scale.score;
            aspect_session_rubric.predicate = rubric_scale.predicate;
            aspect_session_rubric.narrative = rubric_scale.narrative;
          } else {
            aspect_session_rubric.score = null;
            aspect_session_rubric.predicate = null;
            aspect_session_rubric.narrative = null;
          }
        });

        if (aspect_session.method == 'AVERAGE') {
          let total_aspect_session_rubrics = 0;
          let total_score = 0;

          aspect_session.rubrics.forEach((aspect_session_rubric) => {
            const score = parseFloat(aspect_session_rubric.score);
            if (!isNaN(score) && score !== 0) {
              total_aspect_session_rubrics += 1;
              total_score += score;
            }
          });

          if (total_aspect_session_rubrics > 0) {
            aspect_session.raw_score = parseFloat((total_score / total_aspect_session_rubrics).toFixed(2));
          } else {
            aspect_session.raw_score = null;
          }

          aspect_session.final_score = aspect_session.raw_score;
        } else {
          let total_score = 0;

          aspect_session.rubrics.forEach((aspect_session_rubric) => {
            const score = parseFloat(aspect_session_rubric.final_score);
            if (!isNaN(score)) {
              total_score += score;
            }
          });

          aspect_session.final_score = total_score;
        }
      } else {
        aspect_session.final_score = null;
      }
      this.updateAspectResult(aspect_result);
      this.updateFinalResult(student);
    },

    async submit() {
      axios
        .post(
          route('school.learningActivity.schoolExtracurricular.assessmentExtracurricular.assessmentStudent.save', {
            assessment_record_id: this.assessment_record.uuid,
            school_extracurricular_id: this.assessment_record.assessable_uuid,
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
      <table class="h-full w-full text-left text-xs text-gray-500 dark:text-gray-400">
        <thead>
          <tr>
            <th class="px-1.5 py-2" rowspan="2">
              <el-button class="w-full" style="height: 80px" type="primary" plain>Siswa</el-button>
            </th>
            <th
              v-for="(aspect_result, idx) in assessment_students[0].aspect_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
              class="px-1.5 py-2"
              :colspan="aspect_result.sessions.length + (aspect_result.use_final_score ? 1 : 0)"
            >
              <el-button class="w-full" type="primary" plain> {{ aspect_result.aspect_name }}</el-button>
            </th>
            <th
              v-for="(final_result, idx) in assessment_students[0].final_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
              class="px-1.5 py-2"
            >
              <el-button class="w-full" type="primary" plain> {{ final_result.final_rule_name }}</el-button>
            </th>
          </tr>
          <tr>
            <template
              v-for="(aspect_result, idx) in assessment_students[0].aspect_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
            >
              <template
                v-for="(session, sidx) in aspect_result.sessions.sort((a, b) => a.sort_order - b.sort_order)"
                :key="sidx"
              >
                <th class="px-1.5 py-2">
                  <el-popover :title="session.session_name" placement="top-start" :width="500" trigger="click">
                    <template #reference>
                      <el-button class="w-full" type="primary" plain>
                        {{ session.session_name }}
                      </el-button>
                    </template>
                    <template #default>
                      <div class="space-y-2 text-xs text-gray-700">
                        <div class="flex gap-1">
                          <span class="w-32 font-medium text-gray-900">Keterangan:</span>
                          <span class="flex-1">{{ session.description || '-' }}</span>
                        </div>
                        <div class="flex gap-1">
                          <span class="w-32 font-medium text-gray-900">Jenis Penilaian:</span>
                          <span class="flex-1">{{ session.type_label || '-' }}</span>
                        </div>
                        <div class="flex gap-1">
                          <span class="w-32 font-medium text-gray-900">Porsi Nilai:</span>
                          <span class="flex-1">{{ session.portion_score || '-' }}%</span>
                        </div>
                      </div>
                      <div v-if="session.use_learning_objective">
                        <h3 class="mb-2 mt-4 border-b pb-1 text-xs font-semibold text-gray-800">
                          Objektif Pembelajaran
                        </h3>

                        <div v-if="session.learning_objectives?.length" class="space-y-2">
                          <div
                            v-for="learning_objective in session.learning_objectives"
                            :key="learning_objective.uuid"
                            class="rounded-md border border-gray-200 bg-gray-50 p-2"
                          >
                            <div class="text-xs">
                              <span class="font-semibold text-blue-600">{{ learning_objective.code }}</span>
                              <span class="ml-2 text-gray-700">{{ learning_objective.narrative }}</span>
                            </div>
                          </div>
                        </div>
                        <div v-else class="text-xs italic text-gray-500">Tidak ada tujuan pembelajaran.</div>
                      </div>
                    </template>
                  </el-popover>
                </th>
              </template>
              <th v-if="aspect_result.use_final_score" class="px-1.5 py-2">
                <div>
                  <el-button style="width: 5.5rem" type="warning" plain>Nilai Akhir</el-button>
                </div>
              </th>
            </template>
            <td
              v-for="(final_result, idx) in assessment_students[0].final_results.sort(
                (a, b) => a.sort_order - b.sort_order,
              )"
              :key="idx"
              class="px-1.5 py-2 align-top"
            >
              <div class="flex">
                <div class="mx-auto flex space-x-3">
                  <div v-if="final_result.use_score">
                    <el-button style="width: 5.5rem" type="success" plain>Nilai Akhir</el-button>
                  </div>
                  <div v-if="final_result.use_predicate">
                    <el-button style="width: 5.5rem" type="success" plain>Predikat</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 12.5rem" plain>KKTP Tuntas</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 12.5rem" plain>Objektif Tuntas</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 12.5rem" plain>KKTP Tidak Tuntas</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 12.5rem" plain>Objektif Tidak Tuntas</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 22.5rem" plain>Naratif Akhir Tuntas </el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-button style="width: 22.5rem" plain>Naratif Akhir Tidak Tuntas </el-button>
                  </div>
                </div>
              </div>
            </td>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(student, index) in assessment_students" :key="index" class="border-b hover:bg-gray-100">
            <th class="px-1.5 py-2 align-top text-xs">
              <div class="w-72">
                {{ student.student_name }}
              </div>
            </th>
            <template
              v-for="(aspect_result, idx) in student.aspect_results.sort((a, b) => a.sort_order - b.sort_order)"
              :key="idx"
            >
              <template
                v-for="(session, sidx) in aspect_result.sessions.sort((a, b) => a.sort_order - b.sort_order)"
                :key="sidx"
              >
                <td class="px-1.5 py-2 align-top">
                  <div class="flex space-x-3">
                    <el-input
                      style="width: 5.5rem"
                      v-if="session.type == 'SCORE'"
                      type="number"
                      v-model.number="session.raw_score"
                      @change="handleRawScoreChange(session, aspect_result, student)"
                    />
                    <el-select
                      style="width: 7.5rem"
                      v-if="session.type == 'SINGLE_RUBRIC'"
                      class="w-full"
                      v-model="session.rubric_scale_id"
                      placeholder="Pilih"
                      @change="handleRawScoreChange(session, aspect_result, student)"
                      clearable
                    >
                      <el-option
                        v-for="option in session.rubric_scale_options"
                        :key="option.uuid"
                        :label="option.predicate"
                        :value="option.uuid"
                      />
                    </el-select>
                    <template v-if="session.type == 'MULTI_RUBRIC'">
                      <template v-for="(rubric, ridx) in session.rubrics" :key="ridx">
                        <el-popover placement="bottom-start" trigger="click" width="200">
                          <p>{{ rubric.rubric_name }}</p>
                          <template #reference>
                            <el-button style="width: 4.5rem">
                              {{ rubric.rubric_code }}
                            </el-button>
                          </template>
                        </el-popover>
                        <el-select
                          style="width: 4.5rem"
                          class="w-full"
                          v-model="rubric.rubric_scale_id"
                          placeholder=""
                          @change="handleRawScoreChange(session, aspect_result, student)"
                          clearable
                        >
                          <el-option
                            v-for="option in rubric.rubric_scale_options"
                            :key="option.uuid"
                            :label="option.predicate"
                            :value="option.uuid"
                          />
                        </el-select>
                      </template>
                      <div>
                        <el-button style="width: 5.5rem" type="warning" plain>
                          {{ session.final_score }}
                        </el-button>
                      </div>
                    </template>
                  </div>
                </td>
              </template>
              <td v-if="aspect_result.use_final_score" class="px-1.5 py-2 align-top">
                <div>
                  <el-button style="width: 5.5rem" type="warning" plain>
                    {{ aspect_result.final_score }}
                  </el-button>
                </div>
              </td>
            </template>
            <td
              v-for="(final_result, idx) in student.final_results.sort((a, b) => a.sort_order - b.sort_order)"
              :key="idx"
              class="px-1.5 py-2 align-top"
            >
              <div class="flex">
                <div class="mx-auto flex space-x-3">
                  <div v-if="final_result.use_score">
                    <el-button style="width: 5.5rem" type="success" plain v-if="final_result.use_score">{{
                      final_result.final_score
                    }}</el-button>
                  </div>
                  <div v-if="final_result.use_predicate">
                    <el-button style="width: 5.5rem" type="success" plain v-if="final_result.use_predicate">{{
                      final_result.final_predicate ?? '-'
                    }}</el-button>
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-select
                      style="width: 12.5rem"
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
                  <div v-if="final_result.use_narrative">
                    <el-select
                      style="width: 12.5rem"
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
                  <div v-if="final_result.use_narrative">
                    <el-select
                      style="width: 12.5rem"
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
                  <div v-if="final_result.use_narrative">
                    <el-select
                      style="width: 12.5rem"
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
                  <div v-if="final_result.use_narrative">
                    <el-input
                      style="width: 22.5rem"
                      type="textarea"
                      :rows="1"
                      v-model="final_result.narrative_passed"
                      readonly
                    />
                  </div>
                  <div v-if="final_result.use_narrative">
                    <el-input
                      style="width: 22.5rem"
                      type="textarea"
                      :rows="1"
                      v-model="final_result.narrative_failed"
                      readonly
                    />
                  </div>
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
