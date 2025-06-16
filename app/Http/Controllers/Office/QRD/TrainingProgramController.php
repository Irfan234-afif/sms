<?php

namespace App\Http\Controllers\Office\QRD;
use App\Http\Controllers\Controller;

use App\Http\Resources\TrainingProgramResource;
use App\Http\Requests\TrainingProgram\StoreTrainingProgramRequest;
use App\Http\Requests\TrainingProgram\UpdateTrainingProgramRequest;
use App\Models\TrainingProgram\TrainingProgram;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Arr;
use Inertia\Inertia;

class TrainingProgramController extends Controller
{
    /**
     * Display a listing of training programs.
     */
    public function index()
    {
        $programs = TrainingProgram::query();

        if (request()->has('search')) {
            $programs->where(function ($query) {
                $query->where('name', 'like', '%' . request('search') . '%')
                      ->orWhere('type', 'like', '%' . request('search') . '%')
                      ->orWhere('level', 'like', '%' . request('search') . '%');
            });
        }

        $programs = $programs->latest()->paginate(15);
        // dd(TrainingProgramResource::collection($programs)->toArray(request()));

        return Inertia::render('Office/QRD/TrainingPrograms/Index', [
            'programs' => TrainingProgramResource::collection($programs),
            'search_params' => [
                'search' => request('search'),
            ],
        ]);
    }

    /**
     * Show the form for creating a new training program.
     */
    public function create()
    {
        return Inertia::render('Office/QRD/TrainingPrograms/Create');
    }

    /**
     * Store a newly created training program.
     */
    public function store(StoreTrainingProgramRequest $request)
    {
        DB::transaction(function () use ($request) {
            $validated = $request->validated();
            
            // Create program
            $program = TrainingProgram::create(Arr::except($validated, ['phases']));

            // Handle phases
            if (isset($validated['phases'])) {
                foreach ($validated['phases'] as $phaseData) {
                    $phase = $program->phases()->create(Arr::except($phaseData, ['modules']));

                    // Handle modules
                    if (isset($phaseData['modules'])) {
                        foreach ($phaseData['modules'] as $moduleData) {
                            $module = $phase->modules()->create(Arr::except($moduleData, ['materials', 'quizzes', 'assessments']));

                            // Handle materials
                            if (isset($moduleData['materials'])) {
                                foreach ($moduleData['materials'] as $materialData) {
                                    $module->materials()->create([
                                        'title' => $materialData['title'],
                                        'type' => $materialData['type'],
                                        'content' => $materialData['content'],
                                        'file_path' => $materialData['file_path'] ?? null,
                                        'order' => $materialData['order'],
                                        'status' => $materialData['status']
                                    ]);
                                }
                            }

                            // Handle quizzes
                            if (isset($moduleData['quizzes'])) {
                                foreach ($moduleData['quizzes'] as $quizData) {
                                    $module->quizzes()->create($quizData);
                                }
                            }

                            // Handle assessments
                            if (isset($moduleData['assessments'])) {
                                foreach ($moduleData['assessments'] as $assessmentData) {
                                    $assessment = $module->assessments()->create(Arr::except($assessmentData, ['group_indicators']));

                                    // Handle group indicators
                                    if (isset($assessmentData['group_indicators'])) {
                                        foreach ($assessmentData['group_indicators'] as $groupIndicatorData) {
                                            $groupIndicator = $assessment->groupIndicators()->create(Arr::except($groupIndicatorData, ['indicators']));

                                            // Handle indicators
                                            if (isset($groupIndicatorData['indicators'])) {
                                                foreach ($groupIndicatorData['indicators'] as $indicatorData) {
                                                    $indicator = $groupIndicator->indicators()->create(Arr::except($indicatorData, ['sessions']));

                                                    // Handle sessions
                                                    if (isset($indicatorData['sessions'])) {
                                                        foreach ($indicatorData['sessions'] as $sessionData) {
                                                            $session = $indicator->sessions()->create(Arr::except($sessionData, ['rubrics']));

                                                            // Handle rubrics
                                                            if (isset($sessionData['rubrics'])) {
                                                                foreach ($sessionData['rubrics'] as $rubricData) {
                                                                    $session->rubrics()->create($rubricData);
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        });

        return redirect()->route('office.qrd.training-program.index')
            ->with('success', 'Training program created successfully');
    }

    /**
     * Display the specified training program.
     */
    public function show($uuid)
    {
        $trainingProgram = TrainingProgram::where('uuid', $uuid)->firstOrFail();
        $trainingProgram->load([
            'phases.modules.materials',
            'phases.modules.quizzes.questions.options',
            'phases.modules.assessments.groupIndicators.indicators.sessions.rubrics'
        ]);
        return Inertia::render('Office/QRD/TrainingPrograms/Show', [
            'program' => $trainingProgram
        ]);
    }

    /**
     * Show the form for editing the training program.
     */
    public function edit($uuid)
    {
        $trainingProgram = TrainingProgram::where('uuid', $uuid)->firstOrFail();
        $trainingProgram->load(['phases.modules.materials', 'phases.modules.quizzes', 'phases.modules.assessments.groupIndicators.indicators.sessions.rubrics']);
        return Inertia::render('Office/QRD/TrainingPrograms/Edit', [
            'program' => $trainingProgram,
            'phases' => $trainingProgram->phases
        ]);
    }

    /**
     * Update the specified training program.
     */
    public function update(UpdateTrainingProgramRequest $request, $uuid)
    {
        $trainingProgram = TrainingProgram::where('uuid', $uuid)->firstOrFail();
        $validated = $request->validated();

        DB::transaction(function () use ($trainingProgram, $validated) {
            // Update program
            $trainingProgram->update(Arr::except($validated, ['phases']));

            // Handle phases
            if (isset($validated['phases'])) {
                $existingPhaseIds = $trainingProgram->phases()->pluck('id')->toArray();
                $updatedPhaseIds = [];

                foreach ($validated['phases'] as $phaseData) {
                    $phase = $trainingProgram->phases()->updateOrCreate(
                        ['id' => $phaseData['id'] ?? null],
                        Arr::except($phaseData, ['id', 'modules'])
                    );
                    $updatedPhaseIds[] = $phase->id;

                    // Handle modules
                    if (isset($phaseData['modules'])) {
                        $existingModuleIds = $phase->modules()->pluck('id')->toArray();
                        $updatedModuleIds = [];

                        foreach ($phaseData['modules'] as $moduleData) {
                            $module = $phase->modules()->updateOrCreate(
                                ['id' => $moduleData['id'] ?? null],
                                Arr::except($moduleData, ['id', 'materials', 'quizzes', 'assessments'])
                            );
                            $updatedModuleIds[] = $module->id;
                            // Handle materials
                            if (isset($moduleData['materials'])) {
                                $existingMaterialIds = $module->materials()->pluck('id')->toArray();
                                $updatedMaterialIds = [];

                                foreach ($moduleData['materials'] as $materialData) {
                                    $material = $module->materials()->updateOrCreate(
                                        ['id' => $materialData['id'] ?? null],
                                        [
                                            'title' => $materialData['title'],
                                            'type' => $materialData['type'],
                                            'content' => $materialData['content'],
                                            'file_path' => $materialData['file_path'] ?? null,
                                            'order' => $materialData['order'],
                                            'status' => $materialData['status']
                                        ]
                                    );
                                    $updatedMaterialIds[] = $material->id;
                                }

                                // Delete materials not in the updated list
                                $materialsToDelete = array_diff($existingMaterialIds, $updatedMaterialIds);
                                if (!empty($materialsToDelete)) {
                                    $module->materials()->whereIn('id', $materialsToDelete)->delete();
                                }
                            }

                            // Handle quizzes
                            if (isset($moduleData['quizzes'])) {
                                $existingQuizIds = $module->quizzes()->pluck('id')->toArray();
                                $updatedQuizIds = [];

                                foreach ($moduleData['quizzes'] as $quizData) {
                                    $quiz = $module->quizzes()->updateOrCreate(
                                        ['id' => $quizData['id'] ?? null],
                                        Arr::except($quizData, ['id'])
                                    );
                                    $updatedQuizIds[] = $quiz->id;
                                }

                                // Delete quizzes not in the updated list
                                $quizzesToDelete = array_diff($existingQuizIds, $updatedQuizIds);
                                if (!empty($quizzesToDelete)) {
                                    $module->quizzes()->whereIn('id', $quizzesToDelete)->delete();
                                }
                            }

                            // Handle assessments
                            if (isset($moduleData['assessments'])) {
                                $existingAssessmentIds = $module->assessments()->pluck('id')->toArray();
                                $updatedAssessmentIds = [];

                                foreach ($moduleData['assessments'] as $assessmentData) {
                                    $assessment = $module->assessments()->updateOrCreate(
                                        ['id' => $assessmentData['id'] ?? null],
                                        Arr::except($assessmentData, ['id', 'group_indicators'])
                                    );
                                    $updatedAssessmentIds[] = $assessment->id;

                                    // Handle group indicators
                                    if (isset($assessmentData['group_indicators'])) {
                                        $existingGroupIndicatorIds = $assessment->groupIndicators()->pluck('id')->toArray();
                                        $updatedGroupIndicatorIds = [];

                                        foreach ($assessmentData['group_indicators'] as $groupIndicatorData) {
                                            $groupIndicator = $assessment->groupIndicators()->updateOrCreate(
                                                ['id' => $groupIndicatorData['id'] ?? null],
                                                Arr::except($groupIndicatorData, ['id', 'indicators'])
                                            );
                                            $updatedGroupIndicatorIds[] = $groupIndicator->id;

                                            // Handle indicators
                                            if (isset($groupIndicatorData['indicators'])) {
                                                $existingIndicatorIds = $groupIndicator->indicators()->pluck('id')->toArray();
                                                $updatedIndicatorIds = [];

                                                foreach ($groupIndicatorData['indicators'] as $indicatorData) {
                                                    $indicator = $groupIndicator->indicators()->updateOrCreate(
                                                        ['id' => $indicatorData['id'] ?? null],
                                                        Arr::except($indicatorData, ['id', 'sessions'])
                                                    );
                                                    $updatedIndicatorIds[] = $indicator->id;

                                                    // Handle sessions
                                                    if (isset($indicatorData['sessions'])) {
                                                        $existingSessionIds = $indicator->sessions()->pluck('id')->toArray();
                                                        $updatedSessionIds = [];

                                                        foreach ($indicatorData['sessions'] as $sessionData) {
                                                            $session = $indicator->sessions()->updateOrCreate(
                                                                ['id' => $sessionData['id'] ?? null],
                                                                Arr::except($sessionData, ['id', 'rubrics'])
                                                            );
                                                            $updatedSessionIds[] = $session->id;

                                                            // Handle rubrics
                                                            if (isset($sessionData['rubrics'])) {
                                                                $existingRubricIds = $session->rubrics()->pluck('id')->toArray();
                                                                $updatedRubricIds = [];

                                                                foreach ($sessionData['rubrics'] as $rubricData) {
                                                                    $rubric = $session->rubrics()->updateOrCreate(
                                                                        ['id' => $rubricData['id'] ?? null],
                                                                        $rubricData
                                                                    );
                                                                    $updatedRubricIds[] = $rubric->id;
                                                                }

                                                                // Delete rubrics not in the updated list
                                                                $rubricsToDelete = array_diff($existingRubricIds, $updatedRubricIds);
                                                                if (!empty($rubricsToDelete)) {
                                                                    $session->rubrics()->whereIn('id', $rubricsToDelete)->delete();
                                                                }
                                                            }
                                                        }

                                                        // Delete sessions not in the updated list
                                                        $sessionsToDelete = array_diff($existingSessionIds, $updatedSessionIds);
                                                        if (!empty($sessionsToDelete)) {
                                                            $indicator->sessions()->whereIn('id', $sessionsToDelete)->delete();
                                                        }
                                                    }
                                                }

                                                // Delete indicators not in the updated list
                                                $indicatorsToDelete = array_diff($existingIndicatorIds, $updatedIndicatorIds);
                                                if (!empty($indicatorsToDelete)) {
                                                    $groupIndicator->indicators()->whereIn('id', $indicatorsToDelete)->delete();
                                                }
                                            }
                                        }

                                        // Delete group indicators not in the updated list
                                        $groupIndicatorsToDelete = array_diff($existingGroupIndicatorIds, $updatedGroupIndicatorIds);
                                        if (!empty($groupIndicatorsToDelete)) {
                                            $assessment->groupIndicators()->whereIn('id', $groupIndicatorsToDelete)->delete();
                                        }
                                    }
                                }

                                // Delete assessments not in the updated list
                                $assessmentsToDelete = array_diff($existingAssessmentIds, $updatedAssessmentIds);
                                if (!empty($assessmentsToDelete)) {
                                    $module->assessments()->whereIn('id', $assessmentsToDelete)->delete();
                                }
                            }
                        }

                        // Delete modules not in the updated list
                        $modulesToDelete = array_diff($existingModuleIds, $updatedModuleIds);
                        if (!empty($modulesToDelete)) {
                            $phase->modules()->whereIn('id', $modulesToDelete)->delete();
                        }
                    }
                }

                // Delete phases not in the updated list
                $phasesToDelete = array_diff($existingPhaseIds, $updatedPhaseIds);
                if (!empty($phasesToDelete)) {
                    $trainingProgram->phases()->whereIn('id', $phasesToDelete)->delete();
                }
            }
        });

        return redirect()->route('office.qrd.training-program.index')
            ->with('success', 'Training program updated successfully');
    }

    /**
     * Remove the specified training program.
     */
    public function destroy($uuid)
    {
        $trainingProgram = TrainingProgram::where('uuid', $uuid)->firstOrFail();
        $trainingProgram->delete();
        return redirect()->route('office.qrd.training-program.index')
            ->with('success', 'Training program deleted successfully');
    }
    
    /**
     * Get phases for a training program
     */
    public function phases($uuid)
    {
        $program = TrainingProgram::where('uuid', $uuid)->firstOrFail();
        $phases = $program->phases()->orderBy('order')->get();
        return response()->json($phases);
    }
}
