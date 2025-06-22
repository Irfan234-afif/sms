<?php

namespace App\Http\Requests\TrainingProgram;

use Illuminate\Foundation\Http\FormRequest;

class StoreTrainingProgramRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => 'required|string|max:255',
            'type' => 'required|string|max:255',
            'level' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'required|in:active,inactive',
            'phases' => 'sometimes|array',
            'phases.*.name' => 'required|string|max:255',
            'phases.*.description' => 'nullable|string',
            'phases.*.order' => 'required|integer',
            'phases.*.status' => 'required|in:active,inactive',
            'phases.*.modules' => 'sometimes|array',
            'phases.*.modules.*.name' => 'required|string|max:255',
            'phases.*.modules.*.description' => 'nullable|string',
            'phases.*.modules.*.order' => 'required|integer',
            'phases.*.modules.*.status' => 'required|in:active,inactive',
            'phases.*.modules.*.materials' => 'sometimes|array',
            'phases.*.modules.*.materials.*.title' => 'required|string|max:255',
            'phases.*.modules.*.materials.*.type' => 'required|string|in:text,link,video,document',
            'phases.*.modules.*.materials.*.content' => 'required|string',
            'phases.*.modules.*.materials.*.file_path' => 'nullable|string',
            'phases.*.modules.*.materials.*.order' => 'required|integer',
            'phases.*.modules.*.materials.*.status' => 'required|in:active,inactive',
            'phases.*.modules.*.quizzes' => 'sometimes|array',
            'phases.*.modules.*.quizzes.*.title' => 'required|string|max:255',
            'phases.*.modules.*.quizzes.*.description' => 'nullable|string',
            'phases.*.modules.*.quizzes.*.passing_score' => 'required|integer|min:0|max:100',
            'phases.*.modules.*.quizzes.*.status' => 'required|in:active,inactive',
            'phases.*.modules.*.quizzes.*.questions' => 'sometimes|array',
            'phases.*.modules.*.quizzes.*.questions.*.question' => 'required|string',
            'phases.*.modules.*.quizzes.*.questions.*.type' => 'required|in:multiple_choice,multiple_select,essay,true_false',
            'phases.*.modules.*.quizzes.*.questions.*.points' => 'required|integer|min:1',
            'phases.*.modules.*.quizzes.*.questions.*.order' => 'required|integer',
            'phases.*.modules.*.quizzes.*.questions.*.explanation' => 'nullable|string',
            'phases.*.modules.*.quizzes.*.questions.*.correct_answer' => 'nullable|string',
            'phases.*.modules.*.quizzes.*.questions.*.status' => 'required|in:active,inactive',
            'phases.*.modules.*.quizzes.*.questions.*.options' => 'sometimes|array',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.option_text' => 'required|string',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.is_correct' => 'required|boolean',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.order' => 'required|integer',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.explanation' => 'nullable|string',
            'phases.*.modules.*.assessments' => 'sometimes|array',
            'phases.*.modules.*.assessments.*.title' => 'required|string|max:255',
            'phases.*.modules.*.assessments.*.description' => 'nullable|string',
            'phases.*.modules.*.assessments.*.calculation_method' => 'required|in:AVERAGE,SUM',
            'phases.*.modules.*.assessments.*.passing_score' => 'required|integer|min:0|max:100',
            'phases.*.modules.*.assessments.*.group_indicators' => 'sometimes|array',
            'phases.*.modules.*.assessments.*.group_indicators.*.name' => 'required|string|max:255',
            'phases.*.modules.*.assessments.*.group_indicators.*.description' => 'nullable|string',
            'phases.*.modules.*.assessments.*.group_indicators.*.order' => 'required|integer',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators' => 'sometimes|array',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.name' => 'required|string|max:255',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.description' => 'nullable|string',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.order' => 'required|integer',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions' => 'sometimes|array',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.name' => 'required|string|max:255',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.description' => 'nullable|string',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.order' => 'required|integer',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics' => 'sometimes|array',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.level' => 'required|string|max:255',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.description' => 'nullable|string',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.score' => 'required|integer|min:0|max:100',
        ];
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        return [
            'name.required' => 'Nama program wajib diisi',
            'type.required' => 'Tipe program wajib diisi',
            'level.required' => 'Level program wajib diisi',
            'status.required' => 'Status program wajib dipilih',
            'status.in' => 'Status program tidak valid',
            'phases.*.name.required' => 'Nama fase wajib diisi',
            'phases.*.order.required' => 'Urutan fase wajib diisi',
            'phases.*.status.required' => 'Status fase wajib dipilih',
            'phases.*.status.in' => 'Status fase tidak valid',
            'phases.*.modules.*.name.required' => 'Nama modul wajib diisi',
            'phases.*.modules.*.order.required' => 'Urutan modul wajib diisi',
            'phases.*.modules.*.status.required' => 'Status modul wajib dipilih',
            'phases.*.modules.*.status.in' => 'Status modul tidak valid',
            'phases.*.modules.*.materials.*.title.required' => 'Judul materi wajib diisi',
            'phases.*.modules.*.materials.*.type.required' => 'Tipe materi wajib dipilih',
            'phases.*.modules.*.materials.*.type.in' => 'Tipe materi tidak valid',
            'phases.*.modules.*.materials.*.content.required' => 'Konten materi wajib diisi',
            'phases.*.modules.*.materials.*.order.required' => 'Urutan materi wajib diisi',
            'phases.*.modules.*.materials.*.status.required' => 'Status materi wajib dipilih',
            'phases.*.modules.*.materials.*.status.in' => 'Status materi tidak valid',
            'phases.*.modules.*.quizzes.*.title.required' => 'Nama quiz wajib diisi',
            'phases.*.modules.*.quizzes.*.passing_score.required' => 'Nilai kelulusan quiz wajib diisi',
            'phases.*.modules.*.quizzes.*.passing_score.min' => 'Nilai kelulusan quiz minimal 0',
            'phases.*.modules.*.quizzes.*.passing_score.max' => 'Nilai kelulusan quiz maksimal 100',
            'phases.*.modules.*.quizzes.*.status.required' => 'Status quiz wajib dipilih',
            'phases.*.modules.*.quizzes.*.status.in' => 'Status quiz tidak valid',
            'phases.*.modules.*.quizzes.*.questions.*.question.required' => 'Teks pertanyaan wajib diisi',
            'phases.*.modules.*.quizzes.*.questions.*.type.required' => 'Tipe pertanyaan wajib dipilih',
            'phases.*.modules.*.quizzes.*.questions.*.type.in' => 'Tipe pertanyaan tidak valid',
            'phases.*.modules.*.quizzes.*.questions.*.points.required' => 'Poin pertanyaan wajib diisi',
            'phases.*.modules.*.quizzes.*.questions.*.points.min' => 'Poin pertanyaan minimal 1',
            'phases.*.modules.*.quizzes.*.questions.*.order.required' => 'Urutan pertanyaan wajib diisi',
            'phases.*.modules.*.quizzes.*.questions.*.status.required' => 'Status pertanyaan wajib dipilih',
            'phases.*.modules.*.quizzes.*.questions.*.status.in' => 'Status pertanyaan tidak valid',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.option_text.required' => 'Teks pilihan jawaban wajib diisi',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.is_correct.required' => 'Status jawaban benar wajib dipilih',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.order.required' => 'Urutan pilihan jawaban wajib diisi',
            'phases.*.modules.*.assessments.*.title.required' => 'Nama assessment wajib diisi',
            'phases.*.modules.*.assessments.*.calculation_method.required' => 'Metode perhitungan assessment wajib dipilih',
            'phases.*.modules.*.assessments.*.calculation_method.in' => 'Metode perhitungan assessment tidak valid',
            'phases.*.modules.*.assessments.*.passing_score.required' => 'Nilai kelulusan assessment wajib diisi',
            'phases.*.modules.*.assessments.*.passing_score.min' => 'Nilai kelulusan assessment minimal 0',
            'phases.*.modules.*.assessments.*.passing_score.max' => 'Nilai kelulusan assessment maksimal 100',
            'phases.*.modules.*.assessments.*.group_indicators.*.name.required' => 'Nama grup indikator wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.order.required' => 'Urutan grup indikator wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.name.required' => 'Nama indikator wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.order.required' => 'Urutan indikator wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.level.required' => 'Nama sesi wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.order.required' => 'Urutan sesi wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.name.required' => 'Nama rubrik wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.score.required' => 'Nilai rubrik wajib diisi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.score.min' => 'Nilai rubrik minimal 0',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.score.max' => 'Nilai rubrik maksimal 100',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        return [
            'name' => 'Nama Program',
            'type' => 'Tipe Program',
            'level' => 'Level Program',
            'description' => 'Deskripsi',
            'status' => 'Status',
            'phases.*.name' => 'Nama Fase',
            'phases.*.description' => 'Deskripsi Fase',
            'phases.*.order' => 'Urutan Fase',
            'phases.*.status' => 'Status Fase',
            'phases.*.modules.*.name' => 'Nama Modul',
            'phases.*.modules.*.description' => 'Deskripsi Modul',
            'phases.*.modules.*.order' => 'Urutan Modul',
            'phases.*.modules.*.status' => 'Status Modul',
            'phases.*.modules.*.materials.*.title' => 'Judul Materi',
            'phases.*.modules.*.materials.*.type' => 'Tipe Materi',
            'phases.*.modules.*.materials.*.content' => 'Konten Materi',
            'phases.*.modules.*.materials.*.file_path' => 'File Materi',
            'phases.*.modules.*.materials.*.order' => 'Urutan Materi',
            'phases.*.modules.*.materials.*.status' => 'Status Materi',
            'phases.*.modules.*.quizzes.*.title' => 'Nama Quiz',
            'phases.*.modules.*.quizzes.*.description' => 'Deskripsi Quiz',
            'phases.*.modules.*.quizzes.*.passing_score' => 'Nilai Kelulusan Quiz',
            'phases.*.modules.*.quizzes.*.status' => 'Status Quiz',
            'phases.*.modules.*.quizzes.*.questions.*.question' => 'Teks Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.type' => 'Tipe Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.points' => 'Poin Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.order' => 'Urutan Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.explanation' => 'Penjelasan Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.correct_answer' => 'Jawaban Benar',
            'phases.*.modules.*.quizzes.*.questions.*.status' => 'Status Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.option_text' => 'Teks Pilihan Jawaban',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.is_correct' => 'Status Jawaban Benar',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.order' => 'Urutan Pilihan Jawaban',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.explanation' => 'Penjelasan Pilihan Jawaban',
            'phases.*.modules.*.assessments.*.title' => 'Nama Assessment',
            'phases.*.modules.*.assessments.*.description' => 'Deskripsi Assessment',
            'phases.*.modules.*.assessments.*.calculation_method' => 'Metode Perhitungan Assessment',
            'phases.*.modules.*.assessments.*.passing_score' => 'Nilai Kelulusan Assessment',
            'phases.*.modules.*.assessments.*.group_indicators.*.name' => 'Nama Grup Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.description' => 'Deskripsi Grup Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.order' => 'Urutan Grup Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.name' => 'Nama Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.description' => 'Deskripsi Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.order' => 'Urutan Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.name' => 'Nama Sesi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.description' => 'Deskripsi Sesi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.order' => 'Urutan Sesi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.level' => 'Nama Rubrik',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.description' => 'Deskripsi Rubrik',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.score' => 'Nilai Rubrik',
        ];
    }
} 