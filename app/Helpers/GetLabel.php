<?php

namespace App\Helpers;

class GetLabel
{
    private static $labels;

    private function __construct() {}

    private static function loadLabels()
    {
        if (self::$labels === null) {
            $filePath = app_path('Helpers/labels.json');
            if (file_exists($filePath)) {
                self::$labels = json_decode(file_get_contents($filePath), true);
            } else {
                self::$labels = [];
            }
        }
    }

    public static function get($category, $value)
    {
        self::loadLabels();

        if (isset(self::$labels[$category])) {
            foreach (self::$labels[$category] as $item) {
                if ($item['value'] === $value) {
                    return $item['label'];
                }
            }
        }

        return $value;
    }

    public static function gender($value)
    {
        return self::get('genders', $value);
    }

    public static function religion($value)
    {
        return self::get('religions', $value);
    }

    public static function achievementType($value)
    {
        return self::get('achievementTypes', $value);
    }

    public static function testimonialType($value)
    {
        return self::get('testimonialTypes', $value);
    }

    public static function discountType($value)
    {
        return self::get('discountTypes', $value);
    }
}
