<?php

namespace App\Services;

use App\Models\Profile;
use App\Models\Submission;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramActivity;
use App\Models\TrainingProgram\TrainingProgramActivityParticipant;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class TrainingProgramActivityService
{
    protected ActivitySnapshotService $snapshotService;

    public function __construct(ActivitySnapshotService $snapshotService)
    {
        $this->snapshotService = $snapshotService;
    }

    /**
     * Create a new training program activity.
     */
    public function createActivity(array $data): TrainingProgramActivity
    {
        DB::beginTransaction();
        try {
            // Convert UUIDs to IDs
            $trainingProgramId = $this->getTrainingProgramId($data['training_program_id'] ?? null);
            $submissionId = $this->getSubmissionId($data['submission_id'] ?? null);
            $participantIds = $this->getParticipantIds($data['participant_ids']);

            // Create activity
            $activity = TrainingProgramActivity::create([
                'title' => $data['title'],
                'description' => $data['description'] ?? null,
                'training_program_id' => $trainingProgramId,
                'submission_id' => $submissionId,
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'status' => strtoupper($data['status']),
                'created_by' => auth()->user()->profile->id,
            ]);

            // Create snapshot if this is an internal training
            if ($activity->training_program_id) {
                $this->snapshotService->createSnapshot($activity);
            }

            // Add participants
            $this->addParticipantsToActivity($activity, $participantIds);

            DB::commit();
            return $activity;
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Error creating training program activity: ' . $e->getMessage(), [
                'trace' => $e->getTraceAsString(),
                'data' => $data
            ]);
            throw $e;
        }
    }

    /**
     * Update an existing training program activity.
     */
    public function updateActivity(TrainingProgramActivity $activity, array $data): TrainingProgramActivity
    {
        DB::beginTransaction();
        try {
            // Update basic activity info
            $activity->update([
                'title' => $data['title'],
                'description' => $data['description'] ?? null,
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'status' => strtoupper($data['status']),
            ]);

            // Update participants
            $this->updateActivityParticipants($activity, $data['participant_ids']);

            DB::commit();
            return $activity->refresh();
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Add participants to activity.
     */
    public function addParticipantsToActivity(TrainingProgramActivity $activity, array $participantIds): void
    {
        foreach ($participantIds as $profileId) {
            $participant = TrainingProgramActivityParticipant::create([
                'activity_id' => $activity->id,
                'profile_id' => $profileId,
                'enrollment_date' => now(),
            ]);

            // If training program is set, create initial progress records using snapshot
            if ($activity->training_program_id) {
                $this->createInitialProgressRecordsWithSnapshot($participant, $activity);
            }
        }
    }

    /**
     * Update activity participants.
     */
    public function updateActivityParticipants(TrainingProgramActivity $activity, array $participantUuids): void
    {
        $participantIds = $this->getParticipantIds($participantUuids);
        $currentParticipantIds = $activity->participants()->pluck('profile_id')->toArray();

        // Add new participants
        $newParticipantIds = array_diff($participantIds, $currentParticipantIds);
        if (!empty($newParticipantIds)) {
            $this->addParticipantsToActivity($activity, $newParticipantIds);
        }

        // Remove participants that are no longer selected
        $removedParticipantIds = array_diff($currentParticipantIds, $participantIds);
        if (!empty($removedParticipantIds)) {
            $activity->participants()->whereIn('profile_id', $removedParticipantIds)->delete();
        }
    }

    /**
     * Create activity from approved submission.
     */
    public function createFromSubmission(int $submissionId): TrainingProgramActivity
    {
        $submission = Submission::with(['trainingProgramSubmission.participants'])
            ->where('id', $submissionId)
            ->where('status', 'APPROVED')
            ->whereHas('trainingProgramSubmission')
            ->firstOrFail();

        $trainingSubmission = $submission->trainingProgramSubmission;

        DB::beginTransaction();
        try {
            // Create activity from submission
            $activity = TrainingProgramActivity::create([
                'title' => $trainingSubmission->training_name,
                'description' => $trainingSubmission->description,
                'training_program_id' => $trainingSubmission->training_program_id,
                'submission_id' => $submission->id,
                'start_date' => $trainingSubmission->start_date,
                'end_date' => $trainingSubmission->end_date,
                'location' => $trainingSubmission->location,
                'external_provider' => $trainingSubmission->external_provider,
                'status' => 'PLANNED',
                'created_by' => auth()->user()->profile->id,
            ]);

            // Create snapshot if this is an internal training
            if ($activity->training_program_id) {
                $this->snapshotService->createSnapshot($activity);
            }

            // Add participants from submission
            $participantIds = $trainingSubmission->participants->pluck('profile_id')->toArray();
            $this->addParticipantsToActivity($activity, $participantIds);

            DB::commit();
            return $activity;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Remove participant from activity.
     */
    public function removeParticipant(TrainingProgramActivity $activity, string $participantUuid): void
    {
        $participant = $activity->participants()->where('uuid', $participantUuid)->firstOrFail();
        
        DB::beginTransaction();
        try {
            $participant->delete();
            DB::commit();
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }

    /**
     * Create initial progress records for participant using activity snapshots.
     */
    public function createInitialProgressRecordsWithSnapshot(
        TrainingProgramActivityParticipant $participant, 
        TrainingProgramActivity $activity
    ): void {
        try {
            DB::beginTransaction();
            
            Log::info('Creating initial progress records with snapshot', [
                'participant_id' => $participant->id,
                'activity_id' => $activity->id,
            ]);

            $activityTrainingProgram = $activity->activityTrainingProgram;
            
            if (!$activityTrainingProgram) {
                Log::warning('No activity snapshot found for activity', ['activity_id' => $activity->id]);
                return;
            }

            // Create phase progress records using activity snapshots
            foreach ($activityTrainingProgram->phases as $activityPhase) {
                $phaseProgress = $participant->phaseProgress()->create([
                    'activity_phase_id' => $activityPhase->id,
                    'master_phase_id' => $activityPhase->master_phase_id,
                    'old_phase_id' => $activityPhase->master_phase_id,
                    'progress_percentage' => 0,
                    'started_at' => null,
                    'completed_at' => null,
                ]);

                Log::info('Created phase progress with snapshot', ['phase_progress_id' => $phaseProgress->id]);

                // Create module progress records using activity snapshots
                foreach ($activityPhase->modules as $activityModule) {
                    $moduleProgress = $participant->moduleProgress()->create([
                        'activity_module_id' => $activityModule->id,
                        'master_module_id' => $activityModule->master_module_id,
                        'old_module_id' => $activityModule->master_module_id,
                        'status' => 'NOT_STARTED',
                        'progress_percentage' => 0,
                        'started_at' => null,
                        'completed_at' => null,
                    ]);

                    Log::info('Created module progress with snapshot', ['module_progress_id' => $moduleProgress->id]);

                    // Create material progress records using activity snapshots
                    foreach ($activityModule->materials as $activityMaterial) {
                        $materialProgress = $participant->materialProgress()->create([
                            'activity_material_id' => $activityMaterial->id,
                            'master_material_id' => $activityMaterial->master_material_id,
                            'old_material_id' => $activityMaterial->master_material_id,
                            'viewed_at' => null,
                            'completed_at' => null,
                            'time_spent' => 0,
                        ]);

                        Log::info('Created material progress with snapshot', ['material_progress_id' => $materialProgress->id]);
                    }
                }
            }

            DB::commit();
            Log::info('Successfully created all initial progress records with snapshots');
            
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error('Failed to create initial progress records with snapshots', [
                'error' => $e->getMessage(),
                'participant_id' => $participant->id,
                'activity_id' => $activity->id,
            ]);
            throw $e;
        }
    }

    /**
     * Get training program ID from UUID.
     */
    private function getTrainingProgramId(?string $uuid): ?int
    {
        if (!$uuid) return null;

        $trainingProgram = TrainingProgram::where('uuid', $uuid)->first();
        if (!$trainingProgram) {
            throw new \InvalidArgumentException('Program pelatihan tidak ditemukan');
        }

        return $trainingProgram->id;
    }

    /**
     * Get submission ID from UUID.
     */
    private function getSubmissionId(?string $uuid): ?int
    {
        if (!$uuid) return null;

        $submission = Submission::where('uuid', $uuid)->first();
        if (!$submission) {
            throw new \InvalidArgumentException('Pengajuan tidak ditemukan');
        }

        return $submission->id;
    }

    /**
     * Get participant IDs from UUIDs.
     */
    private function getParticipantIds(array $uuids): array
    {
        $participantIds = [];
        foreach ($uuids as $uuid) {
            $profile = Profile::where('uuid', $uuid)->first();
            if (!$profile) {
                throw new \InvalidArgumentException('Salah satu peserta tidak ditemukan');
            }
            $participantIds[] = $profile->id;
        }

        return $participantIds;
    }
} 