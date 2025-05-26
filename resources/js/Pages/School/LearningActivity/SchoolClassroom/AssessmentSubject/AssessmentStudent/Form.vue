<script>
export default {
  props: {
    students: Array,
  },
  data() {
    return {
      assessment_students: JSON.parse(JSON.stringify(this.students)), // Clone untuk local state
    };
  },
  methods: {
    updateAspectResult(aspect_result) {
      let total_sessions = null;
      let total_score = null;

      aspect_result.sessions.forEach((session) => {
        if (session.final_score != null && session.final_score !== '') {
          total_sessions += 1;
          total_score += Number(session.final_score);
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
      aspect_session.final_score = aspect_session.raw_score * (aspect_session.portion_score / 100);
      this.updateAspectResult(aspect_result);
      this.updateFinalResult(student);
    },
  },
};
</script>

<template>
  <div>
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
              <div class="grid grid-cols-3 gap-3" style="width: 570px">
                <template
                  v-for="(session, sidx) in aspect_result.sessions.sort((a, b) => a.sort_order - b.sort_order)"
                  :key="sidx"
                >
                  <div class="col-span-1 flex space-x-3">
                    <el-popover :title="session.session_name" placement="top-start" :width="500" trigger="click">
                      <template #reference>
                        <el-button class="w-full" type="primary" plain>{{ session.session_name }}</el-button>
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
                      type="number"
                      class="w-full"
                      v-model.number="session.raw_score"
                      @input="handleRawScoreChange(session, aspect_result, student)"
                    />
                  </div>
                </template>
                <div class="col-span-1 flex space-x-3" v-if="aspect_result.use_final_score">
                  <el-button class="w-full" type="warning" plain>Nilai Akhir</el-button>
                  <el-input type="number" class="w-full" v-model.number="aspect_result.final_score" readonly />
                </div>
              </div>
            </td>
            <td
              v-for="(final_result, idx) in student.final_results.sort((a, b) => a.sort_order - b.sort_order)"
              :key="idx"
              class="px-4 py-3 align-top"
            >
              <div class="flex space-x-3">
                <div class="grid w-full grid-cols-2 gap-3" style="width: 485px">
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_score">
                    <el-button style="width: 280px" type="success" plain>Nilai Akhir</el-button>
                    <el-input type="number" v-model.number="final_result.final_score" readonly />
                    <el-button plain v-if="final_result.use_predicate">{{ final_result.predicate ?? '-' }}</el-button>
                  </div>
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_narrative">
                    <el-button style="width: 240px" plain>KK Tuntas</el-button>
                    <el-select
                      class="w-2/3"
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
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_narrative">
                    <el-button style="width: 240px" plain>Objektif Tuntas</el-button>
                    <el-select
                      class="w-2/3"
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
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_narrative">
                    <el-button style="width: 240px" plain>KK Tidak Tuntas</el-button>
                    <el-select
                      class="w-2/3"
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
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_narrative">
                    <el-button style="width: 240px" plain>Objektif Tidak Tuntas</el-button>
                    <el-select
                      class="w-2/3"
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
                </div>
                <div class="grid w-full grid-cols-1 gap-3" style="width: 485px" v-if="final_result.use_narrative">
                  <div class="col-span-2 flex space-x-3" v-if="final_result.use_score">
                    <el-input type="textarea" :rows="5" v-model="final_result.final_narrative" readonly />
                  </div>
                </div>
              </div>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</template>
