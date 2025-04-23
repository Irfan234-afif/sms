<script setup>
import DefaultButton from '@/Components/DefaultButton.vue';
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
      url: new URL(document.URL),
      process: false,
      loaded: true,
      form: {
        date_range: null,
        area_id: null,
        status: null,
        take: 15,
      },
      field: {
        date_range: {
          label: 'Rentang Tanggal',
          rules: [],
          error: null,
        },
        area_id: {
          label: 'Area',
          rules: [],
          error: null,
          options: [],
        },
        status: {
          label: 'Status',
          rules: [],
          error: null,
          options: [
            {
              label: 'Menunggu',
              value: 'PENDING',
            },
            {
              label: 'Ditolak',
              value: 'REJECTED',
            },
            {
              label: 'Disetujui',
              value: 'APPROVED',
            },
          ],
          disabled: false,
          loading: false,
        },
        take: {
          label: 'Jumlah Data',
          rules: [],
          error: null,
        },
      },
    };
  },
  created() {
    if (this.propertyModal.data.searchParams) {
      let searchParams = this.propertyModal.data.searchParams;

      if (searchParams.from_date && searchParams.to_date) {
        this.form.date_range = [searchParams.from_date, searchParams.to_date];
      }

      if (searchParams.take) {
        this.form.take = searchParams.take;
      }

      if (searchParams.area) {
        this.form.area_id = searchParams.area;
      }

      if (searchParams.status) {
        this.form.status = searchParams.status;
      }
    }
  },
  methods: {
    optionArea(search) {
      this.field.area_id.loading = true;
      axios
        .get(
          route('ajax.option.area', {
            search: search,
          }),
        )
        .then((response) => {
          this.field.area_id.options = response.data;
          this.field.area_id.loading = false;
        })
        .catch((error) => {
          console.log(error);
          this.field.area_id.loading = false;
        });
    },
    submit() {
      let params = this.form;
      params.area_id = params.area_id?.uuid;

      if (params.date_range != null) {
        params.from_date = params.date_range[0];
        params.to_date = params.date_range[1];
        delete params['date_range'];
      }

      for (var key in params) {
        if (params[key] === null || params[key] === undefined || params[key] === '') {
          delete params[key];
        }
      }

      this.close();
      setTimeout(() => {
        this.$inertia.form(params).get(this.url.pathname, { preserveScroll: true });
      }, 1000);
    },
    close() {
      this.$emit('close');
    },
    reset() {
      this.form = {
        date_range: null,
        status: null,
      };
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
      <el-form v-if="loaded" ref="filterSearch" label-position="top" :model="form" :disabled="process">
        <el-form-item
          class="font-medium"
          :label="field.date_range.label"
          :rules="field.date_range.rules"
          :error="field.date_range.error"
          prop="date_range"
        >
          <el-date-picker
            v-model="form.date_range"
            type="daterange"
            range-separator="To"
            start-placeholder="-"
            end-placeholder="-"
            format="DD-MM-YYYY"
            value-format="YYYY-MM-DD"
          />
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.area_id.label"
          :rules="field.area_id.rules"
          :error="field.area_id.error"
          prop="area_id"
        >
          <el-select
            v-model="form.area_id"
            :placeholder="`Pilih ${field.area_id.label}`"
            loading-text="..."
            no-match-text="Data tidak ditemukan"
            no-data-text="Tidak ada data"
            :disabled="field.area_id.disabled"
            :remote-method="optionArea"
            value-key="uuid"
            remote
            filterable
            reserve-keyword
            clearable
            autocomplete="off"
          >
            <el-option
              v-for="option in field.area_id.options"
              :key="option.uuid"
              :label="option.name"
              :value="option"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.status.label"
          :rules="field.status.rules"
          :error="field.status.error"
          prop="status"
        >
          <el-select
            v-model="form.status"
            :placeholder="`Pilih ${field.status.label}`"
            :disabled="field.status.disabled"
            clearable
          >
            <el-option
              v-for="option in field.status.options"
              :key="option.value"
              :label="option.label"
              :value="option.value"
            />
          </el-select>
        </el-form-item>
        <el-form-item
          class="font-medium"
          :label="field.take.label"
          :rules="field.take.rules"
          :error="field.take.error"
          prop="take"
        >
          <el-input-number :min="15" :max="50" v-model="form.take" autocomplete="off" />
        </el-form-item>
      </el-form>
    </div>
    <div class="flex justify-end space-x-3">
      <DefaultButton type="light" @click="reset" :disabled="process"> Reset </DefaultButton>
      <DefaultButton type="light" @click="close" :disabled="process"> Batal </DefaultButton>
      <DefaultButton type="default" @click="submit" :disabled="process"> Terapkan </DefaultButton>
    </div>
  </div>
</template>
