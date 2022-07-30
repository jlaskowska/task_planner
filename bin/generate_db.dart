import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:task_planner/infrastructure/database/db.dart';

void main() async {
  const filePath = 'assets/db/db.sqlite';

  final dbFile = File(filePath);
  if (dbFile.existsSync()) {
    dbFile.deleteSync();
  }
  dbFile.createSync(recursive: true);

  // ignore: invalid_use_of_visible_for_testing_member
  final db = Database(LazyDatabase(
    () => NativeDatabase(dbFile),
  ));

  const colors = [
    'ff65c2f9',
    'fff7b369',
    'fff9807c',
    'ff61F3BB',
    'ff00E7E2',
    'ffF488C3',
    'ffA33370',
  ];
  for (final color in colors) {
    db.addTag(color);
  }

  db.createTask(title: 'Your first task', tag: 'ff61F3BB');
}
