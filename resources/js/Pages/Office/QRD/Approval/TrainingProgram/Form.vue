<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import fieldValidation from '@/Helpers/fieldValidation';
import axios from 'axios';
import { ElNotification } from 'element-plus';
import moment from 'moment';
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
      attachmentFiles: [],
      attachmentPreviews: [],
      actionRoute: route('office.qrd.approval.trainingProgram.store'),
      trainingPrograms: [],
      participants: [],
      form: {
        submission_id: null,
        datetime: moment().format('YYYY-MM-DD HH:mm:ss'),
        training_type: 'internal',
        training_program_id: null,
        external_training_title: null,
        external_training_provider: null,
        external_training_location: null,
        external_training_method: null,
        external_training_description: null,
        start_date: moment().format('YYYY-MM-DD'),
        end_date: moment().format('YYYY-MM-DD'),
        daily_start_time: '09:00',
        daily_end_time: '17:00',
        training_days: [],
        justification: null,
        expected_outcomes: null,
        goals: [
          {
            goal_type: 'knowledge',
            description: '',
            success_indicator: '',
            order: 1,
          },
        ],
        budget_items: [
          {
            category: 'venue',
            item_name: '',
            description: '',
            quantity: 1,
            unit_price: 0,
          },
        ],
        participants: [],
        attachments: [],
      },
      field: {
        datetime: {
          label: 'Tanggal Pengajuan',
          rules: [fieldValidation.isRequired('Tanggal Pengajuan')],
          error: null,
          disabled: true,
        },
        training_type: {
          label: 'Jenis Training',
          rules: [fieldValidation.isRequired('Jenis Training')],
          error: null,
        },
        training_program_id: {
          label: 'Program Training',
          rules: [],
          error: null,
        },
        external_training_title: {
          label: 'Judul Training External',
          rules: [],
          error: null,
        },
        external_training_provider: {
          label: 'Provider External',
          rules: [],
          error: null,
        },
        external_training_location: {
          label: 'Lokasi Training',
          rules: [],
          error: null,
        },
        external_training_method: {
          label: 'Metode Training',
          rules: [],
          error: null,
        },
        external_training_description: {
          label: 'Deskripsi Training',
          rules: [],
          error: null,
        },
        start_date: {
          label: 'Tanggal Mulai',
          rules: [fieldValidation.isRequired('Tanggal Mulai')],
          error: null,
        },
        end_date: {
          label: 'Tanggal Selesai',
          rules: [fieldValidation.isRequired('Tanggal Selesai')],
          error: null,
        },
        daily_start_time: {
          label: 'Waktu Mulai',
          rules: [fieldValidation.isRequired('Waktu Mulai')],
          error: null,
        },
        daily_end_time: {
          label: 'Waktu Selesai',
          rules: [fieldValidation.isRequired('Waktu Selesai')],
          error: null,
        },
        justification: {
          label: 'Justifikasi',
          rules: [],
          error: null,
        },
        expected_outcomes: {
          label: 'Hasil yang Diharapkan',
          rules: [],
          error: null,
        },
      },
    };
  },
  computed: {
    isInternal() {
      return this.form.training_type === 'internal';
    },
    isExternal() {
      return this.form.training_type === 'external';
    },
  },
  watch: {
    'form.training_type'() {
      // Reset related fields when training type changes
      if (this.isInternal) {
        this.form.external_training_title = null;
        this.form.external_training_provider = null;
        this.form.external_training_location = null;
        this.form.external_training_method = null;
        this.form.external_training_description = null;
      } else {
        this.form.training_program_id = null;
      }
    },
  },
  created() {
    this.loadTrainingPrograms();
    this.loadParticipants();
    
    if (this.propertyModal.mode == 'submission-edit-form') {
      this.setupEditMode();
    }
  },
  methods: {
    async loadTrainingPrograms() {
      try {
        const response = await axios.get(route('office.qrd.training-program-submission.options.training-programs'));
        this.trainingPrograms = response.data;
      } catch (error) {
        console.error('Error loading training programs:', error);
      }
    },
    async loadParticipants() {
      try {
        const response = await axios.get(route('office.qrd.training-program-submission.options.participants'));
        this.participants = response.data;
      } catch (error) {
        console.error('Error loading participants:', error);
      }
    },
    setupEditMode() {
      let submission = this.propertyModal.data.submission;
      this.actionRoute = route('office.qrd.approval.trainingProgram.update');

      const trainingProgram = submission.training_program_submission;
      if (trainingProgram) {
        this.form.submission_id = submission.uuid;
        this.form.datetime = submission.datetime;
        this.form.training_type = trainingProgram.training_type;
        this.form.training_program_id = trainingProgram.training_program_id;
        this.form.external_training_title = trainingProgram.external_training_title;
        this.form.external_training_provider = trainingProgram.external_training_provider;
        this.form.external_training_location = trainingProgram.external_training_location;
        this.form.external_training_method = trainingProgram.external_training_method;
        this.form.external_training_description = trainingProgram.external_training_description;
        this.form.start_date = trainingProgram.start_date;
        this.form.end_date = trainingProgram.end_date;
        this.form.daily_start_time = trainingProgram.daily_start_time;
        this.form.daily_end_time = trainingProgram.daily_end_time;
        this.form.training_days = trainingProgram.training_days || [];
        this.form.justification = trainingProgram.justification;
        this.form.expected_outcomes = trainingProgram.expected_outcomes;

        // Load goals
        if (trainingProgram.goals && trainingProgram.goals.length > 0) {
          this.form.goals = trainingProgram.goals.map(goal => ({
            goal_type: goal.goal_type,
            description: goal.description,
            success_indicator: goal.success_indicator,
            order: goal.order,
          }));
        }

        // Load budget items
        if (trainingProgram.budget_items && trainingProgram.budget_items.length > 0) {
          this.form.budget_items = trainingProgram.budget_items.map(item => ({
            category: item.category,
            item_name: item.item_name,
            description: item.description,
            quantity: item.quantity,
            unit_price: item.unit_price,
          }));
        }

        // Load participants
        if (trainingProgram.participants && trainingProgram.participants.length > 0) {
          this.form.participants = trainingProgram.participants.map(participant => ({
            profile_id: participant.profile_id,
            is_primary_participant: participant.is_primary_participant,
            role_description: participant.role_description,
            selection_reason: participant.selection_reason,
          }));
        }
      }
    },
    addGoal() {
      this.form.goals.push({
        goal_type: 'knowledge',
        description: '',
        success_indicator: '',
        order: this.form.goals.length + 1,
      });
    },
    removeGoal(index) {
      this.form.goals.splice(index, 1);
    },
    addBudgetItem() {
      this.form.budget_items.push({
        category: 'venue',
        item_name: '',
        description: '',
        quantity: 1,
        unit_price: 0,
      });
    },
    removeBudgetItem(index) {
      this.form.budget_items.splice(index, 1);
    },
    addParticipant() {
      this.form.participants.push({
        profile_id: null,
        is_primary_participant: false,
        role_description: '',
        selection_reason: '',
      });
    },
    removeParticipant(index) {
      this.form.participants.splice(index, 1);
    },
    handleAttachmentFileChange(files) {
      this.attachmentFiles = files;
      this.attachmentPreviews = [];
      
      files.forEach((file, index) => {
        if (file.type.startsWith('image/')) {
          const reader = new FileReader();
          reader.onload = (e) => {
            this.attachmentPreviews[index] = e.target.result;
          };
          reader.readAsDataURL(file);
        } else {
          this.attachmentPreviews[index] = null;
        }
      });
    },
    submit(status) {
      this.$refs['submissionForm'].validate((valid) => {
        if (valid) {
          this.process = true;
          let requestPayload = JSON.parse(JSON.stringify(this.form));

          const formData = new FormData();
          
          // Basic fields
          formData.append('submission_id', requestPayload.submission_id);
          formData.append('datetime', requestPayload.datetime);
          formData.append('training_type', requestPayload.training_type);
          formData.append('start_date', requestPayload.start_date);
          formData.append('end_date', requestPayload.end_date);
          formData.append('daily_start_time', requestPayload.daily_start_time);
          formData.append('daily_end_time', requestPayload.daily_end_time);
          formData.append('justification', requestPayload.justification || '');
          formData.append('expected_outcomes', requestPayload.expected_outcomes || '');
          formData.append('status', status);

          // Training type specific fields
          if (this.isInternal) {
            formData.append('training_program_id', requestPayload.training_program_id);
          } else {
            formData.append('external_training_title', requestPayload.external_training_title || '');
            formData.append('external_training_provider', requestPayload.external_training_provider || '');
            formData.append('external_training_location', requestPayload.external_training_location || '');
            formData.append('external_training_method', requestPayload.external_training_method || '');
            formData.append('external_training_description', requestPayload.external_training_description || '');
          }

          // Training days
          if (requestPayload.training_days && requestPayload.training_days.length > 0) {
            requestPayload.training_days.forEach((day, index) => {
              formData.append(`training_days[${index}]`, day);
            });
          }

          // Goals
          requestPayload.goals.forEach((goal, index) => {
            formData.append(`goals[${index}][goal_type]`, goal.goal_type);
            formData.append(`goals[${index}][description]`, goal.description);
            formData.append(`goals[${index}][success_indicator]`, goal.success_indicator);
            formData.append(`goals[${index}][order]`, goal.order);
          });

          // Budget items
          requestPayload.budget_items.forEach((item, index) => {
            formData.append(`budget_items[${index}][category]`, item.category);
            formData.append(`budget_items[${index}][item_name]`, item.item_name);
            formData.append(`budget_items[${index}][description]`, item.description || '');
            formData.append(`budget_items[${index}][quantity]`, item.quantity);
            formData.append(`budget_items[${index}][unit_price]`, item.unit_price);
          });

          // Participants
          requestPayload.participants.forEach((participant, index) => {
            formData.append(`participants[${index}][profile_id]`, participant.profile_id);
            formData.append(`participants[${index}][is_primary_participant]`, participant.is_primary_participant ? 1 : 0);
            formData.append(`participants[${index}][role_description]`, participant.role_description || '');
            formData.append(`participants[${index}][selection_reason]`, participant.selection_reason || '');
          });

          // Attachments
          this.attachmentFiles.forEach((file, index) => {
            formData.append(`attachment_files[${index}]`, file);
            formData.append(`attachment_types[${index}]`, this.form.attachments[index]?.attachment_type || 'other');
            formData.append(`attachment_descriptions[${index}]`, this.form.attachments[index]?.description || '');
          });

          axios
            .post(this.actionRoute, formData, {
              headers: { 'Content-Type': 'multipart/form-data' },
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
                  if (this.field[field]) {
                    this.field[field].error = error.response.data.errors[field][0];
                    this.$refs['submissionForm'].validateField(field);
                  }
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
      <el-form 
        v-if="loaded" 
        ref="submissionForm" 
        label-position="top" 
        :model="form" 
        :disabled="process"
        class="space-y-4"
      >
        <!-- Basic Information -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <el-form-item
            :label="field.datetime.label"
            :rules="field.datetime.rules"
            :error="field.datetime.error"
            prop="datetime"
          >
            <el-date-picker
              :disabled="field.datetime.disabled"
              v-model="form.datetime"
              type="datetime"
              format="DD-MM-YYYY HH:mm"
              value-format="YYYY-MM-DD HH:mm:ss"
              class="w-full"
            />
          </el-form-item>

          <el-form-item
            :label="field.training_type.label"
            :rules="field.training_type.rules"
            :error="field.training_type.error"
            prop="training_type"
          >
            <el-select v-model="form.training_type" class="w-full">
              <el-option label="Internal" value="internal" />
              <el-option label="External" value="external" />
            </el-select>
          </el-form-item>
        </div>

        <!-- Training Program Selection (Internal) -->
        <div v-if="isInternal">
          <el-form-item
            :label="field.training_program_id.label"
            :rules="field.training_program_id.rules"
            :error="field.training_program_id.error"
            prop="training_program_id"
          >
            <el-select 
              v-model="form.training_program_id" 
              filterable 
              remote
              placeholder="Pilih Program Training"
              class="w-full"
            >
              <el-option
                v-for="program in trainingPrograms"
                :key="program.value"
                :label="program.label"
                :value="program.value"
              />
            </el-select>
          </el-form-item>
        </div>

        <!-- External Training Information -->
        <div v-if="isExternal" class="space-y-4">
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <el-form-item
              :label="field.external_training_title.label"
              :rules="field.external_training_title.rules"
              :error="field.external_training_title.error"
              prop="external_training_title"
            >
              <el-input v-model="form.external_training_title" />
            </el-form-item>

            <el-form-item
              :label="field.external_training_provider.label"
              :rules="field.external_training_provider.rules"
              :error="field.external_training_provider.error"
              prop="external_training_provider"
            >
              <el-input v-model="form.external_training_provider" />
            </el-form-item>
          </div>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <el-form-item
              :label="field.external_training_location.label"
              :rules="field.external_training_location.rules"
              :error="field.external_training_location.error"
              prop="external_training_location"
            >
              <el-input v-model="form.external_training_location" />
            </el-form-item>

            <el-form-item
              :label="field.external_training_method.label"
              :rules="field.external_training_method.rules"
              :error="field.external_training_method.error"
              prop="external_training_method"
            >
              <el-select v-model="form.external_training_method" class="w-full">
                <el-option label="Online" value="online" />
                <el-option label="Offline" value="offline" />
                <el-option label="Hybrid" value="hybrid" />
              </el-select>
            </el-form-item>
          </div>

          <el-form-item
            :label="field.external_training_description.label"
            :rules="field.external_training_description.rules"
            :error="field.external_training_description.error"
            prop="external_training_description"
          >
            <el-input 
              v-model="form.external_training_description" 
              type="textarea" 
              :rows="3"
            />
          </el-form-item>
        </div>

        <!-- Schedule Information -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <el-form-item
            :label="field.start_date.label"
            :rules="field.start_date.rules"
            :error="field.start_date.error"
            prop="start_date"
          >
            <el-date-picker
              v-model="form.start_date"
              type="date"
              format="DD-MM-YYYY"
              value-format="YYYY-MM-DD"
              class="w-full"
            />
          </el-form-item>

          <el-form-item
            :label="field.end_date.label"
            :rules="field.end_date.rules"
            :error="field.end_date.error"
            prop="end_date"
          >
            <el-date-picker
              v-model="form.end_date"
              type="date"
              format="DD-MM-YYYY"
              value-format="YYYY-MM-DD"
              class="w-full"
            />
          </el-form-item>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <el-form-item
            :label="field.daily_start_time.label"
            :rules="field.daily_start_time.rules"
            :error="field.daily_start_time.error"
            prop="daily_start_time"
          >
            <el-time-picker
              v-model="form.daily_start_time"
              format="HH:mm"
              value-format="HH:mm"
              class="w-full"
            />
          </el-form-item>

          <el-form-item
            :label="field.daily_end_time.label"
            :rules="field.daily_end_time.rules"
            :error="field.daily_end_time.error"
            prop="daily_end_time"
          >
            <el-time-picker
              v-model="form.daily_end_time"
              format="HH:mm"
              value-format="HH:mm"
              class="w-full"
            />
          </el-form-item>
        </div>

        <!-- Justification & Expected Outcomes -->
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <el-form-item
            :label="field.justification.label"
            :rules="field.justification.rules"
            :error="field.justification.error"
            prop="justification"
          >
            <el-input 
              v-model="form.justification" 
              type="textarea" 
              :rows="3"
            />
          </el-form-item>

          <el-form-item
            :label="field.expected_outcomes.label"
            :rules="field.expected_outcomes.rules"
            :error="field.expected_outcomes.error"
            prop="expected_outcomes"
          >
            <el-input 
              v-model="form.expected_outcomes" 
              type="textarea" 
              :rows="3"
            />
          </el-form-item>
        </div>

        <!-- Participants -->
        <div class="border-t pt-4">
          <div class="flex justify-between items-center mb-3">
            <h3 class="text-sm font-medium text-gray-900">Peserta Training</h3>
            <el-button type="primary" size="small" @click="addParticipant">
              Tambah Peserta
            </el-button>
          </div>
          
          <div v-for="(participant, index) in form.participants" :key="index" class="mb-4 p-4 bg-gray-50 rounded">
            <div class="flex justify-between items-start mb-3">
              <h4 class="text-sm font-medium text-gray-700">Peserta {{ index + 1 }}</h4>
              <el-button 
                type="danger" 
                size="small" 
                @click="removeParticipant(index)"
                v-if="form.participants.length > 1"
              >
                Hapus
              </el-button>
            </div>
            
            <div class="grid grid-cols-1 md:grid-cols-2 gap-3">
              <el-form-item label="Nama Peserta" :prop="`participants.${index}.profile_id`">
                <el-select 
                  v-model="participant.profile_id" 
                  filterable 
                  remote
                  placeholder="Pilih Peserta"
                  class="w-full"
                >
                  <el-option
                    v-for="person in participants"
                    :key="person.value"
                    :label="person.label"
                    :value="person.value"
                  />
                </el-select>
              </el-form-item>

              <el-form-item label="Peran">
                <el-input v-model="participant.role_description" placeholder="Deskripsi peran" />
              </el-form-item>
            </div>

            <div class="grid grid-cols-1 gap-3">
              <el-form-item label="Alasan Pemilihan">
                <el-input 
                  v-model="participant.selection_reason" 
                  type="textarea" 
                  :rows="2"
                  placeholder="Alasan mengapa peserta ini dipilih"
                />
              </el-form-item>

              <el-form-item>
                <el-checkbox v-model="participant.is_primary_participant">
                  Peserta Utama
                </el-checkbox>
              </el-form-item>
            </div>
          </div>
        </div>
      </el-form>
    </div>

    <!-- Action Buttons -->
    <div class="flex justify-end space-x-3 border-t pt-4">
      <DefaultButton type="secondary" @click="close" :disabled="process">
        Batal
      </DefaultButton>
      <DefaultButton @click="submit('draft')" :disabled="process" v-if="propertyModal.mode === 'submission-create-form'">
        <div class="flex items-center space-x-2">
          <div v-if="process" class="spinner h-4 w-4"></div>
          <span>Simpan Draft</span>
        </div>
      </DefaultButton>
      <DefaultButton @click="submit('pending')" :disabled="process">
        <div class="flex items-center space-x-2">
          <div v-if="process" class="spinner h-4 w-4"></div>
          <span>{{ propertyModal.mode === 'submission-edit-form' ? 'Update' : 'Submit' }}</span>
        </div>
      </DefaultButton>
    </div>
  </div>
</template>

<style scoped>
.spinner {
  border: 2px solid #f3f3f3;
  border-top: 2px solid #3498db;
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style> 