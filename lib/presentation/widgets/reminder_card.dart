import 'package:flutter/material.dart';
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

  // For formatting date
  final DateFormat formatter = DateFormat('dd MMM yyyy, HH:mm');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
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
                    width: 37,
                    height: 37,
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
                    onTap:onDelete,
                    child: Container(
                      width: 37,
                      height: 37,
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
              const SizedBox(
                width: 25.0,
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    textRow('Time ', formatter.format(reminder.date)),
                    textRow('Status ', getStatus(reminder.date)),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      reminder.description,
                      style: const TextStyle(
                        color: Color.fromRGBO(19, 22, 33, 1),
                        fontSize: 14.0,
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
        const SizedBox(
          height: 10.0,
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
        style: const TextStyle(
          color: Color.fromRGBO(74, 77, 84, 0.7),
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        width: 4.0,
      ),
      Text(
        textTwo,
        style: const TextStyle(
          color: Color.fromRGBO(19, 22, 33, 1),
          fontSize: 14.0,
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
