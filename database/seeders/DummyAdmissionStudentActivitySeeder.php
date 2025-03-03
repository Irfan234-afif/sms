<?php

namespace Database\Seeders;

use App\Models\SchoolYear;
use App\Models\AdmissionStage;
use App\Models\AdmissionStudent;
use App\Models\Transaction;
use App\Models\Product;
use App\Models\Profile;
use App\Models\School;
use App\Models\Student;
use App\Models\StudentGuardian;
use App\Models\User;
use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Ramsey\Uuid\Uuid;

use function Pest\Laravel\json;

class DummyAdmissionStudentActivitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public $faker;

    public function run(): void
    {
        $options = json_decode(file_get_contents('database/data/default/options.json'));
        $questionnaires = json_decode(file_get_contents('database/data/default/questionnaires.json'));
        $this->faker = Factory::create();

        // Purchasing the admission form
        if (App::environment(['local', 'testing'])) {
            $customers = User::role(['System Admin', 'Site Admin', 'Guardian', 'Employee'])->get();
            $product = Product::where('code', 'ADMISSION_STUDENT_FORM')->first();

            $this->command->warn('Purchasing the admission form');
            $this->command->getOutput()->progressStart(count($customers));
            foreach ($customers as $customer) {
                DB::beginTransaction();

                try {
                    foreach (range(1, rand(100, 250)) as $index) {
                        $transaction = Transaction::create([
                            'customer_id' => $customer->id,
                            'type' => 'SALES',
                            'sub_type' => 'ADMISSION_STUDENT_FORM',
                            'reference_number' => 'TRX-ASF-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                            'due_date' => now()->addDays(3),
                            'total_amount' => $product->price,
                            'discount_amount' => 0,
                            'bill_amount' => $product->price,
                        ]);

                        $school = School::inRandomOrder()->first();
                        $school_year = SchoolYear::inRandomOrder()->first();
                        $school_grade = $school->level->grades()->inRandomOrder()->first();
                        $module = [
                            'name' => $this->faker->name,
                            'birth_date' => $this->faker->date,
                            'school_id' => $school->id,
                            'school_year_id' => $school_year->id,
                            'school_grade_id' => $school_grade->id,
                        ];

                        $transaction->items()->create([
                            'product_id' => $product->id,
                            'price' => $product->price,
                            'quantity' => 1,
                            'total_amount' => $product->price,
                            'bill_amount' => $product->price,
                            'options' => [
                                'module' => $module
                            ],
                        ]);

                        $payment_status = ['PAID', 'UNPAID'];

                        $transaction->payments()->create([
                            'reference_number' => 'TRX-CUST-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                            'type' => 'ONLINE',
                            'amount' => $transaction->bill_amount,
                            'options' => [
                                'gateway_provider' => 'MIDTRANS',
                                'gateway_token' => Str::random(20),
                                'gateway_response' => null,
                            ],
                            'status' => Arr::random($payment_status),
                        ]);

                        $paid_amount = $transaction->payments()->where('status', 'PAID')->sum('amount');
                        $transaction->paid_amount = $paid_amount;
                        $transaction->save();
                    }

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Submitting the admission form
        if (App::environment(['local', 'testing'])) {
            $transactions = Transaction::whereColumn('bill_amount', '=', 'paid_amount')
                ->where('type', 'SALES')
                ->where('sub_type', 'ADMISSION_STUDENT_FORM')
                ->get();

            $this->command->warn('Submitting the admission form');
            $this->command->getOutput()->progressStart(count($transactions));
            foreach ($transactions as $transaction) {
                DB::beginTransaction();

                try {
                    $admission_status = ['NEW', 'DRAFT', 'PENDING', 'PENDING', 'PENDING'];
                    $admission_status_selected = Arr::random($admission_status);
                    $module = $transaction->items()->first() ? $transaction->items()->first()->options['module'] : null;

                    $admission_student = AdmissionStudent::create([
                        'transaction_id' => $transaction->id,
                        'school_id' => $module['school_id'],
                        'school_year_id' => $module['school_year_id'],
                        'school_grade_id' => $module['school_grade_id'],
                        'registration_number' => 'ADM-' . now()->format('YmdHis') . '-' . Str::upper(Str::random(6)),
                        'name' => $module['name'],
                        'birth_place' => $this->faker->city,
                        'birth_date' => $module['birth_date'],
                        'gender' => $this->faker->randomElement(['MALE', 'FEMALE']),
                        'blood_type' => $this->faker->randomElement(['A', 'B', 'AB', 'O']),
                        'religion' => $this->faker->randomElement($options->religions),
                        'languages' => [$this->faker->randomElement(['Indonesian', 'English', 'Mandarin', 'Javanese'])],
                        'phone' => $this->faker->phoneNumber,
                        'address' => $this->faker->address,
                        'postal_code' => $this->faker->postcode,
                        'previous_school' => $this->faker->company,
                        'father_name' => $this->faker->name('male'),
                        'father_birth_place' => $this->faker->city,
                        'father_birth_date' => $this->faker->date,
                        'father_religion' => $this->faker->randomElement($options->religions),
                        'father_languages' => [$this->faker->randomElement(['Indonesian', 'English', 'Mandarin', 'Javanese'])],
                        'father_phone' => $this->faker->phoneNumber,
                        'father_email' => $this->faker->safeEmail,
                        'father_address' => $this->faker->address,
                        'father_occupation' => $this->faker->jobTitle,
                        'father_company' => $this->faker->company,
                        'father_position' => $this->faker->jobTitle,
                        'father_national_id' => $this->faker->numerify('################'),
                        'mother_name' => $this->faker->name('female'),
                        'mother_birth_place' => $this->faker->city,
                        'mother_birth_date' => $this->faker->date,
                        'mother_religion' => $this->faker->randomElement($options->religions),
                        'mother_languages' => [$this->faker->randomElement(['Indonesian', 'English', 'Mandarin', 'Javanese'])],
                        'mother_phone' => $this->faker->phoneNumber,
                        'mother_email' => $this->faker->safeEmail,
                        'mother_address' => $this->faker->address,
                        'mother_occupation' => $this->faker->jobTitle,
                        'mother_company' => $this->faker->company,
                        'mother_position' => $this->faker->jobTitle,
                        'mother_national_id' => $this->faker->numerify('################'),
                        'emergency_name' => $this->faker->name,
                        'emergency_phone' => $this->faker->phoneNumber,
                        'emergency_home_phone' => $this->faker->phoneNumber,
                        'emergency_relation' => $this->faker->randomElement(['UNCLE', 'AUNT', 'GRANDPARENT', 'SIBLING']),
                        'need_vehicle' => $this->faker->boolean,
                        'responsible_fee' => $this->faker->randomElement(['FATHER', 'MOTHER', 'OTHER']),
                        'payer_name' => $this->faker->name,
                        'payer_home_phone' => $this->faker->phoneNumber,
                        'payer_phone' => $this->faker->phoneNumber,
                        'payer_email' => $this->faker->safeEmail,
                        'payer_relation' => $this->faker->randomElement(['FATHER', 'MOTHER', 'OTHER']),
                        'payer_address' => $this->faker->address,
                        'payer_company' => $this->faker->company,
                        'payer_company_letter' => $this->faker->boolean,
                        'health_info_remark' => $this->faker->sentence,
                        'health_relate_family' => $this->faker->sentence,
                        'use_insurance' => $this->faker->boolean,
                        'insurance_name' => $this->faker->company,
                        'insurance_network' => $this->faker->word,
                        'recomended_hospital' => $this->faker->company,
                        'doctor_name' => $this->faker->name,
                        'families' => [],
                        'questionnaires' => $questionnaires,
                        'school_info_sources' => $this->faker->randomElement($options->schoolInformationSources),
                        'status' => $admission_status_selected,
                    ]);

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Verifying the admission student
        if (App::environment(['local', 'testing'])) {
            $admission_students = AdmissionStudent::where('status', 'PENDING')->get();

            $this->command->warn('Verifying the admission student');
            $this->command->getOutput()->progressStart(count($admission_students));
            foreach ($admission_students as $admission_student) {
                DB::beginTransaction();

                try {
                    $isVerifying = rand(0, 1);

                    if ($isVerifying) {
                        $admission_student_status = Arr::random(['VERIFIED', 'VERIFIED', 'VERIFIED', 'UNVERIFIED']);

                        $admission_student->update([
                            'submitted_at' => $admission_student_status == 'VERIFIED' ? now()->addDays(rand(3, 5)) : null,
                            'status' => $admission_student_status,
                        ]);

                        if ($admission_student_status == 'VERIFIED') {
                            $admission_stages = AdmissionStage::whereHasMorph('model', School::class, function ($school) use ($admission_student) {
                                $school->where('id', $admission_student->school_id);
                            })->get();

                            foreach ($admission_stages as $admission_stage) {
                                $admission_student->stages()->create([
                                    'admission_stage_id' => $admission_stage->id,
                                    'admission_stage_status_id' => $admission_stage->statuses()->inRandomOrder()->first()->id,
                                    'scheduled_at' => now()->addDays(10 + $admission_stage->sort_number),
                                    'description' => $this->faker->sentence,
                                ]);
                            }
                        }
                    }

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Accepting the admission student
        if (App::environment(['local', 'testing'])) {
            $admission_students = AdmissionStudent::where('status', 'VERIFIED')->get();

            $this->command->warn('Accepting the admission student');
            $this->command->getOutput()->progressStart(count($admission_students));
            foreach ($admission_students as $admission_student) {
                DB::beginTransaction();

                try {
                    $isAccepting = rand(0, 1);
                    if ($isAccepting) {
                        $admission_student_status = Arr::random(['ACCEPTED', 'ACCEPTED', 'ACCEPTED', 'REJECTED']);

                        $admission_student->update([
                            'status' => $admission_student_status,
                        ]);

                        foreach ($admission_student->stages as $admission_student_stage) {
                            $admission_student_stage->update([
                                'admission_stage_status_id' => $admission_student_stage->admission_stage->statuses()->inRandomOrder()->first()->id
                            ]);
                        }
                    }
                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
        // Enrolling the admission student
        if (App::environment(['local', 'testing'])) {
            $admission_students = AdmissionStudent::where('status', 'ACCEPTED')->get();

            $this->command->warn('Enrolling the admission student');
            $this->command->getOutput()->progressStart(count($admission_students));
            foreach ($admission_students as $admission_student) {
                DB::beginTransaction();

                try {
                    $isEnrolled = rand(0, 1);

                    if ($isEnrolled) {
                        $admission_student->update([
                            'status' => 'ENROLLED',
                        ]);


                        $profile_created = Profile::create([
                            'name' => $admission_student->name,
                            'birth_place' => $admission_student->birth_place,
                            'birth_date' => $admission_student->birth_date,
                            'gender' => $admission_student->gender,
                            'blood_type' => $admission_student->blood_type,
                            'religion' => $admission_student->religion,
                            'phone' => $admission_student->phone,
                            'address' => $admission_student->address,
                            'postal_code' => $admission_student->postal_code,
                        ]);

                        $student_created = Student::firstOrCreate([
                            'profile_id' => $profile_created->id,
                        ], [
                            'school_id' => $admission_student->school_id,
                            'school_grade_id' => $admission_student->school_grade_id,
                            'school_national_id' => $this->faker->numerify('STD-######################')
                        ]);

                        StudentGuardian::create([
                            'student_id' => $student_created->id,
                            'guardian_id' => $admission_student->transaction->customer_id,
                        ]);
                    }

                    DB::commit();
                } catch (\Throwable $th) {
                    DB::rollBack();

                    throw $th;
                }
                $this->command->getOutput()->progressAdvance();
            }
            $this->command->getOutput()->progressFinish();
        }
    }
}
