<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
defineEmits(['success', 'close']);
</script>
<script>
import { ElNotification } from 'element-plus';

export default {
  props: {
    sectionTitle: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      process: false,
      jsonResult: null,
      requiredHeaders: [
        'NAME',
        'SCHOOL_NATIONAL_ID',
        'SCHOOL_GRADE',
        'BIRTH_PLACE',
        'BIRTH_DATE',
        'GENDER',
        'BLOOD_TYPE',
        'RELIGION',
        'ADDRESS',
        'POSTAL_CODE',
        'FATHER_NAME',
        'FATHER_NATIONAL_ID',
        'FATHER_PHONE',
        'FATHER_EMAIL',
        'FATHER_OCCUPATION',
        'MOTHER_NAME',
        'MOTHER_NATIONAL_ID',
        'MOTHER_PHONE',
        'MOTHER_EMAIL',
        'MOTHER_OCCUPATION',
      ],
    };
  },
  methods: {
    handleFileUpload(event) {
      const file = event.target.files[0];
      if (!file) return;

      if (file.type !== 'text/csv') {
        this.showNotification('Hanya file CSV yang diperbolehkan!', 'error');
        return;
      }

      this.process = true;

      const reader = new FileReader();
      reader.onload = (e) => {
        const text = e.target.result;

        if (!this.validateCSV(text)) {
          this.process = false;
          return;
        }

        this.jsonResult = this.csvToJson(text);
        if (this.jsonResult) {
          this.$emit('success', {
            jsonResult: this.jsonResult,
          });
        }
        this.process = false;
      };
      reader.readAsText(file);
    },
    validateCSV(csv) {
      const lines = csv.split('\n').map((line) => line.trim());
      if (lines.length < 2) {
        this.showNotification('File CSV harus memiliki header dan minimal satu baris data.', 'warning');
        return false;
      }

      const firstLine = lines[0];
      if (!firstLine.includes(',')) {
        this.showNotification('Format CSV tidak valid! Gunakan koma (,) sebagai pemisah.', 'error');
        return false;
      }

      const headers = firstLine.split(',').map((header) => header.trim());

      const missingHeaders = this.requiredHeaders.filter((h) => !headers.includes(h));
      if (missingHeaders.length > 0) {
        this.showNotification(
          `Header CSV tidak valid! Pastikan memiliki header: ${missingHeaders.join(', ')}`,
          'error',
        );
        return false;
      }

      return true;
    },
    csvToJson(csv) {
      const lines = csv.split('\n').map((line) => line.trim());
      const headers = lines[0].split(',').map((header) => header.trim().toLowerCase()); // Ubah header menjadi lowercase
      const result = [];

      for (let i = 1; i < lines.length; i++) {
        const currentLine = lines[i].split(',').map((value) => value.trim());

        if (currentLine.every((value) => value === '')) {
          continue;
        }

        const obj = {};
        headers.forEach((header, index) => {
          obj[header] = currentLine[index] || '';
        });

        result.push(obj);
      }
      return result;
    },
    showNotification(message, type) {
      ElNotification({
        title: type === 'success' ? 'Berhasil' : type === 'warning' ? 'Peringatan' : 'Kesalahan',
        message,
        type,
        duration: 3000,
      });
    },
    close() {
      this.$emit('close');
    },
  },
};
</script>

<template>
  <div class="space-y-6 p-5" :class="{ 'opacity-20': process }">
    <h2 class="mb-2 border-b pb-2 text-base font-medium text-gray-900">{{ sectionTitle }}</h2>
    <div class="space-y-5 px-2 pb-2">
      <div class="flex w-full items-center justify-center">
        <label
          for="import-dropzone-file"
          class="flex h-64 w-full cursor-pointer flex-col items-center justify-center rounded-lg border-2 border-dashed border-gray-300 bg-gray-50 hover:bg-gray-100"
        >
          <div class="flex flex-col items-center justify-center pb-6 pt-5">
            <p class="mb-2 text-sm text-gray-500">
              <span class="font-semibold">Unggah File CSV</span>
            </p>
            <p class="text-xs text-gray-500">Hanya mendukung format CSV (Maks. 250KB)</p>
          </div>
          <input id="import-dropzone-file" type="file" accept=".csv" class="hidden" @change="handleFileUpload" />
        </label>
      </div>
      <div
        class="mb-4 flex items-center rounded-lg bg-blue-50 p-4 text-blue-800 dark:bg-gray-800 dark:text-blue-400"
        role="alert"
      >
        <svg
          class="h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 1 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <div class="ms-3 text-sm font-medium">
          Sebelum mengimpor data siswa, pastikan Anda menggunakan format yang benar. Silakan
          <a :href="route('school.student.downloadImportTemplate')" class="font-semibold underline hover:no-underline"
            >unduh template import siswa</a
          >
          untuk memastikan data sesuai standar sistem.
        </div>
      </div>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
    </div>
  </div>
  <div v-if="process" role="status" class="absolute left-1/2 top-2/4 -translate-x-1/2 -translate-y-1/2">
    <svg
      aria-hidden="true"
      class="h-10 w-10 animate-spin fill-blue-600 text-gray-200"
      viewBox="0 0 100 101"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M100 50.5908C100 78.2051 77.6142 100.591 50 100.591C22.3858 100.591 0 78.2051 0 50.5908C0 22.9766 22.3858 0.59082 50 0.59082C77.6142 0.59082 100 22.9766 100 50.5908ZM9.08144 50.5908C9.08144 73.1895 27.4013 91.5094 50 91.5094C72.5987 91.5094 90.9186 73.1895 90.9186 50.5908C90.9186 27.9921 72.5987 9.67226 50 9.67226C27.4013 9.67226 9.08144 27.9921 9.08144 50.5908Z"
        fill="currentColor"
      />
    </svg>
    <span class="sr-only">Loading...</span>
  </div>
</template>
