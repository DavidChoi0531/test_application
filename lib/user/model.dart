import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}

@freezed
class User with _$User {
  const factory User({
    @Default('') String? name,
    @Default(0) int? age,
    @Default('') String? nickname,
    @Default(Gender.male) Gender? gender,
  }) = _User;

  factory User.initial() => const User();

  factory User.fromJson(final Map<String, Object?> json) =>
      _$UserFromJson(json);
}
