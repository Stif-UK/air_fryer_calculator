// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotesAdapter extends TypeAdapter<Notes> {
  @override
  final int typeId = 0;

  @override
  Notes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Notes()
      ..title = fields[0] as String
      ..category = fields[1] as String
      ..temperature = fields[2] as double
      ..time = fields[3] as double
      ..notes = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, Notes obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.temperature)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
