part of 'reminder_bloc.dart';


abstract class ReminderState extends Equatable {
  const ReminderState();
}

class ReminderInitial extends ReminderState {
  @override
  List<Object> get props => [];
}

class ReminderLoadedState extends ReminderState {
  final List<ReminderModelHive?> reminders;

  const ReminderLoadedState(
    this.reminders,
  );

  @override
  List<Object?> get props => [
        reminders,
      ];
}