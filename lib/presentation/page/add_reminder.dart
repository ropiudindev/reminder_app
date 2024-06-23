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
          padding: EdgeInsets.all(10.0.w),
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
              SizedBox(
                height: 10.0.h,
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
                  itemHeight: 40.h,
                  normalTextStyle:
                      TextStyle(fontSize: 24.spMin, color: Colors.white),
                  highlightedTextStyle:
                      TextStyle(fontSize: 24.spMin, color: Colors.blue),
                  isForce2Digits: true,
                  onTimeChange: (time) {
                    setState(() {
                      selectedTime = time;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              TextWidget(
                topLabel: 'Title',
                hintText: 'Title',
                multiLines: false,
                maxLines: 1,
                controller: titleController,
              ),
              SizedBox(
                height: 10.0.h,
              ),
              TextWidget(
                topLabel: 'Description',
                hintText: 'Description',
                height: 100.0.h,
                minLines: 3,
                multiLines: true,
                controller: descController,
              ),
              SizedBox(
                height: 10.0.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () async {
                  if (selectedDate.at(selectedTime).isBefore(DateTime.now())) {
                    showWarningDialog(
                        'Time should be in the future', 'Understand');
                  } else if (titleController.text.isEmpty ||
                      descController.text.isEmpty) {
                    showWarningDialog(
                        'Title or description cannot be empty', 'Understand');
                  } else {
                    BlocProvider.of<ReminderBloc>(context)
                        .add(AddReminderEvent(ReminderModelHive(
                      UniqueKey().hashCode,
                      selectedDate.at(selectedTime),
                      titleController.text,
                      descController.text,
                    )));
                    showWarningDialog('Reminder inserted', 'Ok');
                    titleController.clear();
                    descController.clear();
                  }
                },
                child: const Text('Insert reminder'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showWarningDialog(String message, String btnTitle) {
    showDialog<bool>(
      context: context,
      builder: (context) {
        Size size = MediaQuery.of(context).size;
        return Center(
          child: SizedBox(
            height: 182.h,
            width: size.width,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: const Color.fromRGBO(220, 233, 245, 1),
                    ),
                  ),
                  height: 150.h,
                  width: size.width - 100.w,
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.spMin,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          btnTitle,
                          style: const TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
