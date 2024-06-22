import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/model/reminder_model.dart';
import 'package:reminder_app/presentation/bloc/reminder_bloc.dart';
import 'package:reminder_app/presentation/widgets/reminder_card.dart';

class ReminderList extends StatelessWidget {
  final List<ReminderModelHive?> reminders;
  const ReminderList({
    super.key,
    required this.reminders,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderState>(
      builder: (context, state) {
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
                  ...List.generate(
                      reminders.length,
                      (index) => ReminderCard(
                          onDelete: () {
                            BlocProvider.of<ReminderBloc>(context)
                                .add(DeleteReminderEvent(reminders[index]!.id));
                          },
                          reminder: ReminderModelHive(
                              reminders[index]!.id,
                              reminders[index]!.date,
                              reminders[index]!.title,
                              reminders[index]!.description))),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}