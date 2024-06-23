import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reminder_app/extension/datetime_extension.dart';
import 'package:reminder_app/model/reminder_model.dart';
import 'package:reminder_app/presentation/bloc/reminder_bloc.dart';
import 'package:reminder_app/presentation/widgets/text_widget.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({
    super.key,
  });

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final titleController = TextEditingController();

  final descController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReminderBloc, ReminderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.purple,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: const Color.fromRGBO(220, 233, 245, 1),
                  ),
                ),
                child: TimePickerSpinner(
                  locale: const Locale('en', ''),
                  time: selectedTime,
                  is24HourMode: false,
                  isShowSeconds: true,
                  itemHeight: 40,
                  normalTextStyle:
                      const TextStyle(fontSize: 24, color: Colors.white),
                  highlightedTextStyle:
                      const TextStyle(fontSize: 24, color: Colors.blue),
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextWidget(
                topLabel: 'Title',
                hintText: 'Title',
                multiLines: false,
                maxLines: 1,
                controller: titleController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextWidget(
                topLabel: 'Description',
                hintText: 'Description',
                height: 100.0.h,
                minLines: 3,
                multiLines: true,
                controller: descController,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () async {
                  BlocProvider.of<ReminderBloc>(context).add(AddReminderEvent(
                    ReminderModelHive(
                      UniqueKey().hashCode,
                      selectedDate.at(selectedTime),
                      titleController.text,
                      descController.text,
                    )
                  ));
                },
                child: const Text('Insert reminder'),
              ),
            ],
          ),
        );
      },
    );
  }
}