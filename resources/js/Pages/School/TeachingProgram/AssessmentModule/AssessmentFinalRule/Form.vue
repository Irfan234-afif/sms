<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import OutlineButton from '@/Components/OutlineButton.vue';
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
        assessment_final_rule_id: this.propertyModal.data?.assessment_final_rule?.uuid,
        assessment_module_id: this.propertyModal.data.assessment_module.uuid,
        name: null,
        sort_order: this.propertyModal.data.sort_order,
        use_score: false,
        score_method: null,
        use_predicate: false,
        predicate_method: null,
        use_narrative: false,
        narrative_method: null,
        final_rule_scores: [],
        final_rule_narratives: [],
      },
      field: {
        name: {
          label: 'Penilaian Aspek',
          rules: [fieldValidation.isRequired('Penilaian Aspek')],
          error: null,
          disabled: false,
          options: [],
        },
        use_score: {
          label: 'Gunakan Skor',
          rules: [fieldValidation.isRequired('Gunakan Skor')],
          error: null,
          disabled: false,
          options: [],
        },
        score_method: {
          label: 'Metode Skor',
          rules: [fieldValidation.isRequired('Metode Skor')],
          error: null,
          disabled: false,
          options: [
            {
              label: 'Rata-rata Penilaian Aspek',
              value: 'AVERAGE_ASPECT',
            },
            {
              label: 'Penjumlahan Penilaian Aspek',
              value: 'SUM_ASPECT',
            },
          ],
        },
        use_predicate: {
          label: 'Gunakan Predikat',
          rules: [fieldValidation.isRequired('Gunakan Predikat')],
          error: null,
          disabled: false,
          options: [],
        },
        predicate_method: {
          label: 'Metode Predikat',
          rules: [fieldValidation.isRequired('Metode Predikat')],
          error: null,
          disabled: false,
          options: [
            {
              label: 'Kriteria Ketercapaian',
              value: 'THRESHOLD',
            },
          ],
        },
        use_narrative: {
          label: 'Gunakan Naratif',
          rules: [fieldValidation.isRequired('Gunakan Naratif')],
          error: null,
          disabled: false,
          options: [],
        },
        narrative_method: {
          label: 'Metode Naratif',
          rules: [fieldValidation.isRequired('Metode Naratif')],
          error: null,
          disabled: false,
          options: [
            {
              label: 'Kriteria Ketercapaian + Objektif Pembelajaran',
              value: 'THRESHOLD_PLUS_LEARNING_OBJECTIVE',
            },
          ],
        },
      },
    };
  },
  created() {
    let mode = this.propertyModal.mode;
    if (mode == 'assessment-final-rule-edit-form') {
      this.form.name = this.propertyModal.data.assessment_final_rule?.name;
      this.form.sort_order = this.propertyModal.data.assessment_final_rule?.sort_order;
      this.form.use_score = !!this.propertyModal.data.assessment_final_rule?.use_score;
      this.form.score_method = this.propertyModal.data.assessment_final_rule?.score_method;
      this.form.use_predicate = !!this.propertyModal.data.assessment_final_rule?.use_predicate;
      this.form.predicate_method = this.propertyModal.data.assessment_final_rule?.predicate_method;
      this.form.use_narrative = !!this.propertyModal.data.assessment_final_rule?.use_narrative;
      this.form.narrative_method = this.propertyModal.data.assessment_final_rule?.narrative_method;
      if (this.propertyModal.data.assessment_final_rule?.scores) {
        this.propertyModal.data.assessment_final_rule?.scores.map((item) => {
          this.addNewFinalRuleScore(item);
        });
      } else {
        this.addNewFinalRuleScore(null);
      }
      if (this.propertyModal.data.assessment_final_rule?.narratives) {
        this.propertyModal.data.assessment_final_rule?.narratives.map((item) => {
          this.addNewFinalRuleNarrative(item);
        });
      } else {
        this.addNewFinalRuleNarrative(null);
      }
    }
  },
  methods: {
    addNewFinalRuleScore(final_rule_score = null) {
      let newObj = {
        id: null,
        aspect_id: null,
        portion_score: 0,
      };

      if (final_rule_score) {
        newObj.id = final_rule_score.uuid;
        newObj.aspect_id = final_rule_score.aspect.uuid;
        newObj.portion_score = final_rule_score.portion_score;
      }

      this.form.final_rule_scores.push(newObj);
    },

    removeFinalRuleScore(index) {
      this.form.final_rule_scores.splice(index, 1);
    },

    addNewFinalRuleNarrative(final_rule_narrative = null) {
      let newObj = {
        id: null,
        aspect_id: null,
      };

      if (final_rule_narrative) {
        newObj.id = final_rule_narrative.uuid;
        newObj.aspect_id = final_rule_narrative.aspect.uuid;
      }

      this.form.final_rule_narratives.push(newObj);
    },

    removeFinalRuleNarrative(index) {
      this.form.final_rule_narratives.splice(index, 1);
    },
    submit() {
      this.$refs['assessmentFinalRule'].validate((valid) => {
        if (valid) {
          this.process = true;

          let requestPayload = JSON.parse(JSON.stringify(this.form));

          axios
            .post(route('school.teachingProgram.assessmentModule.assessmentFinalRule.save'), requestPayload, {
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
                  this.$refs['assessmentFinalRule'].validateField(field);
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
      <el-form v-if="loaded" ref="assessmentFinalRule" label-position="top" :model="form" :disabled="process">
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
          :label="field.use_score.label"
          :rules="field.use_score.rules"
          :error="field.use_score.error"
          prop="use_score"
        >
          <el-checkbox border v-model="form.use_score" :label="form.use_score ? 'Ya' : 'Tidak'" />
        </el-form-item>
        <el-form-item
          v-if="form.use_score"
          class="font-medium"
          :label="field.score_method.label"
          :rules="field.score_method.rules"
          :error="field.score_method.error"
          prop="score_method"
        >
          <el-select v-model="form.score_method" :placeholder="`Pilih ${field.score_method.label}`" clearable>
            <el-option
              v-for="option in field.score_method.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <div v-if="form.use_score == true && form.score_method">
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Skor Penilaian Aspek</h2>
          <div class="space-y-3">
            <div
              v-for="(final_rule_score, index) in form.final_rule_scores"
              :key="index"
              class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
            >
              <el-form-item class="font-medium" label="Penilaian Aspek">
                <el-select v-model="final_rule_score.aspect_id" placeholder="Pilih Penilaian Aspek" clearable>
                  <el-option
                    v-for="option in propertyModal.data.assessment_aspects"
                    :key="option.uuid"
                    :label="option.name"
                    :value="option.uuid"
                  />
                </el-select>
              </el-form-item>
              <el-form-item class="font-medium" label="Porsi Skor">
                <el-input type="number" v-model="final_rule_score.portion_score" autocomplete="off">
                  <template #append>
                    <div>%</div>
                  </template>
                </el-input>
              </el-form-item>
              <div class="flex items-center justify-end">
                <OutlineButton class="my-auto" type="red" @click="removeFinalRuleScore(index)">Hapus</OutlineButton>
              </div>
            </div>
          </div>
          <DefaultButton type="light" @click="addNewFinalRuleScore()" class="my-3"
            >Tambah Penilaian Aspek</DefaultButton
          >
        </div>
        <el-form-item
          class="font-medium"
          :label="field.use_predicate.label"
          :rules="field.use_predicate.rules"
          :error="field.use_predicate.error"
          prop="use_predicate"
        >
          <el-checkbox border v-model="form.use_predicate" :label="form.use_predicate ? 'Ya' : 'Tidak'" />
        </el-form-item>
        <el-form-item
          v-if="form.use_predicate"
          class="font-medium"
          :label="field.predicate_method.label"
          :rules="field.predicate_method.rules"
          :error="field.predicate_method.error"
          prop="predicate_method"
        >
          <el-select v-model="form.predicate_method" :placeholder="`Pilih ${field.predicate_method.label}`" clearable>
            <el-option
              v-for="option in field.predicate_method.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.use_narrative.label"
          :rules="field.use_narrative.rules"
          :error="field.use_narrative.error"
          prop="use_narrative"
        >
          <el-checkbox border v-model="form.use_narrative" :label="form.use_narrative ? 'Ya' : 'Tidak'" />
        </el-form-item>
        <el-form-item
          v-if="form.use_narrative"
          class="font-medium"
          :label="field.narrative_method.label"
          :rules="field.narrative_method.rules"
          :error="field.narrative_method.error"
          prop="narrative_method"
        >
          <el-select v-model="form.narrative_method" :placeholder="`Pilih ${field.narrative_method.label}`" clearable>
            <el-option
              v-for="option in field.narrative_method.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <div v-if="form.narrative_method == 'THRESHOLD_PLUS_LEARNING_OBJECTIVE'">
          <h2 class="mb-4 border-b pb-2 text-sm font-medium text-gray-900">Naratif Penilaian Aspek</h2>
          <div class="space-y-3">
            <div
              v-for="(final_rule_narrative, index) in form.final_rule_narratives"
              :key="index"
              class="grid rounded-2xl border px-4 py-3 md:grid-cols-1"
            >
              <el-form-item class="font-medium" label="Penilaian Aspek">
                <el-select v-model="final_rule_narrative.aspect_id" placeholder="Pilih Penilaian Aspek" clearable>
                  <el-option
                    v-for="option in propertyModal.data.assessment_aspects_using_lo"
                    :key="option.uuid"
                    :label="option.name"
                    :value="option.uuid"
                  />
                </el-select>
              </el-form-item>
              <div class="flex items-center justify-end">
                <OutlineButton class="my-auto" type="red" @click="removeFinalRuleNarrative(index)">Hapus</OutlineButton>
              </div>
            </div>
          </div>
          <DefaultButton type="light" @click="addNewFinalRuleNarrative()" class="my-3"
            >Tambah Penilaian Aspek</DefaultButton
          >
        </div>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Simpan </DefaultButton>
    </div>
  </div>
</template>
