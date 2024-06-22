import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder_app/model/reminder_model.dart';
import 'package:reminder_app/service/notification_service.dart';
import 'package:reminder_app/service/reminder_service.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final ReminderService _reminderService;

  ReminderBloc(this._reminderService) : super(ReminderInitial()) {
    on<GetReminders>((event, emit) {
      final reminder = _reminderService.getReminder();
      emit(ReminderLoadedState(
        reminder,
      ));
    });

    on<AddReminderEvent>((event, emit) async {
      for (var reminder in event.reminders) {
        _reminderService.addReminder(
          reminder!.id,
          reminder.date,
          reminder.title,
          reminder.description,
        );

        NotificationService().scheduleNotification(
          id: reminder.id,
          title: reminder.title,
          body: reminder.description,
          scheduledNotificationDateTime: reminder.date,
        );
      }

      add(
        const GetReminders(),
      );
    });

    on<UpdateReminderEvent>((event, emit) async {
      await _reminderService.updateReminder(event.reminder);
      add(const GetReminders());
    });

    on<DeleteReminderEvent>((event, emit) async {
      await _reminderService.removeReminder(event.id);
      NotificationService().remvoveNotification(event.id);
      add(const GetReminders());
    });

    on<RegisterServicesEvent>((event, emit) async {
      await _reminderService.init();
      emit(ReminderInitial());
    });
  }
}
