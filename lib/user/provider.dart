import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_application/user/model.dart';

part 'provider.g.dart';

@riverpod
class UserState extends _$UserState {
  @override
  User? build() {
    initialize();
    return null;
  }

  void initialize() {
    state = User.initial();
  }

  void signIn(final User user) {
    state = user;
  }
}
