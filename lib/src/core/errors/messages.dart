class Message {

  /// validation message
  static const String emptyEmail = "ইমেল ঠিকানা খালি!";
  static const String invalidEmail = "অবৈধ ইমেল ঠিকানা!";
  static const String emptyPhone = "ফোন নম্বর খালি!";
  static const String invalidPhone = "অবৈধ ফোন নম্বর!";
  static const String emptyPassword = "পাসওয়ার্ড খালি!";
  static const String invalidPassword = "পাসওয়ার্ড কমপক্ষে 6 অক্ষরের হতে হবে!";
  static const String doNotMatchPasswords = "পাসওয়ার্ড মেলে না!";
  static const String emptyOTP = "ওটিপি লিখুন!";
  static const String invalidOTP = "ওটিপি ৫ অক্ষরের হতে হবে!";
  static const String emptyField = 'এই ফিল্ডটি প্রয়োজন!';
  static const String dataAdded = 'তথ্য যুক্ত হয়েছে!';
  static const String dataUpdated = 'তথ্য আপডেট হয়েছে!';
  static const String dataUpdateFailed = 'তথ্য আপডেট ব্যর্থ হয়েছে!';
  static const String dataDeleted = 'তথ্য মুছে ফেলা হয়েছে!';
  static const String loginSuccess = 'সফলভাবে লগইন করা হয়েছে!';
  static const String registerSuccess = 'সফলভাবে রেজিস্ট্রেশন সম্পন্ন হয়েছে!';
  static const String verificationEmailSent = 'যাচাইকরণ ইমেইল পাঠানো হয়েছে!';
  static const String logoutSuccess = 'সফলভাবে লগআউট করা হয়েছে!';
  static const String pleaseVerifyEmail = 'অনুগ্রহ করে আপনার ইমেইল ঠিকানা যাচাই করুন!';
  static const String emailAlreadyVerifiedOrUserNotLoggedIn = 'ইমেইল ইতোমধ্যে যাচাই করা হয়েছে অথবা ব্যবহারকারী লগইন করা নেই!';



  /// network error message
  static const String noInternet = "ইন্টারনেট সংযোগ নেই। অনুগ্রহ করে আবার চেষ্টা করুন।";
  static const String error401 = "অননুমোদিত!";
  static const String error404 = "পৃষ্ঠা পাওয়া যায়নি!";
  static const String error500 = "সার্ভার ত্রুটি রেয়েছে!";
  static const String unknown = "কিছু একটা ভুল হয়েছে!";
  static const String badResponse = "ভুল রেসপন্স পাওয়া গেছে!";
}