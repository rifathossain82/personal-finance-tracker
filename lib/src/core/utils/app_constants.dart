class AppConstants {
  static const String appName = 'আমাদের কান্দুঘর';
  static const String packageName = 'com.amaderkandughar.app';
  static const String currency = '৳';
  static const String fcmTopic = 'manobotar-barrta';
  static const String appLink = 'https://play.google.com/store/apps/details?id=$packageName';

  static const String devName = 'Appter';
  static const String devBio = 'Building the Future, One App at a Time';
  static const String devPhone = '+8801706750650';
  static const String devEmail = 'contact.appter@gmail.com';
  static const String devFB = 'https://www.facebook.com/AppterTech';

  static const List<String> gendersList = [
    maleGenderKey,
    'নারী',
    othersKey,
  ];

  static const List<String> bloodGroupList = [
    'O+',
    'O-',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
  ];

  static const List<String> bloodCountList = [
    '১',
    '২',
    '৩',
    '৪',
    '৫',
    '৬',
    '৭',
    '৮',
    '৯',
    '১০+',
  ];

  /// To use this key globally and one place for edit:
  static const String maleGenderKey = "পুরুষ";
  static const String othersKey = "অন্যান্য";
  static const String driverKey = "গাড়ি চালক";
  static const String technicianKey = "মিস্ত্রি";
  static const String msgBloodRequestKey = "রক্তদানের অনুরোধ";
  static const String msgPublicWelfareRequestKey = "জনকল্যাণ অনুরোধ";
  static const String msgEventRequestKey = "ইভেন্ট ঘোষণা";
  static const String msgMeetingRequestKey = "সভা বা সমাবেশ";
  static const String upMemberCategoryKey = 'ইউপি সদস্য';
  static const String upAdministrativeOfficerCategoryKey =
      'প্রশাসনিক কর্মকর্তা';
  static const String upVillagePoliceCategoryKey = 'গ্রাম পুলিশ';
  static const String upChairmanKey = 'চেয়ারম্যান';
  static const String upMemberKey = 'মেম্বার';
  static const String upFemaleMemberKey = 'মহিলা মেম্বার';

  static const List<String> professionList = [
    "সরকারি চাকরিজীবী",
    "বেসরকারি চাকরিজীবী",
    "ডাক্তার",
    "ইঞ্জিনিয়ার",
    "শিক্ষক",
    "আইনজীবী",
    "ব্যাংকার",
    "ব্যবসায়ী",
    "শিক্ষার্থী",
    "কৃষক",
    "সাংবাদিক",
    "রাজনীতিবিদ",
    "প্রবাসী",
    driverKey,
    technicianKey,
    othersKey,
  ];

  static const List<String> carTypes = [
    "সিএনজি",
    "অটোরিকশা",
    "মাইক্রোবাস",
    "প্রাইভেট কার",
    "ভ্যান",
    "পিকআপ",
    othersKey,
  ];

  static const List<String> technicianTypes = [
    "রাজমিস্ত্রি",
    "রং মিস্ত্রি",
    "টাইলস মিস্ত্রি",
    "কাঠ মিস্ত্রি",
    "ইলেক্ট্রিশিয়ান",
    othersKey,
  ];

  static const List<String> messageTypes = [
    msgBloodRequestKey,
    msgPublicWelfareRequestKey,
    msgEventRequestKey,
    msgMeetingRequestKey,
    othersKey,
  ];

  static const List<String> shopCategories = [
    'ফার্মেসি',
    'সেলুন',
    'মুদি দোকান',
    'হার্ডওয়্যার ও ইলেক্ট্রনিক্স',
    'কম্পিউটার ও মোবাইল সার্ভিসিং',
    'চা-স্টল',
    'হোটেল ও রেস্টুরেন্ট',
    'কৃষি উপকরণ',
    'মাছ-মাংস',
    'কাপড়',
    'টেইলরিং/দর্জি',
    'ডেকোরেশন',
    'লোহার ওয়ার্কশপ',
    'ফার্নিচার ওয়ার্কশপ',
    othersKey,
  ];

  static const List<String> upMemberCategories = [
    upMemberCategoryKey,
    upAdministrativeOfficerCategoryKey,
    upVillagePoliceCategoryKey,
  ];

  static const List<String> upMemberRoles = [
    upChairmanKey,
    upMemberKey,
    upFemaleMemberKey,
  ];

  static const List<String> upWordNoList = [
    '১ নং',
    '২ নং',
    '৩ নং',
    '৪ নং',
    '৫ নং',
    '৬ নং',
    '৭ নং',
    '৮ নং',
    '৯ নং',
  ];

  static const List<String> govOfficialServiceAreas = [
    'উপজেলা',
    'জেলা',
    'বিভাগ',
    othersKey,
  ];

  static const List<String> userPageTabOptions = [
    'সবগুলো',
    'ব্যানকৃত',
    'অ্যাডমিন',
  ];

}
