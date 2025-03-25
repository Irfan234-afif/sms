<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import AcademicProgramForm from './AcademicProgram/Form.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import DeleteConfirm from '@/Components/DeleteConfirm.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kurikulum', href: route('school.setting.profile') },
  { label: 'Lihat', href: '#' },
];
</script>

<script>
export default {
  props: {
    school: Object,
    school_academic_programs: Object,
  },
  data() {
    return {
      showModal: false,
      propertyModal: {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      },
    };
  },
  methods: {
    openModal(property) {
      this.showModal = true;
      this.propertyModal = property;
    },
    closeModal() {
      this.showModal = false;
      this.propertyModal = {
        title: null,
        mode: null,
        maxWidth: null,
        data: null,
      };
    },
  },
};
</script>

<template>
  <Head title="Sekolah" />

  <SchoolLayout>
    <template #header>
      <Breadcrumb :breadcrumbs="breadcrumbs" />
    </template>
    <template #sidebar>
      <SchoolSidebar />
    </template>
    <template #content>
      <section class="bg-white p-4 antialiased dark:bg-gray-900 md:p-6">
        <div class="px-4 2xl:px-0">
          <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-2">
            {{ school.data.area.name }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Telepon</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school.data.area.phone ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Email</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school.data.area.email ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Hotline</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school.data.area.hotline ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Alamat</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school.data.area.address ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
          <div
            class="mt-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="flex items-center justify-between border-b pb-4">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Kelola Program Akademi</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Program Akademi Baru',
                    mode: 'academic-program-create-form',
                    maxWidth: '2xl',
                    data: {},
                  })
                "
              >
                Program Akademi Baru
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li
                  v-for="(school_academic_program, index) in school_academic_programs.data"
                  :key="index"
                  class="py-3 sm:py-4"
                >
                  <div class="flex items-center space-x-2">
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ school_academic_program.name }}
                      </p>
                      <div class="mt-1 flex items-center space-x-2 truncate text-xs text-gray-500 dark:text-gray-400">
                        <div>
                          {{ school_academic_program.code }}
                        </div>
                      </div>
                    </div>
                    <OutlineButton
                      type="default"
                      @click="
                        openModal({
                          title: 'Sunting Program Akademi',
                          mode: 'academic-program-edit-form',
                          maxWidth: '2xl',
                          data: {
                            school_academic_program: school_academic_program,
                          },
                        })
                      "
                    >
                      Sunting
                    </OutlineButton>
                    <OutlineButton
                      type="red"
                      @click="
                        openModal({
                          title: 'Hapus Program Akademi',
                          mode: 'academic-program-delete-confirm',
                          maxWidth: 'md',
                          data: {
                            actionUrl: route('school.setting.profile.academicProgram.delete', {
                              school_academic_program_id: school_academic_program.uuid,
                            }),
                            redirectUrl: route('school.setting.profile'),
                            message:
                              'Ingin menghapus Program Akademi? Tindakan ini akan memengaruhi data terkait serta penilaian ke depannya. Apakah Anda yakin ingin melanjutkan?',
                          },
                        })
                      "
                    >
                      Hapus
                    </OutlineButton>
                  </div>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <Modal :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <AcademicProgramForm
            v-if="
              propertyModal?.mode == 'academic-program-create-form' ||
              propertyModal?.mode == 'academic-program-edit-form'
            "
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <DeleteConfirm
            v-if="propertyModal?.mode == 'academic-program-delete-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
