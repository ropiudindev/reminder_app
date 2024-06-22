import 'package:hive/hive.dart';
import 'package:reminder_app/model/reminder_model.dart';

class ReminderService {
  late Box<ReminderModelHive> _reminder;

  Future<void> init() async {
    Hive.registerAdapter(ReminderModelHiveAdapter());
    _reminder = await Hive.openBox<ReminderModelHive>('reminder');
  }

  List<ReminderModelHive> getReminder() {
    final reminder = _reminder.values;
    return reminder.toList();
  }

  void addReminder(
    final int id,
    final DateTime date,
    final String title,
    final String description,
  ) {
    _reminder.add(
      ReminderModelHive(
        id,
        date,
        title,
        description,
      ),
    );
  }

  Future<void> removeReminder(final int id) async {
    final reminderToRemove =
        _reminder.values.firstWhere((element) => element.id == id);
    await reminderToRemove.delete();
  }

  Future<void> updateReminder(final ReminderModelHive updatedData) async {
    final reminderToEdit =
        _reminder.values.firstWhere((element) => element.id == updatedData.id);
    final index = reminderToEdit.key as int;
    await _reminder.put(
      index,
      ReminderModelHive(
        updatedData.id,
        updatedData.date,
        updatedData.title,
        updatedData.description,
      ),
    );
  }
}
