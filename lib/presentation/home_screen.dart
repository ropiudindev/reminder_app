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
        title: Text(
          "Reminder",
          style: TextStyle(
            color: Colors.purple,
            fontSize: 18.sp,
          ),
        ),
        elevation: 0.0,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.grey[100]!,
        buttonBackgroundColor: Colors.purple,
        index: activeIndex,
        items: [
          Icon(
            Icons.home,
            size: 30.0.spMin,
            color: activeIndex == 0 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.alarm_on_sharp,
            size: 30.0.spMin,
            color: activeIndex == 1 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.add,
            size: 30.0.spMin,
            color: activeIndex == 2 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.history,
            size: 30.0.spMin,
            color: activeIndex == 3 ? Colors.white : const Color(0xFFC8C9CB),
          ),
          Icon(
            Icons.info,
            size: 30.0.spMin,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.w,
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
                SizedBox(
                  height: 50.0.h,
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
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0.spMin),
                            topRight: Radius.circular(30.0.spMin),
                          ),
                          color: Colors.grey[100],
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                        ),
                        child: getWidget(activeIndex, remindersInitial, () {
                          setState(() {
                            activeIndex = 2;
                          });
                        }));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidget(
    int index,
    List<ReminderModelHive?> remindersInitial,
    Function() onTapAdd,
  ) {
    switch (index) {
      case 0:
        return ReminderList(reminders: remindersInitial, onTapAdd: onTapAdd);
      case 1:
        return ReminderList(
            reminders: remindersInitial
                .where((element) => element!.date.isAfter(DateTime.now()))
                .toList(),
            onTapAdd: onTapAdd);
      case 2:
        return const AddReminder();
      case 3:
        return ReminderList(
            reminders: remindersInitial
                .where((element) => element!.date.isBefore(DateTime.now()))
                .toList(),
            onTapAdd: onTapAdd);
      case 4:
        return InformationUsage(
          reminders: remindersInitial,
        );
      default:
        return Container();
    }
  }
}
