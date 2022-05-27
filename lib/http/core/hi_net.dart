/*
 * 单例模式封装一方库请求
 * 
 */
import 'package:flutter_bili/http/core/dio_adapter.dart';
import 'package:flutter_bili/http/core/hi_adapter.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/core/mock_adapter.dart';
import 'package:flutter_bili/http/request/base_request.dart';

class HiNet {
  HiNet._();
  static HiNet? _instance;
  static HiNet getInstance() {
    return _instance ??= HiNet._();
  }

  Future fire(BaseRequest request) async {
    HiNetResponse? response;
    var error;
    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }

    var result = response?.data;
    printLog(result);
    var status = response?.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(
          message: result.toString(),
          data: result,
        );
      default:
        throw HiNetError(
          code: status ?? -1,
          message: result.toString(),
          data: result,
        );
    }
  }

  Future send(BaseRequest request) async {
    request.addHeader('token', '123');
    // return MockAdapter().send(request);
    return DioAdapter().send(request);
  }

  void printLog(str) {
    print('hi_net: ${str.toString()}');
  }
}
