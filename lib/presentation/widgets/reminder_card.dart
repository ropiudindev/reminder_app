import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/reminder_model.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModelHive reminder;
  final Function() onDelete;

  ReminderCard({
    super.key,
    required this.reminder,
    required this.onDelete,
  });

  final DateFormat formatter = DateFormat('dd MMM yyyy, hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: const Color.fromRGBO(220, 233, 245, 1),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 37.w,
                    height: 37.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(221, 40, 81, 0.18),
                    ),
                    child: const Icon(
                      Icons.calendar_month,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                    onTap: onDelete,
                    child: Container(
                      width: 37.w,
                      height: 37.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(221, 40, 81, 0.18),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 25.0.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0.h,
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    textRow('Time ', formatter.format(reminder.date)),
                    textRow('Status ', getStatus(reminder.date)),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Text(
                      reminder.description,
                      style: TextStyle(
                        color: const Color.fromRGBO(19, 22, 33, 1),
                        fontSize: 14.0.spMin,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0.h,
        )
      ],
    );
  }
}

String getStatus(DateTime date) {
  return date.isBefore(DateTime.now()) ? 'Done' : 'Incoming';
}

Widget textRow(String textOne, String textTwo) {
  return Wrap(
    children: [
      Text(
        '$textOne:',
        style: TextStyle(
          color: const Color.fromRGBO(74, 77, 84, 0.7),
          fontSize: 14.0.spMin,
        ),
      ),
      const SizedBox(
        width: 4.0,
      ),
      Text(
        textTwo,
        style: TextStyle(
          color: const Color.fromRGBO(19, 22, 33, 1),
          fontSize: 14.0.spMin,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}

class ReminderModel {
  final int id;
  final DateTime reminderDate;
  final String title;
  final String description;

  ReminderModel({
    required this.id,
    required this.reminderDate,
    required this.title,
    required this.description,
  });
}
