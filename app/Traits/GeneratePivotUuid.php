<?php

namespace App\Traits;

use Ramsey\Uuid\Uuid as RamseyUuid;

trait GeneratePivotUuid
{
    public function syncWithUuid($relation, array $ids)
    {
        $pivotData = collect($ids)->mapWithKeys(function ($id) {
            return [$id => ['uuid' => RamseyUuid::uuid1()]];
        })->toArray();

        return $this->{$relation}()->sync($pivotData);
    }
}
