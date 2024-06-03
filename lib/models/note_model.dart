import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String note;
  @HiveField(1)
  final String priority;
  @HiveField(2)
  final String category;

  NoteModel(
      {required this.note, required this.priority, required this.category});
}
