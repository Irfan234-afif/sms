<?php

namespace App\Http\Resources\AssessmentActivity;

use App\Models\AssessmentThreshold;
use App\Models\AssessmentThresholdScale;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AssessmentFinalResultResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $assessment_threshold = AssessmentThreshold::whereHas('module', function ($module) {
            $module->where('uuid', $this->final_rule?->module?->uuid);
        })->first();
        $threshold_scale_passed_options = [];
        $threshold_scale_failed_options = [];

        if ($assessment_threshold) {
            $threshold_scale_passed_options = $assessment_threshold->scales()->where('status', 'PASSED')->get();
            $threshold_scale_failed_options = $assessment_threshold->scales()->where('status', 'FAILED')->get();
        }

        return [
            'uuid' => $this->uuid,
            'final_rule_name' => $this->final_rule->name,
            'sort_order' => $this->final_rule->sort_order,
            'use_score' => (bool) $this->final_rule->use_score,
            'score_method' => $this->final_rule->score_method,
            'use_predicate' => (bool) $this->final_rule->use_predicate,
            'predicate_method' => $this->final_rule->predicate_method,
            'use_narrative' => (bool) $this->final_rule->use_narrative,
            'narrative_method' => $this->final_rule->narrative_method,
            'raw_score' =>  $this->raw_score ?  (float)  $this->raw_score : null,
            'final_score' =>  $this->final_score ?  (float) $this->final_score : null,
            'threshold_scale_passed_options' =>  AssessmentThresholdResource::collection($threshold_scale_passed_options),
            'threshold_scale_passed_id' => $this->threshold_scale_passed ? $this->threshold_scale_passed->uuid : null,
            'threshold_scale_failed_options' =>  AssessmentThresholdResource::collection($threshold_scale_failed_options),
            'threshold_scale_failed_id' => $this->threshold_scale_failed ? $this->threshold_scale_failed->uuid : null,
            'learning_objective_passed_options' => [],
            'learning_objective_passed_id' => $this->learning_objective_passed ? $this->learning_objective_passed->uuid : null,
            'learning_objective_failed_options' => [],
            'learning_objective_failed_id' => $this->learning_objective_failed ? $this->learning_objective_failed->uuid : null,
            'predicate_passed' => $this->predicate_passed,
            'predicate_failed' => $this->predicate_failed,
            'final_predicate' => $this->final_predicate,
            'narrative_passed' => $this->narrative_passed,
            'narrative_failed' => $this->narrative_failed,
            'final_narrative' => $this->final_narrative,
            // rules
            'rule_scores' => AssessmentRuleScoreResource::collection($this->final_rule->scores),
            'rule_narratives' => AssessmentRuleNarrativeResource::collection($this->final_rule->narratives),
        ];
    }
}
