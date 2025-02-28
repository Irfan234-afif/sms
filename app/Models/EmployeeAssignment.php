<?php

namespace App\Models;

use App\Traits\GenerateUuid;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class EmployeeAssignment extends Model
{
    use GenerateUuid, SoftDeletes;

    protected $fillable = [
        'employee_id',
        'area_id',
        'position_id',
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class, 'employee_id');
    }

    public function area()
    {
        return $this->belongsTo(Area::class, 'area_id');
    }

    public function position()
    {
        return $this->belongsTo(Position::class, 'position_id');
    }
}
