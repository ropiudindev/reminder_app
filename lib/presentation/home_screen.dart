import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/model/reminder_model.dart';
import 'package:reminder_app/presentation/bloc/reminder_bloc.dart';
import 'package:reminder_app/presentation/page/add_reminder.dart';
import 'package:reminder_app/presentation/page/information_usage.dart';
import 'package:reminder_app/presentation/page/reminder_list.dart';

DateTime scheduleTime = DateTime.now().add(const Duration(seconds: 10));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[50],
        title: const Text(
          "Reminder",
          style: TextStyle(
            color: Colors.purple,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[100]!,
        buttonBackgroundColor: Colors.purple,
        items: [
          Icon(
            Icons.home,
            size: 30.0,
            color: activeIndex == 0 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.alarm_on_sharp,
            size: 30.0,
            color: activeIndex == 1 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.add,
            size: 30.0,
            color: activeIndex == 2 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.history,
            size: 30.0,
            color: activeIndex == 3 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.info,
            size: 30.0,
            color: activeIndex == 4 ? Colors.white : const Color(0xFFC8C9CB),
          ),
        ],
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      backgroundColor: Colors.purple,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Welcome to,\n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                TextSpan(
                                  text: "App Reminder!",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                BlocBuilder<ReminderBloc, ReminderState>(
                  builder: (context, state) {
                    List<ReminderModelHive?> remindersInitial = [];
                    if (state is ReminderInitial) {
                      BlocProvider.of<ReminderBloc>(context)
                          .add(const GetReminders());
                    }
                    if (state is ReminderLoadedState) {
                      remindersInitial = state.reminders;
                    }
                    return Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight:
                              MediaQuery.of(context).size.height - 200.0.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Colors.grey[100],
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                        ),
                        child: getWidget(activeIndex, remindersInitial));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidget(int index, List<ReminderModelHive?> remindersInitial) {
    switch (index) {
      case 0:
        return ReminderList(reminders: remindersInitial);
      case 1:
        return ReminderList(
          reminders: remindersInitial
              .where((element) => element!.date.isAfter(DateTime.now()))
              .toList(),
        );
      case 2:
        return const AddReminder();
      case 3:
        return ReminderList(
          reminders: remindersInitial
              .where((element) => element!.date.isBefore(DateTime.now()))
              .toList(),
        );
      case 4:
        return InformationUsage(
          reminders: remindersInitial,
        );
      default:
        return Container();
    }
  }
}
