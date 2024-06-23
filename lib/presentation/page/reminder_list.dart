import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/model/reminder_model.dart';
import 'package:reminder_app/presentation/bloc/reminder_bloc.dart';
import 'package:reminder_app/presentation/page/empty.dart';
import 'package:reminder_app/presentation/widgets/reminder_card.dart';

class ReminderList extends StatelessWidget {
  final List<ReminderModelHive?> reminders;
  final Function() onTapAdd;
  const ReminderList({
    super.key,
    required this.reminders,
    required this.onTapAdd,
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
              padding: EdgeInsets.symmetric(
                horizontal: 24.0.w,
              ),
              child: reminders.isNotEmpty
                  ? Column(
                      children: [
                        ...List.generate(
                          reminders.length,
                          (index) => ReminderCard(
                            onDelete: () {
                              BlocProvider.of<ReminderBloc>(context).add(
                                DeleteReminderEvent(
                                  reminders[index]!.id,
                                ),
                              );
                            },
                            reminder: ReminderModelHive(
                              reminders[index]!.id,
                              reminders[index]!.date,
                              reminders[index]!.title,
                              reminders[index]!.description,
                            ),
                          ),
                        ),
                      ],
                    )
                  : EmptyState(
                      onTapAdd: onTapAdd,
                    ),
            ),
          ],
        );
      },
    );
  }
}
