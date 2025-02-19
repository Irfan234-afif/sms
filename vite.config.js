import vue from '@vitejs/plugin-vue';
import laravel from 'laravel-vite-plugin';
import { defineConfig } from 'vite';

export default defineConfig({
    plugins: [
        laravel({
            input: 'resources/js/app.js',
            refresh: true,
        }),
        vue({
            template: {
                transformAssetUrls: {
                    base: null,
                    includeAbsolute: false,
                },
            },
        }),
    ],
    // optimizeDeps: {
    //     include: ['@ckeditor/ckeditor5-build-classic'],
    // },
    // build: {
    //     commonjsOptions: {
    //         include: [/ckeditor5/],
    //     },
    //     rollupOptions: {
    //         output: {
    //             manualChunks: {
    //                 ckeditor: ['@ckeditor/ckeditor5-build-classic'],
    //             },
    //         },
    //     },
    // },
});
