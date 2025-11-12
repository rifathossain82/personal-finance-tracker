// class Message {
//
//   /// validation message
//   static const String emptyEmail = "ইমেল ঠিকানা খালি!";
//   static const String invalidEmail = "অবৈধ ইমেল ঠিকানা!";
//   static const String emptyPhone = "ফোন নম্বর খালি!";
//   static const String invalidPhone = "অবৈধ ফোন নম্বর!";
//   static const String emptyPassword = "পাসওয়ার্ড খালি!";
//   static const String invalidPassword = "পাসওয়ার্ড কমপক্ষে 6 অক্ষরের হতে হবে!";
//   static const String doNotMatchPasswords = "পাসওয়ার্ড মেলে না!";
//   static const String emptyOTP = "ওটিপি লিখুন!";
//   static const String invalidOTP = "ওটিপি ৫ অক্ষরের হতে হবে!";
//   static const String emptyField = 'এই ফিল্ডটি প্রয়োজন!';
//   static const String dataAdded = 'তথ্য যুক্ত হয়েছে!';
//   static const String dataUpdated = 'তথ্য আপডেট হয়েছে!';
//   static const String dataUpdateFailed = 'তথ্য আপডেট ব্যর্থ হয়েছে!';
//   static const String dataDeleted = 'তথ্য মুছে ফেলা হয়েছে!';
//   static const String loginSuccess = 'সফলভাবে লগইন করা হয়েছে!';
//   static const String registerSuccess = 'সফলভাবে রেজিস্ট্রেশন সম্পন্ন হয়েছে!';
//   static const String verificationEmailSent = 'যাচাইকরণ ইমেইল পাঠানো হয়েছে!';
//   static const String logoutSuccess = 'সফলভাবে লগআউট করা হয়েছে!';
//   static const String pleaseVerifyEmail = 'অনুগ্রহ করে আপনার ইমেইল ঠিকানা যাচাই করুন!';
//   static const String emailAlreadyVerifiedOrUserNotLoggedIn = 'ইমেইল ইতোমধ্যে যাচাই করা হয়েছে অথবা ব্যবহারকারী লগইন করা নেই!';
//
//
//
//   /// network error message
//   static const String noInternet = "ইন্টারনেট সংযোগ নেই। অনুগ্রহ করে আবার চেষ্টা করুন।";
//   static const String error401 = "অননুমোদিত!";
//   static const String error404 = "পৃষ্ঠা পাওয়া যায়নি!";
//   static const String error500 = "সার্ভার ত্রুটি রেয়েছে!";
//   static const String unknown = "কিছু একটা ভুল হয়েছে!";
//   static const String badResponse = "ভুল রেসপন্স পাওয়া গেছে!";
// }

class Message {

  /// validation message
  static const String emptyName = "Name is empty!";
  static const String emptyEmail = "Email Address is empty!";
  static const String invalidEmail = "Invalid Email Address!";
  static const String emptyPhone = "Phone Number is empty!";
  static const String invalidPhone = "Invalid Phone Number!";
  static const String emptyPassword = "Password is empty!";
  static const String invalidPassword = "Password must be at least 6 characters!";
  static const String emptyOldPassword = "Please enter your old password!";
  static const String emptyNewPassword = "Please enter your new password!";
  static const String emptyConfirmPassword = "Please enter your confirm password!";
  static const String doNotMatchPasswords = "Password don't match!";
  static const String emptyOTP = "Please enter OTP!";
  static const String invalidOTP = "OTP must be 6 characters!";
  static const String invalidCustomerGroupAmount = "The amount must be at least 1!";
  static const String emptyMessage = "Message is empty!";
  static const String emptyField = 'This field is required!';
  static const String dataAdded = 'Data has been added!';
  static const String dataUpdated = 'Data has been updated!';
  static const String dataUpdateFailed = 'Failed to update data!';
  static const String dataDeleted = 'Data has been deleted!';
  static const String loginSuccess = 'Logged in successfully!';
  static const String registerSuccess = 'Registration completed successfully!';
  static const String verificationEmailSent = 'Verification email has been sent!';
  static const String logoutSuccess = 'Logged out successfully!';
  static const String pleaseVerifyEmail = 'Please verify your email address!';
  static const String emailAlreadyVerifiedOrUserNotLoggedIn = 'Email already verified or user not logged in!';


  /// network error message
  static const String noInternet = "Please check your connection!";
  static const String error401 = "Unauthorized!";
  static const String error404 = "Page Not Found!";
  static const String error500 = "Server Error!";
  static const String unknown = "Something went wrong!";
  static const String badResponse = "Bad response format!";
}