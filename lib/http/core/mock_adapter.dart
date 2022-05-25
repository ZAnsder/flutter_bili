import 'package:flutter_bili/http/core/hi_adapter.dart';
import 'package:flutter_bili/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(const Duration(milliseconds: 1000), () {
      return HiNetResponse(
        request: request,
        // statusCode: 500,
        // data: {'code': 0, 'message': 'success'} as T,
      );
    });
  }
}
