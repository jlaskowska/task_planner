import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tag =>
      text().nullable().customConstraint('NULL REFERENCES tags(label)')();
  TextColumn get title => text().withLength(min: 0, max: 32)();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
}
