<?php

namespace App\Console\Commands;

use App\Models\SubmissionGroup;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class UpdateSubmissionGroups extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'submission-groups:update';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Update submission groups from JSON file without changing existing data';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Starting submission groups update...');
        
        $jsonPath = database_path('data/default/submission_group.json');
        
        if (!file_exists($jsonPath)) {
            $this->error('Submission group JSON file not found at: ' . $jsonPath);
            return 1;
        }
        
        $submissionGroups = json_decode(file_get_contents($jsonPath), true);
        
        if (json_last_error() !== JSON_ERROR_NONE) {
            $this->error('Error parsing JSON file: ' . json_last_error_msg());
            return 1;
        }
        
        $created = 0;
        $existing = 0;
        
        $this->info('Processing ' . count($submissionGroups) . ' submission groups...');
        $this->newLine();
        
        $progressBar = $this->output->createProgressBar(count($submissionGroups));
        $progressBar->start();
        
        foreach ($submissionGroups as $submissionGroupData) {
            DB::beginTransaction();
            
            try {
                // Check if submission group already exists
                $existingGroup = SubmissionGroup::where('code', $submissionGroupData['code'])->first();
                
                if ($existingGroup) {
                    $existing++;
                    $this->line("\n<comment>Skipped:</comment> {$submissionGroupData['name']} (already exists)");
                } else {
                    // Create new submission group
                    SubmissionGroup::create([
                        'name' => $submissionGroupData['name'],
                        'code' => $submissionGroupData['code'],
                        'reference_code' => $submissionGroupData['reference_code'],
                        'reference_number' => $submissionGroupData['reference_number'],
                    ]);
                    
                    $created++;
                    $this->line("\n<info>Created:</info> {$submissionGroupData['name']}");
                }
                
                DB::commit();
                $progressBar->advance();
                
            } catch (\Throwable $th) {
                DB::rollBack();
                $this->error("\nError processing submission group: {$submissionGroupData['name']}");
                $this->error($th->getMessage());
                return 1;
            }
        }
        
        $progressBar->finish();
        
        $this->newLine(2);
        $this->info('Submission groups update completed!');
        $this->table(
            ['Status', 'Count'],
            [
                ['Created', $created],
                ['Already Exists', $existing],
                ['Total Processed', count($submissionGroups)],
            ]
        );
        
        return 0;
    }
} 