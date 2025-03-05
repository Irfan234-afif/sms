<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
import { ElNotification } from 'element-plus';
defineEmits(['close']);
</script>
<script>
export default {
  props: {
    sectionTitle: {
      type: String,
      default: null,
    },
    jsonResult: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      actionRoute: route('school.student.import'),
      students: this.jsonResult,
    };
  },
  methods: {
    submit() {
      this.process = true;
      let requestPayload = { students: this.students };

      axios
        .post(this.actionRoute, requestPayload, {
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
          console.error(error);

          ElNotification({
            title: 'Error',
            message: 'Terjadi kesalahan.',
            type: 'error',
          });
        })
        .finally(() => {
          this.process = false;
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
    <div class="space-y-5 pb-2">
      <div class="w-full overflow-x-auto">
        <div style="height: 50rem" class="max-h-screen overflow-y-auto border border-gray-300 shadow-lg">
          <table class="min-w-full border-collapse text-left text-xs text-gray-500 dark:text-gray-400">
            <thead class="sticky top-0 z-50 bg-gray-50 text-xs text-gray-700 dark:bg-gray-700 dark:text-gray-400">
              <tr>
                <th class="p-4">Nama</th>
                <th class="p-4">Nomor Induk</th>
                <th class="p-4">Kelas</th>
                <th class="p-4">Tempat Lahir</th>
                <th class="p-4">Tanggal Lahir</th>
                <th class="p-4">Jenis Kelamin</th>
                <th class="p-4">Golongan Darah</th>
                <th class="p-4">Agama</th>
                <th class="p-4">Alamat</th>
                <th class="p-4">Kode Pos</th>
                <th class="p-4">Nama Ayah</th>
                <th class="p-4">NIK Ayah</th>
                <th class="p-4">Telepon Ayah</th>
                <th class="p-4">Email Ayah</th>
                <th class="p-4">Pekerjaan Ayah</th>
                <th class="p-4">Nama Ibu</th>
                <th class="p-4">NIK Ibu</th>
                <th class="p-4">Telepon Ibu</th>
                <th class="p-4">Email Ibu</th>
                <th class="p-4">Pekerjaan Ibu</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200 bg-white">
              <tr v-for="(data, index) in jsonResult" :key="index">
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.name"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.school_national_id"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.school_grade"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.birth_place"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.birth_date" type="date"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.gender"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.blood_type"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.religion"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.address"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.postal_code"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.father_name"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.father_national_id"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.father_phone"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.father_email" type="email"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.father_occupation"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.mother_name"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.mother_national_id"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.mother_phone"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.mother_email" type="email"></el-input>
                </td>
                <td class="whitespace-nowrap px-4 py-3">
                  <el-input style="width: 250px" disabled v-model="data.mother_occupation"></el-input>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Import Data </DefaultButton>
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
