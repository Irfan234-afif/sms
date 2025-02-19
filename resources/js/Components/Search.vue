<script>
export default {
    props: {
        search_params: Object,
    },

    data() {
        return {
            url: new URL(document.URL),
            form: this.$inertia.form({
                search: this.search_params?.search,
            }),
        };
    },

    methods: {
        submit() {
            this.form.get(this.url.pathname, { preserveScroll: true });
        },
    },
};
</script>

<template>
    <div>
        <el-input
            v-model="form.search"
            v-on:keyup.enter="submit"
            placeholder="Cari"
        >
            <template #prefix>
                <svg
                    xmlns="http://www.w3.org/2000/svg"
                    class="h-4 w-4"
                    viewBox="0 0 24 24"
                    stroke-width="2"
                    stroke="currentColor"
                    fill="none"
                    stroke-linecap="round"
                    stroke-linejoin="round"
                >
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                    <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0"></path>
                    <path d="M21 21l-6 -6"></path>
                </svg>
            </template>
        </el-input>
    </div>
</template>
