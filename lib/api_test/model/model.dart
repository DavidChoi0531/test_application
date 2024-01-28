import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class TestModel with _$TestModel {
  const factory TestModel({
    required int userId,
    required int id,
    required String title,
    required bool completed,
  }) = _TestModel;

  factory TestModel.fromJson(final Map<String, Object?> json) =>
      _$TestModelFromJson(json);
}
