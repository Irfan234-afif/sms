<script>
import { initFlowbite } from 'flowbite';
export default {
    mounted() {
        initFlowbite();
    },
};
</script>

<script setup>
import OfficeLayout from '@/Layouts/OfficeLayout.vue';
import QRDSidebar from '@/Layouts/Sidebars/QRDSidebar.vue';
import { Head, Link, router } from '@inertiajs/vue3';
import Breadcrumb from '@/Components/Breadcrumb.vue';
import Badge from '@/Components/Badge.vue';
import OutlineButton from '@/Components/OutlineButton.vue';
import { ElNotification } from 'element-plus';
import { ref } from 'vue';

const props = defineProps({
    submission: {
        type: Object,
        required: true
    }
});

const breadcrumbs = [
    { label: 'Yayasan', href: route('office') },
    { label: 'QRD', href: route('office.qrd') },
    { label: 'Pengajuan Training Program', href: route('office.qrd.manage.training-program-submission.index') },
    { label: `Detail #${props.submission.reference_number || 'Draft'}`, href: route('office.qrd.manage.training-program-submission.show', props.submission.uuid) }
];

const getStatusColor = (status) => {
    const colors = {
        'draft': 'gray',
        'submitted': 'blue',
        'approved': 'green',
        'rejected': 'red',
        'cancelled': 'yellow'
    };
    return colors[status] || 'gray';
};

const getTrainingTypeLabel = (type) => {
    return type === 'internal' ? 'Internal' : 'Eksternal';
};

const formatCurrency = (amount) => {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0
    }).format(amount || 0);
};

const formatDate = (date) => {
    if (!date) return '-';
    return new Date(date).toLocaleDateString('id-ID', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
};

const getDayLabel = (day) => {
    const dayLabels = {
        'monday': 'Senin',
        'tuesday': 'Selasa', 
        'wednesday': 'Rabu',
        'thursday': 'Kamis',
        'friday': 'Jumat',
        'saturday': 'Sabtu',
        'sunday': 'Minggu'
    };
    return dayLabels[day] || day;
};

const submitSubmission = () => {
    if (confirm('Apakah Anda yakin ingin mengirim pengajuan ini untuk persetujuan?')) {
        router.post(route('office.qrd.manage.training-program-submission.updateStatus', props.submission.uuid), {
            status: 'PENDING'
        }, {
            preserveScroll: true,
            onSuccess: () => {
                ElNotification({
                    title: 'Berhasil',
                    message: 'Pengajuan berhasil dikirim untuk persetujuan',
                    type: 'success'
                });
            }
        });
    }
};

const cancelSubmission = () => {
    if (confirm('Apakah Anda yakin ingin membatalkan pengajuan ini?')) {
        router.post(route('office.qrd.manage.training-program-submission.updateStatus', props.submission.uuid), {
            status: 'CANCELLED'
        }, {
            preserveScroll: true,
            onSuccess: () => {
                ElNotification({
                    title: 'Berhasil',
                    message: 'Pengajuan berhasil dibatalkan',
                    type: 'success'
                });
            }
        });
    }
};

const deleteSubmission = () => {
    if (confirm('Apakah Anda yakin ingin menghapus pengajuan ini?')) {
        router.delete(route('office.qrd.manage.training-program-submission.destroy', props.submission.uuid), {
            onSuccess: () => {
                ElNotification({
                    title: 'Berhasil',
                    message: 'Pengajuan berhasil dihapus',
                    type: 'success'
                });
            }
        });
    }
};

const deleteAttachment = (attachmentId) => {
    if (confirm('Apakah Anda yakin ingin menghapus lampiran ini?')) {
        router.delete(route('office.qrd.manage.training-program-submission.deleteAttachment', [props.submission.uuid, attachmentId]), {
            preserveScroll: true,
            onSuccess: () => {
                ElNotification({
                    title: 'Berhasil',
                    message: 'Lampiran berhasil dihapus',
                    type: 'success'
                });
            }
        });
    }
};

const downloadAttachment = (attachment) => {
    window.open(attachment.file_url, '_blank');
};
</script>

<template>
    <Head :title="`Detail Pengajuan - ${submission.title}`" />

    <OfficeLayout>
        <template #header>
            <Breadcrumb :breadcrumbs="breadcrumbs" />
            <div class="mx-4 flex flex-col items-stretch justify-between space-y-3 py-3 dark:border-gray-700 md:flex-row md:items-center md:space-x-3 md:space-y-0">
                <div>
                    <h1 class="text-xl font-semibold text-gray-900">{{ submission.title }}</h1>
                    <p class="text-sm text-gray-500">{{ submission.reference_number || 'Draft' }}</p>
                </div>
                <div class="flex space-x-2">
                    <!-- Edit Button -->
                    <Link v-if="submission.can_edit" 
                        :href="route('office.qrd.manage.training-program-submission.edit', submission.uuid)">
                        <OutlineButton type="yellow">
                            <i class="fas fa-edit mr-2"></i>Edit
                        </OutlineButton>
                    </Link>

                    <!-- Submit Button -->
                    <OutlineButton v-if="submission.can_submit" 
                        @click="submitSubmission" 
                        type="green">
                        <i class="fas fa-paper-plane mr-2"></i>Submit
                    </OutlineButton>

                    <!-- Cancel Button -->
                    <OutlineButton v-if="submission.can_cancel" 
                        @click="cancelSubmission" 
                        type="orange">
                        <i class="fas fa-times mr-2"></i>Batalkan
                    </OutlineButton>

                    <!-- Delete Button -->
                    <OutlineButton v-if="submission.can_delete" 
                        @click="deleteSubmission" 
                        type="red">
                        <i class="fas fa-trash mr-2"></i>Hapus
                    </OutlineButton>
                </div>
            </div>
        </template>
        <template #sidebar>
            <QRDSidebar />
        </template>
        <template #content>
            <div class="space-y-6">
                <!-- Status Card -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-lg font-semibold text-gray-900">Status Pengajuan</h2>
                            <div class="mt-2 flex items-center space-x-4">
                                <Badge v-if="submission.submission.status == 'DRAFT'" type="dark">Draf</Badge>
                                <Badge v-else-if="submission.submission.status == 'PENDING'" type="yellow">Menunggu</Badge>
                                <Badge v-else-if="submission.submission.status == 'REJECTED'" type="red">Ditolak</Badge>
                                <Badge v-else-if="submission.submission.status == 'APPROVED'" type="green">Disetujui</Badge>
                                <span class="text-sm text-gray-500">
                                    Dibuat: {{ formatDate(submission.created_at) }}
                                </span>
                                <span v-if="submission.submission.submitted_at" class="text-sm text-gray-500">
                                    Dikirim: {{ formatDate(submission.submission.submitted_at) }}
                                </span>
                            </div>
                        </div>
                        <div class="text-right">
                            <div class="text-2xl font-bold text-green-600">
                                {{ formatCurrency(submission.total_budget) }}
                            </div>
                            <div class="text-sm text-gray-500">Total Budget</div>
                        </div>
                    </div>
                </div>

                <!-- Basic Information -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Informasi Dasar</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Pengaju</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.submitter.name }}</p>
                            <p class="text-xs text-gray-500">{{ submission.submitter.area }}</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Area</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.area.name }}</p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Tipe Training</label>
                            <Badge :type="submission.training_type === 'internal' ? 'blue' : 'purple'">
                                {{ getTrainingTypeLabel(submission.training_type) }}
                            </Badge>
                        </div>
                        <div v-if="submission.training_program">
                            <label class="block text-sm font-medium text-gray-700">Program Training</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.training_program.name }}</p>
                        </div>
                        <div v-if="submission.provider">
                            <label class="block text-sm font-medium text-gray-700">Provider</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.provider }}</p>
                        </div>
                        <div v-if="submission.location">
                            <label class="block text-sm font-medium text-gray-700">Lokasi</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.location }}</p>
                        </div>
                        <div v-if="submission.method">
                            <label class="block text-sm font-medium text-gray-700">Metode</label>
                            <p class="mt-1 text-sm text-gray-900">{{ submission.method }}</p>
                        </div>
                    </div>
                    <div v-if="submission.description" class="mt-6">
                        <label class="block text-sm font-medium text-gray-700">Deskripsi</label>
                        <p class="mt-1 text-sm text-gray-900">{{ submission.description }}</p>
                    </div>
                </div>

                <!-- Schedule Information -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Jadwal Training</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Tanggal</label>
                            <p class="mt-1 text-sm text-gray-900">
                                {{ formatDate(submission.start_date) }} - {{ formatDate(submission.end_date) }}
                            </p>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700">Waktu Harian</label>
                            <p class="mt-1 text-sm text-gray-900">
                                {{ submission.daily_start_time || '-' }} - {{ submission.daily_end_time || '-' }}
                            </p>
                        </div>
                        <div v-if="submission.training_days && submission.training_days.length > 0">
                            <label class="block text-sm font-medium text-gray-700">Hari Training</label>
                            <div class="mt-1 flex flex-wrap gap-1">
                                <span v-for="day in submission.training_days" :key="day" 
                                    class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                    {{ getDayLabel(day) }}
                                </span>
                            </div>
                        </div>
                        <div v-else>
                            <label class="block text-sm font-medium text-gray-700">Hari Training</label>
                            <p class="mt-1 text-sm text-gray-900">Setiap hari</p>
                        </div>
                    </div>
                </div>

                <!-- Goals Section -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        Tujuan Training ({{ submission.goals_count }} item)
                    </h3>
                    <div class="space-y-4">
                        <div v-for="(goal, index) in submission.goals" :key="index" 
                             class="border rounded-lg p-4">
                            <div class="flex items-center space-x-2 mb-2">
                                <Badge :type="goal.goal_type === 'knowledge' ? 'blue' : goal.goal_type === 'skill' ? 'green' : 'purple'">
                                    {{ goal.goal_type_label }}
                                </Badge>
                                <span class="text-sm font-medium text-gray-700">Tujuan {{ index + 1 }}</span>
                            </div>
                            <div class="mb-2">
                                <label class="block text-xs font-medium text-gray-500">Deskripsi</label>
                                <p class="text-sm text-gray-900">{{ goal.description }}</p>
                            </div>
                            <div v-if="goal.success_indicator">
                                <label class="block text-xs font-medium text-gray-500">Indikator Keberhasilan</label>
                                <p class="text-sm text-gray-900">{{ goal.success_indicator }}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Budget Section -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        Budget Planning ({{ submission.budget_items.length }} item)
                    </h3>
                    <div class="overflow-x-auto">
                        <table class="w-full text-sm text-left text-gray-500">
                            <thead class="text-xs text-gray-700 uppercase bg-gray-50">
                                <tr>
                                    <th class="px-6 py-3">Kategori</th>
                                    <th class="px-6 py-3">Deskripsi</th>
                                    <th class="px-6 py-3">Kuantitas</th>
                                    <th class="px-6 py-3">Harga Satuan</th>
                                    <th class="px-6 py-3">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(item, index) in submission.budget_items" :key="index" 
                                    class="bg-white border-b">
                                    <td class="px-6 py-4 font-medium text-gray-900">
                                        {{ item.category_label }}
                                    </td>
                                    <td class="px-6 py-4">{{ item.description || '-' }}</td>
                                    <td class="px-6 py-4">{{ item.quantity }}</td>
                                    <td class="px-6 py-4">{{ formatCurrency(item.unit_price) }}</td>
                                    <td class="px-6 py-4 font-semibold">{{ formatCurrency(item.total_price) }}</td>
                                </tr>
                            </tbody>
                            <tfoot>
                                <tr class="bg-gray-50 font-semibold text-gray-900">
                                    <td colspan="4" class="px-6 py-3 text-right">Total Budget:</td>
                                    <td class="px-6 py-3 text-lg text-green-600">
                                        {{ formatCurrency(submission.total_budget) }}
                                    </td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- Participants Section -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        Peserta Training ({{ submission.participants_count }} orang)
                    </h3>
                    <div class="space-y-4">
                        <div v-for="(participant, index) in submission.participants" :key="index" 
                             class="border rounded-lg p-4">
                            <div class="flex items-center justify-between mb-2">
                                <div class="flex items-center space-x-2">
                                    <h4 class="font-medium text-gray-900">{{ participant.name }}</h4>
                                    <Badge v-if="participant.is_primary_participant" type="blue">
                                        Peserta Utama
                                    </Badge>
                                </div>
                            </div>
                            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 text-sm">
                                <div>
                                    <label class="block text-xs font-medium text-gray-500">Email</label>
                                    <p class="text-gray-900">{{ participant.email || '-' }}</p>
                                </div>
                                <div>
                                    <label class="block text-xs font-medium text-gray-500">Posisi</label>
                                    <p class="text-gray-900">{{ participant.position || '-' }}</p>
                                </div>
                                <div>
                                    <label class="block text-xs font-medium text-gray-500">Area</label>
                                    <p class="text-gray-900">{{ participant.area || '-' }}</p>
                                </div>
                                <div>
                                    <label class="block text-xs font-medium text-gray-500">Telepon</label>
                                    <p class="text-gray-900">{{ participant.phone || '-' }}</p>
                                </div>
                            </div>
                            <div v-if="participant.role_description || participant.selection_reason" 
                                 class="mt-3 grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                                <div v-if="participant.role_description">
                                    <label class="block text-xs font-medium text-gray-500">Deskripsi Peran</label>
                                    <p class="text-gray-900">{{ participant.role_description }}</p>
                                </div>
                                <div v-if="participant.selection_reason">
                                    <label class="block text-xs font-medium text-gray-500">Alasan Pemilihan</label>
                                    <p class="text-gray-900">{{ participant.selection_reason }}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Attachments Section -->
                <div v-if="submission.attachments.length > 0" class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">
                        Lampiran ({{ submission.attachments.length }} file)
                    </h3>
                    <div class="space-y-3">
                        <div v-for="(attachment, index) in submission.attachments" :key="index" 
                             class="flex items-center justify-between p-3 border rounded-lg">
                            <div class="flex items-center space-x-3">
                                <div class="w-10 h-10 bg-blue-100 rounded-lg flex items-center justify-center">
                                    <i :class="attachment.file_icon" class="text-blue-600"></i>
                                </div>
                                <div>
                                    <h4 class="font-medium text-gray-900">{{ attachment.title }}</h4>
                                    <p class="text-sm text-gray-500">
                                        {{ attachment.attachment_type_label }} • {{ attachment.file_size }}
                                    </p>
                                </div>
                            </div>
                            <div class="flex items-center space-x-2">
                                <OutlineButton @click="downloadAttachment(attachment)" type="primary" size="sm">
                                    <i class="fas fa-download mr-1"></i>Download
                                </OutlineButton>
                                <OutlineButton v-if="submission.can_edit" 
                                    @click="deleteAttachment(attachment.id)" 
                                    type="red" size="sm">
                                    <i class="fas fa-trash"></i>
                                </OutlineButton>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Approval Workflow Section -->
                <div v-if="submission.approvals && submission.approvals.length > 0" 
                     class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-900 mb-4">Proses Persetujuan</h3>
                    <div class="space-y-4">
                        <div v-for="(approval, index) in submission.approvals" :key="index" 
                             class="flex items-start space-x-4 p-4 border rounded-lg">
                            <div class="w-10 h-10 rounded-full flex items-center justify-center"
                                 :class="{
                                     'bg-green-100 text-green-600': approval.status === 'approved',
                                     'bg-red-100 text-red-600': approval.status === 'rejected',
                                     'bg-yellow-100 text-yellow-600': approval.status === 'pending',
                                     'bg-gray-100 text-gray-600': approval.status === 'waiting'
                                 }">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="flex-1">
                                <div class="flex items-center justify-between">
                                    <h4 class="font-medium text-gray-900">{{ approval.approver_name }}</h4>
                                    <Badge :type="approval.status === 'approved' ? 'green' : 
                                                 approval.status === 'rejected' ? 'red' : 
                                                 approval.status === 'pending' ? 'yellow' : 'gray'">
                                        {{ approval.status_label }}
                                    </Badge>
                                </div>
                                <p class="text-sm text-gray-500">{{ approval.area_name }} • Level {{ approval.sort_number }}</p>
                                <div v-if="approval.approved_at || approval.rejected_at" class="mt-2 text-sm text-gray-600">
                                    <p>{{ approval.approved_at ? 'Disetujui' : 'Ditolak' }} pada: 
                                       {{ formatDate(approval.approved_at || approval.rejected_at) }}</p>
                                    <p v-if="approval.notes" class="mt-1 italic">"{{ approval.notes }}"</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </template>
    </OfficeLayout>
</template> 