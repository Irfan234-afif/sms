<script>
import { initFlowbite } from 'flowbite';
import PublicLayout from '@/Layouts/PublicLayout.vue';
import ImagePreview from '@/Components/ImagePreview.vue';
import ImageView from './ImageView.vue';
export default {
  mounted() {
    initFlowbite();
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
<script setup>
import { Head } from '@inertiajs/vue3';

defineProps({
  canLogin: {
    type: Boolean,
  },
  canRegister: {
    type: Boolean,
  },
  galleries: {
    type: Object,
  },
});
</script>

<template>
  <Head title="Home" />

  <PublicLayout>
    <div class="min-h-screen">
      <section class="relative flex bg-[url('/assets/pages/jumbotron.jpg')] bg-cover bg-fixed bg-no-repeat">
        <div class="absolute inset-0 bg-gradient-to-b from-blue-300 to-white opacity-70"></div>
        <div class="z-10 mx-auto max-w-screen-xl px-4 py-8 text-center lg:py-32">
          <h1
            class="mb-4 text-xl font-extrabold uppercase leading-none tracking-tight text-white dark:text-white md:mb-6 md:text-2xl lg:text-3xl"
          >
            Galeri
          </h1>
        </div>
      </section>
      <section class="bg-white">
        <div class="mx-auto max-w-7xl px-4 py-8 lg:py-16">
          <div class="mx-auto max-w-6xl">
            <div class="grid grid-cols-2 gap-4 md:grid-cols-3">
              <div v-for="(gallery, index) in galleries.data" :key="index">
                <button
                  type="button"
                  @click="
                    openModal({
                      mode: 'image-view',
                      maxWidth: '7xl',
                      data: {
                        items: gallery.items,
                      },
                    })
                  "
                >
                  <img class="h-64 w-full max-w-full rounded-2xl object-cover" :src="gallery.thumbnail_path" alt="" />
                  <div class="p-2">
                    <div class="text-center text-lg text-gray-800">
                      {{ gallery.title }}
                    </div>
                  </div>
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>
      <!-- modal -->
      <ImagePreview :show="showModal" :property="propertyModal" :maxWidth="propertyModal?.maxWidth" @close="closeModal">
        <template v-slot="{ propertyModal }">
          <ImageView v-if="propertyModal?.mode == 'image-view'" :propertyModal="propertyModal" @close="closeModal()" />
        </template>
      </ImagePreview>
    </div>
  </PublicLayout>
</template>
