import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:personal_finance_tracker/firebase_options.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize local storage.
  await GetStorage.init(AppConstants.packageName);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Enable offline persistence
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  /// Apply AppBindings
  AppBindings().dependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /// Dismiss the soft keyboard if it's active.
    /// This ensures that the keyboard doesn't remain open unnecessarily
    /// when the app is first launched, which can obstruct the initial view.
    hideKeyboard();

    return GetMaterialApp(
      builder: (context, child) {
        /// ensure the navigation bar adapts after the first frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          AppTheme.enableEdgeToEdge();
        });

        return ScrollConfiguration(
          behavior: KScrollBehavior(),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      initialRoute: RouteGenerator.transactions,
      getPages: RouteGenerator.routes,
      defaultTransition: Transition.fade,
    );
  }
}