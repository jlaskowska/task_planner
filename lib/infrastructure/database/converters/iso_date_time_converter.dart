import 'package:drift/drift.dart';

/// Taken from https://github.com/simolus3/drift/issues/286#issuecomment-567498260
/// Fix so that UTC is used instead of local time
class IsoDateTimeConverter extends TypeConverter<DateTime, String> {
  const IsoDateTimeConverter();
  @override
  DateTime? mapToDart(String? fromDb) {
    if (fromDb == null) {
      return null;
    } else {
      return DateTime.parse(fromDb);
    }
  }

  @override
  String? mapToSql(DateTime? value) {
    return value?.toIso8601String();
  }
}
