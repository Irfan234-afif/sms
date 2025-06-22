<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use App\Models\TrainingProgram\TrainingProgram;
use App\Models\TrainingProgram\TrainingProgramPhase;
use App\Models\TrainingProgram\PhaseModule;
use App\Models\TrainingProgram\PhaseModuleMaterial;
use App\Models\TrainingProgram\PhaseModuleQuiz;
use App\Models\TrainingProgram\PhaseModuleQuizQuestion;
use App\Models\TrainingProgram\PhaseModuleQuizQuestionOption;
use App\Models\TrainingProgram\ModuleAssessment;
use App\Models\TrainingProgram\AssessmentGroupIndicator;
use App\Models\TrainingProgram\AssessmentIndicator;
use App\Models\TrainingProgram\AssessmentIndicatorSession;
use App\Models\TrainingProgram\AssessmentIndicatorSessionRubric;

class TrainingProgramSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->clearExistingData();
        $programs = $this->createTrainingPrograms();
        $this->command->info('Training programs created successfully!');
    }
    
    private function clearExistingData()
    {
        // Clear only training program related tables
        DB::table('assessment_indicator_sessions')->delete();
        DB::table('assessment_indicators')->delete();
        DB::table('assessment_group_indicators')->delete();
        DB::table('module_assessments')->delete();
        DB::table('phase_module_quiz_question_options')->delete();
        DB::table('phase_module_quiz_questions')->delete();
        DB::table('phase_module_quizzes')->delete();
        DB::table('phase_module_materials')->delete();
        DB::table('phase_modules')->delete();
        DB::table('training_program_phases')->delete();
        DB::table('training_programs')->delete();
    }
    
    private function createTrainingPrograms()
    {
        $programs = [];
        
        // Program 1: Leadership Development (Comprehensive)
        $program1 = TrainingProgram::create([
            'name' => 'Program Pengembangan Kepemimpinan Komprehensif',
            'type' => 'internal',
            'level' => 'intermediate',
            'description' => 'Program komprehensif untuk mengembangkan kemampuan kepemimpinan karyawan dengan fokus pada manajemen tim, komunikasi efektif, pengambilan keputusan strategis, dan transformasi organisasi.',
            'status' => 'active'
        ]);

        $this->createLeadershipProgram($program1);
        $programs[] = $program1;
        
        // Program 2: Digital Transformation & Technology
        $program2 = TrainingProgram::create([
            'name' => 'Program Transformasi Digital & Teknologi',
            'type' => 'internal',
            'level' => 'advanced',
            'description' => 'Program pelatihan komprehensif untuk mempersiapkan karyawan menghadapi era digital dengan pemahaman teknologi terkini, metodologi agile, dan inovasi digital.',
            'status' => 'active'
        ]);

        $this->createDigitalTransformationProgram($program2);
        $programs[] = $program2;
        
        // Program 3: Customer Service Excellence
        $program3 = TrainingProgram::create([
            'name' => 'Program Keunggulan Layanan Pelanggan',
            'type' => 'internal',
            'level' => 'beginner',
            'description' => 'Program untuk meningkatkan kualitas layanan pelanggan dengan fokus pada komunikasi efektif, penanganan keluhan, membangun loyalitas pelanggan, dan customer experience management.',
            'status' => 'active'
        ]);

        $this->createCustomerServiceProgram($program3);
        $programs[] = $program3;

        // Program 4: Project Management Professional
        $program4 = TrainingProgram::create([
            'name' => 'Program Manajemen Proyek Profesional',
            'type' => 'external',
            'level' => 'advanced',
            'description' => 'Program pelatihan manajemen proyek yang mengikuti standar PMI dengan fokus pada planning, execution, monitoring, dan closing proyek secara efektif.',
            'status' => 'active'
        ]);

        $this->createProjectManagementProgram($program4);
        $programs[] = $program4;

        // Program 5: Sales & Marketing Excellence
        $program5 = TrainingProgram::create([
            'name' => 'Program Keunggulan Penjualan & Pemasaran',
            'type' => 'internal',
            'level' => 'intermediate',
            'description' => 'Program komprehensif untuk meningkatkan kemampuan penjualan dan pemasaran dengan fokus pada digital marketing, sales technique, dan customer relationship management.',
            'status' => 'active'
        ]);

        $this->createSalesMarketingProgram($program5);
        $programs[] = $program5;
        
        return $programs;
    }

    private function createLeadershipProgram($program)
    {
        // Phase 1: Leadership Fundamentals
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Leadership Fundamentals',
            'description' => 'Memahami dasar-dasar kepemimpinan dan teori-teori kepemimpinan modern',
            'order' => 1,
            'status' => 'active'
        ]);

        // Module 1.1: Introduction to Leadership
        $module1_1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Introduction to Leadership',
            'description' => 'Pengenalan konsep dasar kepemimpinan dan gaya kepemimpinan',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_1, [
            ['title' => 'Definisi dan Teori Kepemimpinan', 'type' => 'text', 'content' => '<h2>Kepemimpinan dalam Organisasi Modern</h2><p>Kepemimpinan adalah proses mempengaruhi orang lain untuk mencapai tujuan bersama melalui visi yang jelas, komunikasi efektif, dan motivasi yang berkelanjutan...</p>'],
            ['title' => 'Video: Great Leaders in History', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=leadership_history'],
            ['title' => 'Leadership Styles Comparison', 'type' => 'document', 'content' => '/documents/leadership-styles.pdf'],
            ['title' => 'Leadership Self-Assessment Tool', 'type' => 'link', 'content' => 'https://assessment.leadership.com/self-eval']
        ]);

        $this->createQuiz($module1_1, 'Basic Leadership Quiz', 'Test pemahaman dasar kepemimpinan', [
            [
                'question' => 'Apa yang dimaksud dengan kepemimpinan transformasional?',
                'type' => 'multiple_choice',
                'options' => [
                    ['text' => 'Gaya kepemimpinan yang fokus pada inspirasi dan motivasi', 'is_correct' => true],
                    ['text' => 'Gaya kepemimpinan yang hanya fokus pada hasil', 'is_correct' => false],
                    ['text' => 'Gaya kepemimpinan yang otoriter', 'is_correct' => false],
                    ['text' => 'Gaya kepemimpinan yang pasif', 'is_correct' => false]
                ]
            ],
            [
                'question' => 'Manakah yang termasuk karakteristik pemimpin yang efektif?',
                'type' => 'multiple_choice',
                'options' => [
                    ['text' => 'Memiliki visi yang jelas', 'is_correct' => true],
                    ['text' => 'Selalu mengambil keputusan sendiri', 'is_correct' => false],
                    ['text' => 'Menghindari konflik', 'is_correct' => false],
                    ['text' => 'Fokus pada kontrol ketat', 'is_correct' => false]
                ]
            ],
            [
                'question' => 'Apa perbedaan utama antara manager dan leader?',
                'type' => 'multiple_choice',
                'options' => [
                    ['text' => 'Manager mengelola proses, leader menginspirasi visi', 'is_correct' => true],
                    ['text' => 'Manager lebih senior dari leader', 'is_correct' => false],
                    ['text' => 'Tidak ada perbedaan', 'is_correct' => false],
                    ['text' => 'Leader selalu lebih baik dari manager', 'is_correct' => false]
                ]
            ]
        ]);

        $this->createAssessment($module1_1, 'Leadership Style Assessment', 'Penilaian praktik gaya kepemimpinan dalam simulasi', [
            [
                'name' => 'Communication Skills',
                'description' => 'Kemampuan berkomunikasi efektif sebagai pemimpin',
                'indicators' => [
                    [
                        'name' => 'Active Listening',
                        'description' => 'Kemampuan mendengarkan secara aktif dan empati',
                        'sessions' => [
                            ['name' => 'Session 1: One-on-One Communication', 'description' => 'Praktik mendengarkan dalam percakapan individual'],
                            ['name' => 'Session 2: Team Discussion', 'description' => 'Praktik mendengarkan dalam diskusi tim']
                        ]
                    ],
                    [
                        'name' => 'Clear Communication',
                        'description' => 'Kemampuan menyampaikan pesan dengan jelas',
                        'sessions' => [
                            ['name' => 'Session 1: Presentation Skills', 'description' => 'Praktik presentasi yang efektif'],
                            ['name' => 'Session 2: Written Communication', 'description' => 'Praktik komunikasi tertulis']
                        ]
                    ]
                ]
            ],
            [
                'name' => 'Decision Making',
                'description' => 'Kemampuan mengambil keputusan yang tepat',
                'indicators' => [
                    [
                        'name' => 'Problem Analysis',
                        'description' => 'Kemampuan menganalisis masalah secara sistematis',
                        'sessions' => [
                            ['name' => 'Session 1: Case Study Analysis', 'description' => 'Analisis studi kasus bisnis'],
                            ['name' => 'Session 2: Root Cause Analysis', 'description' => 'Praktik analisis akar masalah']
                        ]
                    ]
                ]
            ]
        ], 'AVERAGE', 80); // Use AVERAGE calculation with 80 passing score

        // Module 1.2: Leadership Psychology
        $module1_2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Leadership Psychology & Emotional Intelligence',
            'description' => 'Memahami aspek psikologi dalam kepemimpinan dan emotional intelligence',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_2, [
            ['title' => 'Psychology of Leadership', 'type' => 'text', 'content' => '<h2>Psikologi Kepemimpinan</h2><p>Memahami aspek psikologi dalam kepemimpinan meliputi motivasi, persepsi, dan behavior modification...</p>'],
            ['title' => 'Emotional Intelligence in Leadership', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=emotional_intelligence'],
            ['title' => 'EQ Assessment Tool', 'type' => 'link', 'content' => 'https://eq-assessment.com/leader']
        ]);

        // Phase 2: Advanced Leadership Skills
        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Advanced Leadership Skills',
            'description' => 'Mengembangkan keterampilan kepemimpinan lanjutan untuk situasi kompleks',
            'order' => 2,
            'status' => 'active'
        ]);

        // Module 2.1: Strategic Leadership
        $module2_1 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Strategic Leadership & Vision Setting',
            'description' => 'Kepemimpinan strategis dan penetapan visi organisasi',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_1, [
            ['title' => 'Strategic Thinking for Leaders', 'type' => 'text', 'content' => '<h2>Strategic Thinking</h2><p>Strategic thinking adalah kemampuan untuk melihat gambaran besar dan merencanakan langkah-langkah jangka panjang...</p>'],
            ['title' => 'Vision Creation Workshop', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=vision_workshop'],
            ['title' => 'Strategic Planning Template', 'type' => 'document', 'content' => '/documents/strategic-planning-template.xlsx']
        ]);

        // Module 2.2: Change Management
        $module2_2 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Change Management & Innovation',
            'description' => 'Memimpin perubahan dan mendorong inovasi dalam organisasi',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_2, [
            ['title' => 'Leading Change: Kotter\'s 8-Step Process', 'type' => 'text', 'content' => '<h2>8 Langkah Kotter untuk Perubahan</h2><p>John Kotter mengidentifikasi 8 langkah kritis untuk memimpin perubahan yang sukses...</p>'],
            ['title' => 'Innovation Leadership Case Studies', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=innovation_cases'],
            ['title' => 'Change Readiness Assessment', 'type' => 'link', 'content' => 'https://change-assessment.com/readiness']
        ]);

        // Phase 3: Leadership in Practice
        $phase3 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Leadership in Practice',
            'description' => 'Aplikasi praktis kepemimpinan dalam berbagai situasi nyata',
            'order' => 3,
            'status' => 'active'
        ]);

        // Module 3.1: Team Leadership
        $module3_1 = PhaseModule::create([
            'training_program_phase_id' => $phase3->id,
            'name' => 'Team Leadership & Collaboration',
            'description' => 'Memimpin tim yang efektif dan mendorong kolaborasi',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module3_1, [
            ['title' => 'Building High-Performance Teams', 'type' => 'text', 'content' => '<h2>Tim Berkinerja Tinggi</h2><p>Karakteristik tim berkinerja tinggi meliputi trust, commitment, accountability...</p>'],
            ['title' => 'Team Dynamics Simulation', 'type' => 'link', 'content' => 'https://team-simulation.com/leadership'],
            ['title' => 'Conflict Resolution Techniques', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=conflict_resolution']
        ]);

        $this->createQuiz($module3_1, 'Team Leadership Quiz', 'Evaluasi pemahaman kepemimpinan tim', [
            [
                'question' => 'Apa karakteristik utama tim yang efektif?',
                'type' => 'multiple_choice',
                'options' => [
                    ['text' => 'Saling percaya dan komunikasi terbuka', 'is_correct' => true],
                    ['text' => 'Kompetisi internal yang ketat', 'is_correct' => false],
                    ['text' => 'Kontrol ketat dari leader', 'is_correct' => false],
                    ['text' => 'Fokus pada individual performance', 'is_correct' => false]
                ]
            ]
        ]);
    }

    private function createDigitalTransformationProgram($program)
    {
        // Phase 1: Digital Foundations
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Digital Foundations',
            'description' => 'Memahami dasar-dasar transformasi digital dan teknologi emerging',
            'order' => 1,
            'status' => 'active'
        ]);

        // Module 1.1: Digital Transformation Overview
        $module1_1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Digital Transformation Overview',
            'description' => 'Pengenalan komprehensif tentang transformasi digital',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_1, [
            ['title' => 'What is Digital Transformation?', 'type' => 'text', 'content' => '<h2>Transformasi Digital</h2><p>Transformasi digital adalah integrasi teknologi digital ke dalam semua area bisnis...</p>'],
            ['title' => 'Digital Trends 2024', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=digital2024'],
            ['title' => 'Digital Maturity Assessment', 'type' => 'link', 'content' => 'https://digital-maturity.com/assessment'],
            ['title' => 'Industry Case Studies', 'type' => 'document', 'content' => '/documents/digital-transformation-cases.pdf']
        ]);

        // Module 1.2: Emerging Technologies
        $module1_2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Emerging Technologies',
            'description' => 'Teknologi emerging: AI, IoT, Blockchain, Cloud Computing',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_2, [
            ['title' => 'Artificial Intelligence in Business', 'type' => 'text', 'content' => '<h2>AI dalam Bisnis</h2><p>Artificial Intelligence mengubah cara bisnis beroperasi...</p>'],
            ['title' => 'IoT Applications Demo', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=iot_demo'],
            ['title' => 'Blockchain Fundamentals', 'type' => 'link', 'content' => 'https://blockchain-demo.com/fundamentals']
        ]);

        // Phase 2: Digital Strategy & Implementation
        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Digital Strategy & Implementation',
            'description' => 'Strategi dan implementasi transformasi digital',
            'order' => 2,
            'status' => 'active'
        ]);

        // Module 2.1: Digital Strategy Planning
        $module2_1 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Digital Strategy Planning',
            'description' => 'Perencanaan strategi digital yang efektif',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_1, [
            ['title' => 'Digital Strategy Framework', 'type' => 'text', 'content' => '<h2>Framework Strategi Digital</h2><p>Framework untuk mengembangkan strategi digital yang komprehensif...</p>'],
            ['title' => 'Strategy Workshop Recording', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=strategy_workshop']
        ]);

        // Phase 3: Agile & Innovation
        $phase3 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Agile Methodology & Innovation',
            'description' => 'Metodologi agile dan mendorong inovasi digital',
            'order' => 3,
            'status' => 'active'
        ]);

        // Module 3.1: Agile Fundamentals
        $module3_1 = PhaseModule::create([
            'training_program_phase_id' => $phase3->id,
            'name' => 'Agile Fundamentals',
            'description' => 'Dasar-dasar metodologi agile dan scrum',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module3_1, [
            ['title' => 'Agile Manifesto & Principles', 'type' => 'text', 'content' => '<h2>Agile Manifesto</h2><p>4 nilai dan 12 prinsip agile...</p>'],
            ['title' => 'Scrum in Action', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=scrum_action']
        ]);
    }

    private function createCustomerServiceProgram($program)
    {
        // Phase 1: Customer Service Fundamentals
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Customer Service Fundamentals',
            'description' => 'Dasar-dasar layanan pelanggan yang excellent',
            'order' => 1,
            'status' => 'active'
        ]);

        // Module 1.1: Understanding Customer Needs
        $module1_1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Understanding Customer Needs',
            'description' => 'Memahami kebutuhan dan ekspektasi pelanggan',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_1, [
            ['title' => 'Customer Psychology', 'type' => 'text', 'content' => '<h2>Psikologi Pelanggan</h2><p>Memahami psikologi pelanggan adalah kunci untuk memberikan service yang excellent...</p>'],
            ['title' => 'Customer Journey Mapping', 'type' => 'link', 'content' => 'https://journey-mapping.com/tool'],
            ['title' => 'Service Recovery Strategies', 'type' => 'document', 'content' => '/documents/service-recovery.pdf']
        ]);

        // Module 1.2: Communication Excellence
        $module1_2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Communication Excellence',
            'description' => 'Komunikasi efektif dalam layanan pelanggan',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_2, [
            ['title' => 'Effective Communication Techniques', 'type' => 'text', 'content' => '<h2>Teknik Komunikasi Efektif</h2><p>Teknik komunikasi yang efektif dalam customer service...</p>'],
            ['title' => 'Handling Difficult Customers', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=difficult_customers']
        ]);

        // Phase 2: Advanced Customer Service
        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Advanced Customer Service',
            'description' => 'Teknik layanan pelanggan tingkat lanjut',
            'order' => 2,
            'status' => 'active'
        ]);

        // Module 2.1: Complaint Handling
        $module2_1 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Professional Complaint Handling',
            'description' => 'Menangani keluhan pelanggan secara profesional',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_1, [
            ['title' => 'Complaint Resolution Process', 'type' => 'text', 'content' => '<h2>Proses Resolusi Keluhan</h2><p>Langkah-langkah sistematis dalam menangani keluhan...</p>'],
            ['title' => 'De-escalation Techniques', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=deescalation']
        ]);

        // Phase 3: Customer Experience Management
        $phase3 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Customer Experience Management',
            'description' => 'Mengelola pengalaman pelanggan secara holistik',
            'order' => 3,
            'status' => 'active'
        ]);

        // Module 3.1: CX Strategy
        $module3_1 = PhaseModule::create([
            'training_program_phase_id' => $phase3->id,
            'name' => 'Customer Experience Strategy',
            'description' => 'Strategi pengalaman pelanggan yang menyeluruh',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module3_1, [
            ['title' => 'CX Strategy Framework', 'type' => 'text', 'content' => '<h2>Framework Strategi CX</h2><p>Framework untuk mengembangkan strategi customer experience...</p>'],
            ['title' => 'Customer Loyalty Programs', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=loyalty_programs']
        ]);
    }

    private function createProjectManagementProgram($program)
    {
        // Phase 1: Project Management Fundamentals
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Project Management Fundamentals',
            'description' => 'Dasar-dasar manajemen proyek berdasarkan PMI standards',
            'order' => 1,
            'status' => 'active'
        ]);

        // Module 1.1: Project Initiation
        $module1_1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Project Initiation & Charter',
            'description' => 'Inisiasi proyek dan pembuatan project charter',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_1, [
            ['title' => 'Project Charter Template', 'type' => 'document', 'content' => '/documents/project-charter-template.docx'],
            ['title' => 'Stakeholder Analysis', 'type' => 'text', 'content' => '<h2>Analisis Stakeholder</h2><p>Identifikasi dan analisis stakeholder proyek...</p>'],
            ['title' => 'Project Initiation Best Practices', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=project_initiation']
        ]);

        // Module 1.2: Project Planning
        $module1_2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Project Planning & Scheduling',
            'description' => 'Perencanaan proyek dan penjadwalan yang efektif',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_2, [
            ['title' => 'Work Breakdown Structure (WBS)', 'type' => 'text', 'content' => '<h2>Work Breakdown Structure</h2><p>WBS adalah dekomposisi hierarkis dari total scope of work...</p>'],
            ['title' => 'Critical Path Method', 'type' => 'link', 'content' => 'https://cpm-calculator.com/tool'],
            ['title' => 'Resource Planning', 'type' => 'document', 'content' => '/documents/resource-planning-template.xlsx']
        ]);

        // Phase 2: Project Execution & Control
        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Project Execution & Control',
            'description' => 'Eksekusi dan pengendalian proyek',
            'order' => 2,
            'status' => 'active'
        ]);

        // Module 2.1: Team Management
        $module2_1 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Project Team Management',
            'description' => 'Mengelola tim proyek yang efektif',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_1, [
            ['title' => 'Team Development Stages', 'type' => 'text', 'content' => '<h2>Tahap Pengembangan Tim</h2><p>Forming, Storming, Norming, Performing...</p>'],
            ['title' => 'Conflict Resolution in Projects', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=project_conflict']
        ]);

        // Phase 3: Project Closure & Lessons Learned
        $phase3 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Project Closure & Continuous Improvement',
            'description' => 'Penutupan proyek dan pembelajaran berkelanjutan',
            'order' => 3,
            'status' => 'active'
        ]);

        // Module 3.1: Project Closure
        $module3_1 = PhaseModule::create([
            'training_program_phase_id' => $phase3->id,
            'name' => 'Project Closure & Handover',
            'description' => 'Proses penutupan proyek dan handover',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module3_1, [
            ['title' => 'Project Closure Checklist', 'type' => 'document', 'content' => '/documents/closure-checklist.pdf'],
            ['title' => 'Lessons Learned Documentation', 'type' => 'text', 'content' => '<h2>Dokumentasi Lessons Learned</h2><p>Proses dokumentasi pembelajaran dari proyek...</p>']
        ]);
    }

    private function createSalesMarketingProgram($program)
    {
        // Phase 1: Sales Fundamentals
        $phase1 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Sales Fundamentals',
            'description' => 'Dasar-dasar penjualan dan teknik sales yang efektif',
            'order' => 1,
            'status' => 'active'
        ]);

        // Module 1.1: Sales Process
        $module1_1 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Sales Process & Methodology',
            'description' => 'Proses penjualan dan metodologi yang terstruktur',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_1, [
            ['title' => 'SPIN Selling Technique', 'type' => 'text', 'content' => '<h2>SPIN Selling</h2><p>Situation, Problem, Implication, Need-payoff questions...</p>'],
            ['title' => 'Sales Funnel Management', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=sales_funnel'],
            ['title' => 'CRM Best Practices', 'type' => 'link', 'content' => 'https://crm-demo.com/sales']
        ]);

        // Module 1.2: Customer Relationship Building
        $module1_2 = PhaseModule::create([
            'training_program_phase_id' => $phase1->id,
            'name' => 'Customer Relationship Building',
            'description' => 'Membangun hubungan yang kuat dengan pelanggan',
            'order' => 2,
            'status' => 'active'
        ]);

        $this->createMaterials($module1_2, [
            ['title' => 'Relationship Selling Approach', 'type' => 'text', 'content' => '<h2>Relationship Selling</h2><p>Pendekatan penjualan berbasis hubungan jangka panjang...</p>'],
            ['title' => 'Trust Building Techniques', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=trust_building']
        ]);

        // Phase 2: Digital Marketing
        $phase2 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Digital Marketing Mastery',
            'description' => 'Penguasaan digital marketing dan strategi online',
            'order' => 2,
            'status' => 'active'
        ]);

        // Module 2.1: Social Media Marketing
        $module2_1 = PhaseModule::create([
            'training_program_phase_id' => $phase2->id,
            'name' => 'Social Media Marketing',
            'description' => 'Strategi pemasaran media sosial yang efektif',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module2_1, [
            ['title' => 'Social Media Strategy Framework', 'type' => 'text', 'content' => '<h2>Framework Strategi Media Sosial</h2><p>Langkah-langkah mengembangkan strategi media sosial...</p>'],
            ['title' => 'Content Creation Tools', 'type' => 'link', 'content' => 'https://content-tools.com/demo'],
            ['title' => 'Social Media Analytics', 'type' => 'document', 'content' => '/documents/social-media-metrics.xlsx']
        ]);

        // Phase 3: Advanced Sales & Marketing
        $phase3 = TrainingProgramPhase::create([
            'training_program_id' => $program->id,
            'name' => 'Advanced Sales & Marketing Integration',
            'description' => 'Integrasi lanjutan antara sales dan marketing',
            'order' => 3,
            'status' => 'active'
        ]);

        // Module 3.1: Sales & Marketing Alignment
        $module3_1 = PhaseModule::create([
            'training_program_phase_id' => $phase3->id,
            'name' => 'Sales & Marketing Alignment',
            'description' => 'Menyelaraskan strategi sales dan marketing',
            'order' => 1,
            'status' => 'active'
        ]);

        $this->createMaterials($module3_1, [
            ['title' => 'Smarketing Strategy', 'type' => 'text', 'content' => '<h2>Sales + Marketing Alignment</h2><p>Strategi menyelaraskan sales dan marketing untuk hasil optimal...</p>'],
            ['title' => 'Lead Qualification Process', 'type' => 'video', 'content' => 'https://www.youtube.com/watch?v=lead_qualification']
        ]);
    }

    private function createMaterials($module, $materials)
    {
        foreach ($materials as $index => $material) {
            PhaseModuleMaterial::create([
                'phase_module_id' => $module->id,
                'title' => $material['title'],
                'type' => $material['type'],
                'content' => $material['content'],
                'order' => $index + 1,
                'status' => 'active'
            ]);
        }
    }

    private function createQuiz($module, $title, $description, $questions)
    {
        $quiz = PhaseModuleQuiz::create([
            'phase_module_id' => $module->id,
            'title' => $title,
            'description' => $description,
            'passing_score' => 70,
            'status' => 'active'
        ]);

        foreach ($questions as $index => $questionData) {
            $question = PhaseModuleQuizQuestion::create([
                'phase_module_quiz_id' => $quiz->id,
                'question' => $questionData['question'],
                'type' => $questionData['type'],
                'points' => 10,
                'order' => $index + 1
            ]);

            if ($questionData['type'] === 'multiple_choice') {
                foreach ($questionData['options'] as $optionIndex => $optionData) {
                    PhaseModuleQuizQuestionOption::create([
                        'phase_module_quiz_question_id' => $question->id,
                        'option_text' => $optionData['text'],
                        'is_correct' => $optionData['is_correct'],
                        'order' => $optionIndex + 1
                    ]);
                }
            }
        }
    }

    private function createAssessment($module, $title, $description, $groupIndicators, $calculationMethod = 'AVERAGE', $passingScore = 70)
    {
        $assessment = ModuleAssessment::create([
            'phase_module_id' => $module->id,
            'title' => $title,
            'description' => $description,
            'calculation_method' => $calculationMethod,
            'passing_score' => $passingScore,
            'status' => 'active',
            'order' => 1
        ]);

        foreach ($groupIndicators as $groupIndex => $groupData) {
            $groupIndicator = AssessmentGroupIndicator::create([
                'module_assessment_id' => $assessment->id,
                'name' => $groupData['name'],
                'description' => $groupData['description'],
                'order' => $groupIndex + 1
            ]);

            foreach ($groupData['indicators'] as $indicatorIndex => $indicatorData) {
                $indicator = AssessmentIndicator::create([
                    'assessment_group_indicator_id' => $groupIndicator->id,
                    'name' => $indicatorData['name'],
                    'description' => $indicatorData['description'],
                    'order' => $indicatorIndex + 1
                ]);

                foreach ($indicatorData['sessions'] as $sessionIndex => $sessionData) {
                    $session = AssessmentIndicatorSession::create([
                        'assessment_indicator_id' => $indicator->id,
                        'name' => $sessionData['name'],
                        'description' => $sessionData['description'],
                        'order' => $sessionIndex + 1
                    ]);

                    // Create default rubrics for each session
                    $this->createDefaultRubrics($session);
                }
            }
        }
    }

    /**
     * Create default rubrics for a session.
     */
    private function createDefaultRubrics($session)
    {
        $defaultRubrics = [
            ['level' => 'Excellent', 'description' => 'Sangat baik, melebihi ekspektasi', 'score' => 95, 'order' => 1],
            ['level' => 'Good', 'description' => 'Baik, memenuhi ekspektasi', 'score' => 85, 'order' => 2],
            ['level' => 'Satisfactory', 'description' => 'Cukup, memenuhi standar minimum', 'score' => 75, 'order' => 3],
            ['level' => 'Needs Improvement', 'description' => 'Perlu perbaikan, di bawah standar', 'score' => 65, 'order' => 4],
            ['level' => 'Poor', 'description' => 'Kurang, jauh di bawah standar', 'score' => 50, 'order' => 5],
        ];

        foreach ($defaultRubrics as $rubricData) {
            AssessmentIndicatorSessionRubric::create([
                'assessment_indicator_session_id' => $session->id,
                'level' => $rubricData['level'],
                'description' => $rubricData['description'],
                'score' => $rubricData['score'],
                'order' => $rubricData['order'],
            ]);
        }
    }
}
