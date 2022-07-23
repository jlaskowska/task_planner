import 'package:drift/drift.dart';
import 'package:task_planner/infrastructure/database/converters/iso_date_time_converter.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get tag =>
      text().nullable().customConstraint('NULL REFERENCES tags(label)')();
  TextColumn get title => text()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  TextColumn get completedAt =>
      text().nullable().map(const IsoDateTimeConverter())();
  TextColumn get uncompletedAt =>
      text().nullable().map(const IsoDateTimeConverter())();
}
