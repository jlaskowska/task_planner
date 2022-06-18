import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.freezed.dart';

@freezed
class TagEntity with _$TagEntity {
  const factory TagEntity({
    required String label,
  }) = _TagEntity;
}
