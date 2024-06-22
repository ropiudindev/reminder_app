part of 'reminder_bloc.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();
}

class GetReminders extends ReminderEvent {
  final bool isHistory;

  const GetReminders({
    this.isHistory = false,
  });

  @override
  List<Object?> get props => [isHistory];
}

class AddReminderEvent extends ReminderEvent {
  final List<ReminderModelHive> reminders;

  const AddReminderEvent(this.reminders);

  @override
  List<Object?> get props => [reminders];
}

class UpdateReminderEvent extends ReminderEvent {
  final ReminderModelHive reminder;

  const UpdateReminderEvent(this.reminder);
  @override
  List<Object?> get props => [reminder];
}

class DeleteReminderEvent extends ReminderEvent {
  final int id;

  const DeleteReminderEvent(this.id);
  @override
  List<Object?> get props => [id];
}

class RegisterServicesEvent extends ReminderEvent {
  @override
  List<Object?> get props => [];
}

