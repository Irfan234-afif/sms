<?php

namespace App\Http\Requests\TrainingProgram;

use Illuminate\Foundation\Http\FormRequest;

class StoreAssessmentResultRequest extends FormRequest
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
            'scores' => 'required|array',
            'scores.*' => 'required|integer|exists:activity_assessment_rubrics,id',
            'feedback' => 'nullable|string|max:1000',
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     */
    public function messages(): array
    {
        return [
            'scores.required' => 'Rubric assessment wajib dipilih',
            'scores.array' => 'Format rubric tidak valid',
            'scores.*.required' => 'Semua session harus dipilih rubricnya',
            'scores.*.integer' => 'Rubric ID harus berupa angka',
            'scores.*.exists' => 'Rubric yang dipilih tidak valid',
            'feedback.string' => 'Feedback harus berupa teks',
            'feedback.max' => 'Feedback maksimal 1000 karakter',
        ];
    }

    /**
     * Get custom attributes for validator errors.
     */
    public function attributes(): array
    {
        return [
            'scores' => 'Rubric Assessment',
            'scores.*' => 'Rubric Session',
            'feedback' => 'Feedback',
        ];
    }
} 