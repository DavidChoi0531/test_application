import 'package:dio/dio.dart';
import 'package:test_application/api_test/model/model.dart';

/// Api 호출 테스트를 위한 Test Request를 정의한다.
/// https://jsonplaceholder.typicode.com 에서 제공하는 API를 사용한다.

const testApi = 'https://jsonplaceholder.typicode.com/todos/1';

class TestRequest {
  static Future<TestModel> getData(final Dio dio) async {
    try {
      final resp = await dio.get(testApi);
      if (resp.statusCode! > 300) {
        throw FailedGetDataException();
      }

      final testModel = TestModel.fromJson(resp.data as Map<String, Object?>);
      return testModel;
    } catch (e) {
      throw FailedGetDataException();
    }
  }
}

class FailedGetDataException implements Exception {
  String get message => 'failed to get data';
}
