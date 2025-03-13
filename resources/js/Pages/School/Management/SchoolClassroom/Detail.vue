<script setup>
import SchoolLayout from '@/Layouts/SchoolLayout.vue';
import SchoolSidebar from '@/Layouts/Sidebars/SchoolSidebar.vue';
import { Head } from '@inertiajs/vue3';
import Modal from '@/Components/Modal.vue';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import DefaultButton from '@/Components/DefaultButton.vue';
import AssignMemberForm from './AssignMemberForm.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import RemoveMemberConfirm from './RemoveMemberConfirm.vue';
const breadcrumbs = [
  { label: 'Sekolah', href: route('school') },
  { label: 'Kelas', href: route('school.management.schoolClassroom') },
  { label: 'Lihat', href: '#' },
];
</script>

<script>
export default {
  props: {
    school_classroom: Object,
    members: Object,
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
          <!--  -->
          <h1 class="text-base font-medium text-gray-900 dark:text-white md:pb-2">
            {{ school_classroom.data.title }}
          </h1>
          <div class="grid gap-4 pb-2 sm:gap-8 md:grid-cols-2 md:pb-4">
            <div class="grid gap-4 sm:grid-cols-2 sm:gap-8 lg:gap-12">
              <div class="space-y-4">
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Tingkat Kelas</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.grade.title }}
                  </dd>
                </dl>
                <dl v-if="school_classroom.data.major">
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Jurusan</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.major?.title ?? '-' }}
                  </dd>
                </dl>
                <dl>
                  <dt class="text-xs font-medium text-gray-800 dark:text-white">Wali Kelas</dt>
                  <dd class="text-xs text-gray-500 dark:text-gray-400">
                    {{ school_classroom.data.homeroom_teacher?.profile?.name ?? '-' }}
                  </dd>
                </dl>
              </div>
            </div>
          </div>
          <hr />
          <div
            class="mt-4 w-full max-w-lg rounded-lg border border-gray-200 bg-white p-4 shadow-sm dark:border-gray-700 dark:bg-gray-800 sm:p-4"
          >
            <div class="mb-4 flex items-center justify-between">
              <h5 class="text-base font-medium leading-none text-gray-900 dark:text-white">Anggota</h5>
              <DefaultButton
                type="default"
                @click="
                  openModal({
                    title: 'Anggota Baru',
                    mode: 'assign-member-form',
                    maxWidth: 'md',
                    data: {
                      school_classroom: school_classroom.data,
                    },
                  })
                "
              >
                Tambah Anggota
              </DefaultButton>
            </div>
            <div class="flow-root">
              <ul role="list" class="divide-y divide-gray-200 dark:divide-gray-700">
                <li v-for="(member, index) in members.data" :key="index" class="py-3 sm:py-4">
                  <div class="flex items-center">
                    <div class="shrink-0">
                      <img
                        v-if="member.profile.avatar_path"
                        :src="member.profile.avatar_path"
                        class="h-8 w-8 rounded-lg object-cover"
                      />
                      <div v-else class="flex h-8 w-8 items-center justify-center rounded-lg bg-gray-100">
                        <svg
                          class="h-6 w-6 text-gray-500"
                          fill="none"
                          stroke="currentColor"
                          stroke-width="1.5"
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          viewBox="0 0 24 24"
                        >
                          <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                          <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                          <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
                        </svg>
                      </div>
                    </div>
                    <div class="ms-4 min-w-0 flex-1">
                      <p class="truncate text-xs font-medium text-gray-900 dark:text-white">
                        {{ member.profile.name }}
                      </p>
                      <p class="truncate text-xs text-gray-500 dark:text-gray-400">{{ member.school_national_id }}</p>
                    </div>
                    <OutlineButton
                      type="red"
                      @click="
                        openModal({
                          title: `Hapus ${member.profile.name}`,
                          mode: 'remove-member-confirm',
                          maxWidth: 'sm',
                          data: {
                            description: `Hapus ${member.profile.name}?`,
                            actionUrl: route('school.management.schoolClassroom.removeMember', {
                              school_classroom_member_id: member.pivot.uuid,
                            }),
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
          <AssignMemberForm
            v-if="propertyModal?.mode == 'assign-member-form'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
          <RemoveMemberConfirm
            v-if="propertyModal?.mode == 'remove-member-confirm'"
            :propertyModal="propertyModal"
            @close="closeModal()"
          />
        </template>
      </Modal>
    </template>
  </SchoolLayout>
</template>
