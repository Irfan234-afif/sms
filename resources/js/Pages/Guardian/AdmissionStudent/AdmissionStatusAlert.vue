<script>
export default {
  props: {
    status: String,
  },
};
</script>

<template>
  <!-- alert -->
  <div>
    <!-- PENDING -->
    <div
      v-if="status == 'PENDING'"
      id="alert-verified"
      class="mb-4 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-800 dark:border-yellow-800 dark:bg-gray-800 dark:text-yellow-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Pendaftaran sedang diproses</h3>
      </div>
      <div class="mt-2 text-xs">
        Pendaftaran Anda sedang diproses. Harap tunggu, kami akan menginformasikan hasilnya segera.
      </div>
    </div>
    <!-- VERIFIED -->
    <div
      v-if="status == 'VERIFIED'"
      id="alert-verified"
      class="mb-4 rounded-lg border border-purple-300 bg-purple-50 p-4 text-purple-800 dark:border-purple-800 dark:bg-gray-800 dark:text-purple-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Pendaftaran telah diverifikasi</h3>
      </div>
      <div class="mt-2 text-xs">
        Selamat! Pendaftaran Anda telah berhasil diverifikasi. Silakan atur jadwal pertemuan atau interview sesuai
        ketersediaan Anda dan konfirmasi segera. Kami menantikan kehadiran Anda!
      </div>
    </div>
    <!-- UNVERIFIED -->
    <div
      v-if="status == 'UNVERIFIED'"
      id="alert-unverified"
      class="mb-4 rounded-lg border border-red-300 bg-red-50 p-4 text-red-800 dark:border-red-800 dark:bg-gray-800 dark:text-red-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Pendaftaran telah ditolak</h3>
      </div>
      <div class="mt-2 text-xs">
        Maaf, pendaftaran Anda tidak dapat diproses karena data tidak valid. Pastikan formulir terisi lengkap dan berkas
        sesuai ketentuan. Silakan periksa kembali, coba lagi, atau hubungi kami untuk bantuan.
      </div>
    </div>
    <!-- ACCEPTED -->
    <div
      v-if="status == 'ACCEPTED'"
      id="alert-accepted"
      class="mb-4 rounded-lg border border-green-300 bg-green-50 p-4 text-green-800 dark:border-green-800 dark:bg-gray-800 dark:text-green-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Selamat, {{ name ?? '-' }} diterima sebagai Siswa</h3>
      </div>
      <div class="mt-2 text-xs">
        Selamat! Pendaftaran Anda telah berhasil diterima. Silakan lanjutkan proses pembayaran sekolah untuk
        menyelesaikan tahap berikutnya. Jika membutuhkan bantuan, jangan ragu untuk menghubungi kami.
      </div>
    </div>
    <!-- REJECTED -->
    <div
      v-if="status == 'REJECTED'"
      id="alert-rejected"
      class="mb-4 rounded-lg border border-red-300 bg-red-50 p-4 text-red-800 dark:border-red-800 dark:bg-gray-800 dark:text-red-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Mohon maaf, pendaftar tidak diterima sebagai Siswa</h3>
      </div>
      <div class="mt-2 text-xs">
        Kami menghargai usaha Anda dalam mengikuti proses pendaftaran. Sayangnya, pendaftaran Anda belum dapat kami
        terima untuk saat ini. Jangan berkecil hati, Anda dapat mencoba kembali di kesempatan berikutnya. Jika memiliki
        pertanyaan lebih lanjut, jangan ragu untuk menghubungi kami.
      </div>
    </div>
    <!-- ENROLLED -->
    <div
      v-if="status == 'ENROLLED'"
      id="alert-accepted"
      class="mb-4 rounded-lg border border-green-300 bg-green-50 p-4 text-green-800 dark:border-green-800 dark:bg-gray-800 dark:text-green-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Pendaftaran telah selesai</h3>
      </div>
      <div class="mt-2 text-xs">
        Terima kasih telah mendaftar! Jika diperlukan, silakan hubungi kami untuk informasi lebih lanjut.
      </div>
    </div>
    <!-- CANCELED -->
    <div
      v-if="status == 'CANCELED'"
      id="alert-accepted"
      class="mb-4 rounded-lg border border-gray-300 bg-gray-50 p-4 text-gray-800 dark:border-gray-800 dark:bg-gray-800 dark:text-gray-400"
      role="alert"
    >
      <div class="flex items-center">
        <svg
          class="me-2 h-4 w-4 shrink-0"
          aria-hidden="true"
          xmlns="http://www.w3.org/2000/svg"
          fill="currentColor"
          viewBox="0 0 20 20"
        >
          <path
            d="M10 .5a9.5 9.5 0 1 0 9.5 9.5A9.51 9.51 0 0 0 10 .5ZM9.5 4a1.5 1.5 0 1 1 0 3 1.5 1.5 0 0 1 0-3ZM12 15H8a1 1 0 0 1 0-2h1v-3H8a1 1 0 0 1 0-2h2a1 1 0 0 1 1 1v4h1a1 1 0 0 1 0 2Z"
          />
        </svg>
        <span class="sr-only">Info</span>
        <h3 class="text-base font-medium">Pendaftaran dibatalkan</h3>
      </div>
      <div class="mt-2 text-xs">
        Anda telah membatalkan pendaftaran. Jika ingin mendaftar kembali, silakan lakukan proses pendaftaran ulang.
      </div>
    </div>
  </div>
</template>
