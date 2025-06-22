<?php

namespace App\Http\Requests\TrainingProgram;

use Illuminate\Foundation\Http\FormRequest;

class UpdateTrainingProgramRequest extends StoreTrainingProgramRequest
{
    /**
     * Get the validation rules that apply to the request.
     * Override parent rules to allow id fields for updates
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $rules = parent::rules();
        
        // Add ID validation rules for update operations
        $updateRules = [
            // Phase level IDs
            'phases.*.id' => 'nullable|integer|exists:training_program_phases,id',
            
            // Module level IDs
            'phases.*.modules.*.id' => 'nullable|integer|exists:phase_modules,id',
            
            // Material level IDs
            'phases.*.modules.*.materials.*.id' => 'nullable|integer|exists:phase_module_materials,id',
            
            // Quiz level IDs
            'phases.*.modules.*.quizzes.*.id' => 'nullable|integer|exists:phase_module_quizzes,id',
            
            // Question level IDs
            'phases.*.modules.*.quizzes.*.questions.*.id' => 'nullable|integer|exists:phase_module_quiz_questions,id',
            
            // Option level IDs
            'phases.*.modules.*.quizzes.*.questions.*.options.*.id' => 'nullable|integer|exists:phase_module_quiz_question_options,id',
            
            // Assessment level IDs
            'phases.*.modules.*.assessments.*.id' => 'nullable|integer|exists:module_assessments,id',
            
            // Group Indicator level IDs
            'phases.*.modules.*.assessments.*.group_indicators.*.id' => 'nullable|integer|exists:assessment_group_indicators,id',
            
            // Indicator level IDs
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.id' => 'nullable|integer|exists:assessment_indicators,id',
            
            // Session level IDs
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.id' => 'nullable|integer|exists:assessment_indicator_sessions,id',
            
            // Rubric level IDs
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.id' => 'nullable|integer|exists:assessment_indicator_session_rubrics,id',
        ];
        
        return array_merge($rules, $updateRules);
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        $messages = parent::messages();
        
        // Add messages for ID validation
        $updateMessages = [
            'phases.*.id.exists' => 'Fase yang dipilih tidak valid',
            'phases.*.modules.*.id.exists' => 'Modul yang dipilih tidak valid',
            'phases.*.modules.*.materials.*.id.exists' => 'Materi yang dipilih tidak valid',
            'phases.*.modules.*.quizzes.*.id.exists' => 'Quiz yang dipilih tidak valid',
            'phases.*.modules.*.quizzes.*.questions.*.id.exists' => 'Pertanyaan yang dipilih tidak valid',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.id.exists' => 'Pilihan jawaban yang dipilih tidak valid',
            'phases.*.modules.*.assessments.*.id.exists' => 'Assessment yang dipilih tidak valid',
            'phases.*.modules.*.assessments.*.group_indicators.*.id.exists' => 'Grup indikator yang dipilih tidak valid',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.id.exists' => 'Indikator yang dipilih tidak valid',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.id.exists' => 'Sesi yang dipilih tidak valid',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.id.exists' => 'Rubrik yang dipilih tidak valid',
        ];
        
        return array_merge($messages, $updateMessages);
    }

    /**
     * Get custom attributes for validator errors.
     *
     * @return array<string, string>
     */
    public function attributes(): array
    {
        $attributes = parent::attributes();
        
        // Add attributes for ID fields
        $updateAttributes = [
            'phases.*.id' => 'ID Fase',
            'phases.*.modules.*.id' => 'ID Modul',
            'phases.*.modules.*.materials.*.id' => 'ID Materi',
            'phases.*.modules.*.quizzes.*.id' => 'ID Quiz',
            'phases.*.modules.*.quizzes.*.questions.*.id' => 'ID Pertanyaan',
            'phases.*.modules.*.quizzes.*.questions.*.options.*.id' => 'ID Pilihan Jawaban',
            'phases.*.modules.*.assessments.*.id' => 'ID Assessment',
            'phases.*.modules.*.assessments.*.group_indicators.*.id' => 'ID Grup Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.id' => 'ID Indikator',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.id' => 'ID Sesi',
            'phases.*.modules.*.assessments.*.group_indicators.*.indicators.*.sessions.*.rubrics.*.id' => 'ID Rubrik',
        ];
        
        return array_merge($attributes, $updateAttributes);
    }
} 