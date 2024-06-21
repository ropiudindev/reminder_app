import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatelessWidget {
  final ReminderModel order;

  ReminderCard({super.key, 
    required this.order,
  });

  // For formatting date
  final DateFormat formatter = DateFormat('dd MMM yyyy');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
              width: 25.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'coba 1',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color.fromRGBO(19, 22, 33, 1),
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  textRow(
                    'Lokasi',
                    'Bekasi',
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  textRow('date ', formatter.format(order.reminderDate)),
                  const SizedBox(
                    height: 5.0,
                  ),
                  textRow(
                    'title',
                    'coba',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
