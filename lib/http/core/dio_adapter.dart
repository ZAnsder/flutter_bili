import 'package:dio/dio.dart';
import 'package:flutter_bili/http/core/hi_adapter.dart';
import 'package:flutter_bili/http/core/hi_error.dart';
import 'package:flutter_bili/http/request/base_request.dart';

class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(BaseRequest request) async {
    var response, error, options = Options(headers: request.header);

    try {
      if (request.httpMethod() == HttpMethod.get) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.post) {
        response = await Dio().post(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.delete) {
        response = await Dio().delete(request.url(), options: options);
      }
    } on DioError catch (e) {
      error = e;
      response = e.response;
    }

    if (error != null) {
      throw HiNetError(
        code: response.statusCode ?? -1,
        message: error.toString(),
        data: buildRes(response, request),
      );
    }

    return buildRes(response, request);
  }

  buildRes(Response response, BaseRequest request) {
    return HiNetResponse(
      request: request,
      data: response.data,
      message: response.statusMessage,
      statusCode: response.statusCode,
      extra: response,
    );
  }
}
