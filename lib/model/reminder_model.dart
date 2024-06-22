import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 1)
class ReminderModelHive extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String description;

  ReminderModelHive(
    this.id,
    this.date,
    this.title,
    this.description,
  );
}
