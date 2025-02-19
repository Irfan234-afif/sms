<script setup>
import { computed, onMounted, onUnmounted, watch } from 'vue';

const props = defineProps({
    show: {
        type: Boolean,
        default: false,
    },
    property: {
        type: Object,
        default() {
            return { title: null, mode: null, maxWidth: '2xl', data: null };
        },
    },
    closeable: {
        type: Boolean,
        default: true,
    },
});

const emit = defineEmits(['close']);

watch(
    () => props.show,
    () => {
        if (props.show) {
            document.body.style.overflow = 'hidden';
        } else {
            document.body.style.overflow = null;
        }
    },
);

const close = () => {
    if (props.closeable) {
        emit('close');
    }
};

const closeOnEscape = (e) => {
    if (e.key === 'Escape' && props.show) {
        close();
    }
};

onMounted(() => document.addEventListener('keydown', closeOnEscape));

onUnmounted(() => {
    document.removeEventListener('keydown', closeOnEscape);
    document.body.style.overflow = null;
});

const maxWidthClass = computed(() => {
    return {
        sm: 'sm:max-w-sm',
        md: 'sm:max-w-md',
        lg: 'sm:max-w-lg',
        xl: 'sm:max-w-xl',
        '2xl': 'sm:max-w-2xl',
        '3xl': 'sm:max-w-3xl',
        '4xl': 'sm:max-w-4xl',
        '5xl': 'sm:max-w-5xl',
        '6xl': 'sm:max-w-6xl',
        '7xl': 'sm:max-w-7xl',
        '8xl': 'sm:max-w-8xl',
        '9xl': 'sm:max-w-9xl',
        '10xl': 'sm:max-w-10xl',
        '11xl': 'sm:max-w-11xl',
    }[props.property.maxWidth];
});
</script>

<template>
    <transition leave-active-class="duration-75">
        <div
            v-show="show"
            class="fixed inset-0 z-50 flex overflow-y-auto px-4 py-6 sm:px-0"
            scroll-region
        >
            <transition
                enter-active-class="ease-out duration-75"
                enter-from-class="opacity-0"
                enter-to-class="opacity-100"
                leave-active-class="ease-in duration-75"
                leave-from-class="opacity-100"
                leave-to-class="opacity-0"
            >
                <div
                    v-show="show"
                    class="fixed inset-0 transform transition-all"
                    @click="close"
                >
                    <div class="absolute inset-0 bg-gray-900 opacity-50" />
                </div>
            </transition>

            <transition
                enter-active-class="ease-out duration-75"
                enter-from-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
                enter-to-class="opacity-100 translate-y-0 sm:scale-100"
                leave-active-class="ease-in duration-75"
                leave-from-class="opacity-100 translate-y-0 sm:scale-100"
                leave-to-class="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            >
                <div
                    v-show="show"
                    class="my-auto w-full transform overflow-hidden rounded-lg bg-white shadow-xl transition-all sm:mx-auto"
                    :class="maxWidthClass"
                >
                    <slot v-if="show" :propertyModal="property" />
                </div>
            </transition>
        </div>
    </transition>
</template>
