import 'dart:convert';

import 'package:flutter_bili/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

// 统一网络层返回格式
class HiNetResponse<T> {
  HiNetResponse({
    required this.request,
    this.data,
    this.extra,
    this.message,
    this.statusCode,
  });

  BaseRequest request;
  T? data;
  dynamic extra;
  String? message;
  int? statusCode;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
