import 'package:drift/drift.dart';

class Tags extends Table {
  TextColumn get label => text().withLength(min: 1, max: 10)();

  @override
  Set<Column> get primaryKey => {label};
}
