<?php

namespace App\Traits;

use Ramsey\Uuid\Uuid as RamseyUuid;

trait GenerateUuid
{
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($model) {
            try {
                $model->uuid = RamseyUuid::uuid1();
            } catch (\Throwable $h) {
                abort(500, $h->getMessage());
            }
        });
    }
}
