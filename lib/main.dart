import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:towner_final_round/controllers/init_controller.dart';
import 'package:towner_final_round/firebase_options.dart';
import 'package:towner_final_round/pages/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      initialBinding: Init(),
      home: const ScreenHome(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.grey.shade700,
        scaffoldBackgroundColor: const Color(0xffF2F2F2),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xffF2F2F2),
            titleTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff171515),
            ),
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xff171515))),
      ),
    );
  }
}
