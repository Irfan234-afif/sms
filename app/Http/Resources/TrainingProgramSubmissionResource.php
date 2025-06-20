<?php

namespace App\Http\Resources;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TrainingProgramSubmissionResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'uuid' => $this->uuid,
            'reference_number' => $this->reference_number,
            'status' => $this->status,
            'status_label' => $this->getStatusLabel(),
            'training_program_id' => $this->training_program_id,
            // Submitter information
            'submitter' => [
                'uuid' => $this->submitter->uuid ?? null,
                'name' => $this->submitter->profile->name ?? null,
                'email' => $this->submitter->profile->email ?? null,
                'position' => $this->submitter->assignment->position->name ?? null,
                'area' => $this->submitter->assignment->area->name ?? null,
            ],
            
            // Area information
            'area' => [
                'uuid' => $this->submission?->area?->uuid ?? null,
                'name' => $this->submission?->area?->name ?? null,
            ],
            
            // Training information
            'training_type' => $this->training_type,
            'training_type_label' => $this->getTrainingTypeLabel(),
            'title' => $this->title,
            'provider' => $this->provider,
            'location' => $this->location,
            'method' => $this->method,
            'start_date' => $this->start_date?->format('Y-m-d'),
            'end_date' => $this->end_date?->format('Y-m-d'),
            'daily_start_time' => $this->daily_start_time,
            'daily_end_time' => $this->daily_end_time,
            'training_days' => $this->training_days,
            'description' => $this->description,
            'justification' => $this->justification,
            'expected_outcomes' => $this->expected_outcomes,
            // Training program reference (for internal training)
            'training_program' => $this->when($this->trainingProgram, [
                'uuid' => $this->trainingProgram->uuid ?? null,
                'name' => $this->trainingProgram->name ?? null,
                'type' => $this->trainingProgram->type ?? null,
                'level' => $this->trainingProgram->level ?? null,
                'description' => $this->trainingProgram->description ?? null,
            ]),
            
            // Goals
            'goals' => $this->when($this->goals, function () {
                return $this->goals->map(function ($goal) {
                    return [
                        'uuid' => $goal->uuid,
                        'goal_type' => $goal->goal_type,
                        'goal_type_label' => $goal->getGoalTypeLabel(),
                        'description' => $goal->description,
                        'success_indicator' => $goal->success_indicator,
                        'order' => $goal->order,
                    ];
                })->sortBy('order')->values();
            }),
            
            // Budget items
            'budget_items' => $this->when($this->budgetItems, function () {
                return $this->budgetItems->map(function ($item) {
                    return [
                        'uuid' => $item->uuid,
                        'category' => $item->category,
                        'item_name' => $item->item_name,
                        'category_label' => $item->getCategoryLabel(),
                        'description' => $item->description,
                        'quantity' => $item->quantity,
                        'unit_price' => $item->unit_price,
                        'total_price' => $item->total_price,
                        'unit_price_formatted' => $item->getFormattedUnitPrice(),
                        'total_price_formatted' => $item->getFormattedTotalPrice(),
                    ];
                });
            }),
            
            // Total budget calculation
            'total_budget' => $this->getTotalBudget(),
            'total_budget_formatted' => $this->getFormattedTotalBudget(),
            
            // Participants
            'participants' => $this->when($this->participants, function () {
                return $this->participants->map(function ($participant) {
                    $participantData = [
                        'uuid' => $participant->uuid,
                        'participant_type' => $participant->participant_type,
                        'participant_id' => $participant->participant_id,
                        'participant_category' => $participant->getParticipantCategoryLabel(),
                        'is_primary_participant' => $participant->is_primary_participant,
                        'role_description' => $participant->role_description,
                        'selection_reason' => $participant->selection_reason,
                        'name' => $participant->participant_name,
                        'email' => $participant->participant_email,
                        'phone' => $participant->participant_phone,
                    ];

                    // Add type-specific information
                    if ($participant->participant instanceof \App\Models\Employee) {
                        $participantData['position'] = $participant->participant_position;
                        $participantData['area'] = $participant->participant_area;
                        $participantData['employee'] = [
                            'uuid' => $participant->participant->uuid ?? null,
                            'name' => $participant->participant->profile?->name ?? null,
                            'email' => $participant->participant->profile?->email ?? null,
                            'phone' => $participant->participant->profile?->phone ?? null,
                            'position' => $participant->participant->assignment?->position?->name,
                            'area' => $participant->participant->assignment?->area?->name,
                        ];
                    } elseif ($participant->participant instanceof \App\Models\Student) {
                        $participantData['school'] = $participant->participant->school?->name;
                        $participantData['grade'] = $participant->participant->grade?->name;
                        $participantData['student'] = [
                            'uuid' => $participant->participant->uuid ?? null,
                            'name' => $participant->participant->profile?->name ?? null,
                            'email' => $participant->participant->profile?->email ?? null,
                            'phone' => $participant->participant->profile?->phone ?? null,
                            'school' => $participant->participant->school?->name,
                            'grade' => $participant->participant->grade?->name,
                        ];
                    } elseif ($participant->participant instanceof \App\Models\StudentGuardian) {
                        $studentNames = $participant->participant->students->pluck('profile.name')->implode(', ');
                        $participantData['students'] = $studentNames;
                        $participantData['student_guardian'] = [
                            'uuid' => $participant->participant->uuid ?? null,
                            'name' => $participant->participant->profile?->name ?? null,
                            'email' => $participant->participant->profile?->email ?? null,
                            'phone' => $participant->participant->profile?->phone ?? null,
                            'students' => $studentNames,
                        ];
                    }

                    return $participantData;
                });
            }),
            
            // Participants summary
            'participants_count' => $this->participants?->count() ?? 0,
            'primary_participant' => $this->when($this->participants, function () {
                $primary = $this->participants->where('is_primary_participant', true)->first();
                if (!$primary) return null;

                $data = [
                    'name' => $primary->participant_name,
                    'category' => $primary->getParticipantCategoryLabel(),
                ];

                if ($primary->participant instanceof \App\Models\Employee) {
                    $data['position'] = $primary->participant_position;
                    $data['area'] = $primary->participant_area;
                } elseif ($primary->participant instanceof \App\Models\Student) {
                    $data['school'] = $primary->participant->school?->name;
                    $data['grade'] = $primary->participant->grade?->name;
                } elseif ($primary->participant instanceof \App\Models\StudentGuardian) {
                    $data['students'] = $primary->participant->students->pluck('profile.name')->implode(', ');
                }

                return $data;
            }),
            
            // Attachments
            'attachments' => $this->when($this->attachments, function () {
                return $this->attachments->map(function ($attachment) {
                    return [
                        'id' => $attachment->id,
                        'uuid' => $attachment->uuid,
                        'attachment_type' => $attachment->attachment_type,
                        'attachment_type_label' => $attachment->getAttachmentTypeLabel(),
                        'title' => $attachment->description ?? $attachment->file_name,
                        'file_name' => $attachment->file_name,
                        'file_path' => $attachment->file_path,
                        'file_size' => $attachment->file_size,
                        'file_type' => $attachment->file_type,
                        'file_size_formatted' => $attachment->getFormattedFileSize(),
                        'file_icon' => $attachment->getFileIcon(),
                        'file_url' => $attachment->getDownloadUrl(),
                        'download_url' => $attachment->getDownloadUrl(),
                        'created_at' => $attachment->created_at?->format('Y-m-d H:i:s'),
                    ];
                });
            }),
            
            // Submission workflow information
            'submission' => $this->when($this->submission, [
                'uuid' => $this->submission->uuid ?? null,
                'reference_number' => $this->submission->reference_number ?? null,
                'status' => $this->submission->status ?? null,
                'datetime' => Carbon::parse($this->submission->datetime)->format('Y-m-d H:i:s'),
            ]),

            // Approval information (if available through submission)
            'approvals' => $this->when($this->submission && $this->submission->approvals, function () {
                return $this->submission->approvals->map(function ($approval) {
                    return [
                        'uuid' => $approval->uuid,
                        'status' => $approval->status,
                        'sort_number' => $approval->sort_number,
                        'is_delegated' => $approval->is_delegated ?? false,
                        'approved_at' => $approval->datetime?->format('Y-m-d H:i:s'),
                        'approver' => [
                            'uuid' => $approval->approver?->uuid,
                            'name' => $approval->approver?->profile?->name,
                            'position' => $approval->approver?->assignment?->position?->name ?? $approval->approver?->assignments?->first()?->position?->name,
                        ],
                        'delegate' => $this->when($approval->delegate, [
                            'uuid' => $approval->delegate?->uuid,
                            'name' => $approval->delegate?->profile?->name,
                            'position' => $approval->delegate?->assignment?->position?->name ?? $approval->delegate?->assignments?->first()?->position?->name,
                        ]),
                    ];
                })->sortBy('sort_number')->values();
            }),
            
            // Timestamps
            'submitted_at' => $this->submitted_at?->format('Y-m-d H:i:s'),
            'approved_at' => $this->approved_at?->format('Y-m-d H:i:s'),
            'rejected_at' => $this->rejected_at?->format('Y-m-d H:i:s'),
            'cancelled_at' => $this->cancelled_at?->format('Y-m-d H:i:s'),
            'created_at' => $this->created_at?->format('Y-m-d H:i:s'),
            'updated_at' => $this->updated_at?->format('Y-m-d H:i:s'),
            
            // Helper methods
            'can_edit' => $this->submission->status === 'DRAFT',
            'can_submit' => $this->submission->status === 'DRAFT',
            'can_cancel' => in_array($this->submission->status, ['DRAFT', 'PENDING']),
            'can_delete' => in_array($this->submission->status, ['DRAFT', 'CANCEL']),
            
            // Summary information
            'summary' => [
                'duration_days' => $this->start_date && $this->end_date 
                    ? $this->start_date->diffInDays($this->end_date) + 1 
                    : null,
                'goals_count' => $this->goals?->count() ?? 0,
                'budget_items_count' => $this->budgetItems?->count() ?? 0,
                'attachments_count' => $this->attachments?->count() ?? 0,
                'knowledge_goals' => $this->goals?->where('goal_type', 'knowledge')->count() ?? 0,
                'skill_goals' => $this->goals?->where('goal_type', 'skill')->count() ?? 0,
                'attitude_goals' => $this->goals?->where('goal_type', 'attitude')->count() ?? 0,
            ],
        ];
    }

    public function getStatusLabel(): string
    {
        return match ($this->status) {
            'draft' => 'Draft',
            'submitted' => 'Submitted',
            'approved' => 'Approved',
            'rejected' => 'Rejected',
            'cancelled' => 'Cancelled',
            default => 'Unknown',
        };
    }

    public function getTrainingTypeLabel(): string
    {
        return match ($this->training_type) {
            'internal' => 'Internal',
            'external' => 'External',
            default => 'Unknown',
        };
    }
} 