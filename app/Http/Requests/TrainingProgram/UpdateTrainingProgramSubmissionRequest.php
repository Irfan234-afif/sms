<?php

namespace App\Http\Requests\TrainingProgram;

class UpdateTrainingProgramSubmissionRequest extends StoreTrainingProgramSubmissionRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $rules = parent::rules();
        
        // For update, attachments are optional since they may already exist
        $rules['attachments.*.file'] = 'nullable|file|mimes:pdf,doc,docx,jpg,jpeg,png|max:10240';
        
        return $rules;
    }

    /**
     * Get custom messages for validator errors.
     *
     * @return array<string, string>
     */
    public function messages(): array
    {
        $messages = parent::messages();
        
        // Update attachment file message since it's optional now
        $messages['attachments.*.file.required'] = 'File lampiran wajib diupload untuk lampiran baru';
        
        return $messages;
    }
} 