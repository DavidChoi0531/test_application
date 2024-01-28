import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:test_application/api_test/model/model.dart';
import 'package:test_application/api_test/service/request.dart';

import 'test.mocks.dart';

/// http client를 mock 객체로 생성 후 해당 mock client를 사용하여 테스트 한다.
@GenerateMocks([Dio])
void main() {
  group('using example api test', () {
    test('get data completes successfully', () async {
      final dio = MockDio();

      /// api 호출시 성공에 대한 가상의 client 응답을 생성
      when(dio.get(testApi)).thenAnswer((_) async => Response(
            data: {
              'userId': 1,
              'id': 1,
              'title': 'delectus aut autem',
              'completed': false,
            },
            statusCode: 200,
            requestOptions: RequestOptions(path: ''),
          ));

      /// 테스트.
      expect(await TestRequest.getData(dio), isA<TestModel>());
    });

    test('get data fails', () async {
      final dio = MockDio();

      /// api 호출시 실패에 대한 가상의 client 응답을 생성
      when(dio.get(testApi)).thenAnswer((_) async => Future.value(
            Response(
              data: null,
              statusCode: 401,
              requestOptions: RequestOptions(path: ''),
            ),
          ));

      /// 테스트.
      expect(TestRequest.getData(dio), throwsA(isA<FailedGetDataException>()));
    });
  });
}
