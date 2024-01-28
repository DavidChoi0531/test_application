import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:test_application/user/model.dart';
import 'package:test_application/user/provider.dart';

import 'test.mocks.dart';

/// state provider를 테스트 하기 위해, [ProviderContainer]를 생성.
/// Listener를 구현하여 [ProviderContainer]내의 [User] 객체에 대한 변화를 감지할 수 있다.
class Listener extends Mock {
  void call(User? previous, User? value);
}

/// [User] 객체를 mock으로 생성하여 사용할 수 있도록 다음 annotation을 사용한다.
@GenerateNiceMocks([
  MockSpec<User>(),
])
void main() {
  test('test user state in sign in method', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final listener = Listener();

    container.listen<User?>(
      userStateProvider,
      listener.call,
      fireImmediately: true,
    );

    final user = MockUser();

    /// [userStateProvider]의 초기화시 [User] 객체는 null에서 기본값을 가진 [User] 객체로 초기화된다.
    /// 해당 코드는 [userStateProvider]의 초기화시 [User] 객체가 null에서 기본값을 가진 [User] 객체로 단 1번 변화하는지 확인한다.
    verify(listener(null, any)).called(1);

    // verifyInOrder([
    //   listener(null, any),
    //   listener(any, user),
    // ]);

    /// 해당 코드는 명시적인 호출 이외의 추가적인 interaction이 없는지 확인한다.
    verifyNoMoreInteractions(listener);

    /// [MockUser] 객체를 생성하여 테스트를 위한 메서드를 실행.

    container.read(userStateProvider.notifier).signIn(user);

    /// [userStateProvider]의 [User] 객체가 [MockUser] 객체로 변화하는지 확인한다.
    verify(listener(any, user)).called(1);
    verifyNoMoreInteractions(listener);

    /// List 아래에 해당 method의 실행 및 결과가 순차적으로 확인되었는지 테스트.
    // verifyInOrder([
    //   // () => listener(null, any),
    //   // () => listener(any, user),
    // ]);
  });
}
