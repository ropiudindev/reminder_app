import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder_app/presentation/bloc/reminder_bloc.dart';
import 'package:reminder_app/presentation/home_screen.dart';
import 'package:reminder_app/service/reminder_service.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'service/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return RepositoryProvider(
            create: (context) => ReminderService(),
            child: BlocProvider(
              create: (context) =>
                  ReminderBloc(RepositoryProvider.of<ReminderService>(context))
                   ..add(RegisterServicesEvent()),
              child: MaterialApp(
                title: 'Reminder App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen(),
              ),
            ),
          );
        });
  }
}
