import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
// import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/service/notification_service.dart';
import 'package:reminder_app/presentation/widgets/reminder_card.dart';
import 'package:reminder_app/presentation/widgets/text_widget.dart';
// import 'package:day_night_time_picker/lib/state/time.dart' as t;

DateTime scheduleTime = DateTime.now().add(const Duration(seconds: 10));

// t.Time _time = t.Time(hour: scheduleTime.hour, minute: scheduleTime.minute);

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
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 200.0.h,
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
                  child: activeIndex == 0
                      ? const Home()
                      : activeIndex == 2
                          ? const AddReminder()
                          : const Home(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            children: [
              ReminderCard(
                  order: ReminderModel(
                      id: 0,
                      reminderDate: DateTime.now(),
                      title: 'title',
                      description: 'description')),
            ],
          ),
        ),
      ],
    );
  }
}

class AddReminder extends StatelessWidget {
  const AddReminder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.purple,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            // New date selected
            // setState(() {
            //   _selectedValue = date;
            // });
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: ElevatedButton(
            child: const Text('Schedule notifications'),
            onPressed: () async {
              // TimeOfDay initialTime = TimeOfDay.now();
              // TimeOfDay? pickedTime = await showTimePicker(
              //   context: context,
              //   initialTime: initialTime,
              //   builder: (BuildContext context, Widget? child) {
              //     return Directionality(
              //       textDirection: TextDirection.rtl,
              //       child: child ?? Container(),
              //     );
              //   },
              // );

              // print('waktu dipilih ${pickedTime?.hour ?? 'tidak dipilih'}');

              //        Navigator.of(context).push(
              //     showPicker(
              //         context: context,
              //         value: _time,
              //         sunrise: TimeOfDay(hour: 6, minute: 0), // optional
              //         sunset: TimeOfDay(hour: 18, minute: 0), // optional
              //         duskSpanInMinutes: 120, // optional
              //         onChange: (value){
              //           _time = value;
              //         },
              //     ),
              // );
              debugPrint('Notification Scheduled for $scheduleTime');
              NotificationService().scheduleNotification(
                  id: UniqueKey().hashCode,
                  title: 'Scheduled Notification',
                  body: '$scheduleTime',
                  scheduledNotificationDateTime:DateTime.now().add(const Duration(seconds: 10)));
            },
          ),
        ),
        const TextWidget(
          hintText: 'Title',
        ),
        const SizedBox(
            height: 200,
            child: TextWidget(
              hintText: 'Description',
            ))
      ],
    );
  }
}
