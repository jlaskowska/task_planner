import 'package:drift/drift.dart';

class Tags extends Table {
  TextColumn get color => text().withLength(min: 8, max: 8)();

  @override
  Set<Column> get primaryKey => {color};
}
