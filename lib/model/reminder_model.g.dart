// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelHiveAdapter extends TypeAdapter<ReminderModelHive> {
  @override
  final int typeId = 4;

  @override
  ReminderModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModelHive(
      fields[4] as int,
      fields[1] as DateTime,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModelHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
