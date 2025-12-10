import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'app/data/services/fcm_service.dart';
import 'app/routes/app_routes.dart' show AppRoutes;

Future<void> _backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
  await FCMService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FCMService.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "News",
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.NEWS,
      getPages: AppPages.pages,
    );
  }
}
