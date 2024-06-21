import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/presentation/home_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'plugin/notification_plugin.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationPlugin().initNotification();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Flutter Notifications',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  const HomeScreen(),
        );
      }
    );
  }
}
