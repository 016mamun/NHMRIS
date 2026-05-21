class PregnancyRegistrationModel {
  // ══════════════════════════════════════════════════════════════
  // ── Image 1 & 3: গর্ভবতীর তথ্য ফরম (Form Fields 1–38)
  // ══════════════════════════════════════════════════════════════

  // 01–12: Basic Mother Info
  String? motherName;          // 01
  String? coupleNumber;        // 02
  String? nidOrBirthReg;       // 03
  String? mcId;                // 04
  String? motherProfession;    // 05
  String? motherEducation;     // 06
  String? motherMobile;        // 07
  String? motherAge;           // 08
  String? motherHeight;        // 09
  String? motherWeight;        // 10
  String? motherBloodGroup;    // 11
  String? husbandBloodGroup;   // 12
  String? photoPath;           // ছবি (Photo from Image 3 booklet)

  // 13–18: Husband Info
  String? husbandName;         // 13
  String? husbandAge;          // 14
  String? husbandProfession;   // 15
  String? husbandEducation;    // 16
  String? husbandIncome;       // 17
  String? husbandMobile;       // 18

  // 19–24: Address
  String? village;             // 19
  String? ward;                // 20
  String? unit;                // 21
  String? union;               // 22
  String? upazila;             // 23
  String? zila;                // 24

  // 25–34: Pregnancy & Delivery Plan
  String? gravida;                   // 25. কততম গর্ভ
  String? livingChildren;            // 26. জীবিত সন্তানের সংখ্যা
  String? lastChildAge;              // 27. শেষ সন্তানের বয়স
  String? previousCSection;          // 28. পূর্বে সিজারের সংখ্যা
  String? previousNormalDelivery;    // 29. পূর্বে নরমাল ডেলিভারির সংখ্যা
  String? lmp;                       // 30. শেষ মাসিকের তারিখ (LMP)
  String? edd;                       // 31. প্রসবের সম্ভাব্য তারিখ (EDD)
  bool? isEligibleForAllowance;      // 32. গর্ভবতী ভাতা পাওয়ার যোগ্য কি না
  String? preferredDeliveryLocation; // 33. কোথায় ডেলিভারী করাতে ইচ্ছুক
  String? preferredFamilyPlanning;   // 34. প্রসব পরবর্তী পরিবার পরিকল্পনা পদ্ধতি

  // 35–38: Data Collector
  String? dataCollectorName;         // 35
  String? dataCollectorDesignation;  // 36
  String? dataCollectorMobile;       // 37
  String? comments;                  // 38

  // Image 3 booklet extra
  String? anyOtherPhysicalProblem;   // অন্য কোনো শারীরিক সমস্যা (যদি থাকে)

  // ══════════════════════════════════════════════════════════════
  // ── Image 4 (Existing Web App): ANC Visit / পরিদর্শন
  // ══════════════════════════════════════════════════════════════
  String? visit1Date;   // পরিদর্শন-১ (৪ মাস)
  String? visit2Date;   // পরিদর্শন-২ (৬ মাস)
  String? visit3Date;   // পরিদর্শন-৩ (৮ মাস)
  String? visit4Date;   // পরিদর্শন-৪ (৮ মাস)

  // ══════════════════════════════════════════════════════════════
  // ── Image 2: গর্ভকালীন সেবা কার্ড (Maternal Care Card)
  // ══════════════════════════════════════════════════════════════

  // Card Header
  String? serialNumber;
  String? cardDate;
  String? serviceCenterName;

  // ── Obstetric History Table (গর্ভ, প্রসব ও গর্ভপাত সংক্রান্ত ইতিহাস)
  // Each row has: date (years ago), type, boys/girls, living/dead, problem
  List<ObstetricHistoryEntry> obstetricHistory = [];

  // ── Medical History (Yes/No checkboxes)
  // Respiratory
  bool shortnessOfBreath = false;
  bool coughOver4Weeks = false;
  bool feverOver4Weeks = false;
  // Cardiovascular
  bool easilyFatigued = false;
  bool palpitations = false;
  bool lowerBodyEdema = false;
  bool highBloodPressure = false;
  // Breast
  bool breastPain = false;
  bool breastLump = false;
  // Urinary
  bool frequentUrination = false;
  bool bloodInUrine = false;
  bool lowerAbdominalPain = false;
  // Menstrual
  String? menstrualCycle;  // নিয়মিত/অনিয়মিত

  // ── Tetanus Vaccines (টিটেনাস ভ্যাকসিন)
  String? tetanusDose1Date;
  String? tetanusDose2Date;
  String? tetanusDose3Date;
  String? tetanusDose4Date;
  String? tetanusDose5Date;

  // ══════════════════════════════════════════════════════════════
  // ── Image 2: প্রসবের তথ্যাবলী (Delivery Info)
  // ══════════════════════════════════════════════════════════════
  String? deliveryDate;
  String? deliveryTime;
  String? deliveryWeight;

  // Delivery Place (checkboxes)
  bool deliveryAtDistrictHospital = false;
  bool deliveryAtUpazilaHealth = false;
  bool deliveryAtUHFWC = false;
  bool deliveryAtMCWC = false;
  bool deliveryAtHome = false;
  bool deliveryAtOther = false;

  // Delivery Attendant (checkboxes)
  bool attendantDoctor = false;
  bool attendantNurse = false;
  bool attendantFWV = false;
  bool attendantFamilyWelfare = false;
  bool attendantCSBA = false;
  bool attendantHealthAssistant = false;
  bool attendantRelative = false;
  bool attendantOther = false;

  // Delivery Method (checkboxes)
  bool deliveryNormal = false;
  bool deliveryCSection = false;
  bool deliveryOther = false;

  // Delivery Outcome (checkboxes)
  bool outcomeLive = false;
  bool outcomeStillbirth = false;
  bool outcomeMaceratedStillbirth = false;

  bool? tookMisoprostol;

  // ══════════════════════════════════════════════════════════════
  // ── Image 2: প্রসবোত্তর পরীক্ষা (Postpartum Examination Table)
  // Checkup types at 4 time intervals
  // ══════════════════════════════════════════════════════════════
  PostpartumExamination? postpartumExam;

  // ── Additional Treatment, Referral
  String? additionalTreatment;           // অন্যান্য চিকিৎসা ও উপদেশ
  String? referralDecision;             // কোন সমস্যা হলে রেফার করতে হবে (UHFWC/EMR/District)
  String? referralHospitalActual;       // কোন হাসপাতালে রেফার করা হলো

  PregnancyRegistrationModel();
}

// ── Obstetric History Entry (one row per pregnancy)
class ObstetricHistoryEntry {
  String? yearsAgo;         // তারিখ (কত বছর পূর্বে)
  String? deliveryType;     // প্রসবের ধরণ (মাথা/সিজার/ফরসেপ)
  String? boys;             // ছেলে
  String? girls;            // মেয়ে
  String? living;           // জীবিত
  String? dead;             // মৃত
  String? problem;          // সমস্যা (কী ধরণের)

  ObstetricHistoryEntry({
    this.yearsAgo,
    this.deliveryType,
    this.boys,
    this.girls,
    this.living,
    this.dead,
    this.problem,
  });
}

// ── Postpartum Examination Table
// 4 checkup columns: ১ম (২৪ ঘণ্টা), ২য় (২-৩ দিন), ৩য় (৭-১৪ দিন), ৪র্থ (৪২-৪৫ দিন)
class PostpartumExamination {
  // Rows: তাপমাত্রা, রক্তচাপ, হিমোগ্লোবিন, প্রস্রাব, অতিরিক্ত রক্তক্ষরণ,
  //       স্রাব/দুর্গন্ধযুক্ত স্রাব, জরায়ুর আকার ও স্পর্শতার, পেরিনিয়াল টিয়ার, স্তনের সমস্যা

  // Each field: checkup1 | checkup2 | checkup3 | checkup4 | comment
  String? temperature1, temperature2, temperature3, temperature4, temperatureComment;
  String? bloodPressure1, bloodPressure2, bloodPressure3, bloodPressure4, bloodPressureComment;
  String? hemoglobin1, hemoglobin2, hemoglobin3, hemoglobin4, hemoglobinComment;
  String? urineTest1, urineTest2, urineTest3, urineTest4, urineTestComment;
  String? excessBleeding1, excessBleeding2, excessBleeding3, excessBleeding4, excessBleedingComment;
  String? discharge1, discharge2, discharge3, discharge4, dischargeComment;
  String? uterusSize1, uterusSize2, uterusSize3, uterusSize4, uterusSizeComment;
  String? perinealTear1, perinealTear2, perinealTear3, perinealTear4, perinealTearComment;
  String? breastProblem1, breastProblem2, breastProblem3, breastProblem4, breastProblemComment;

  PostpartumExamination();
}
