import 'package:flutter_bili/db/hi_cache.dart';
import 'package:flutter_bili/http/core/hi_net.dart';
import 'package:flutter_bili/http/request/base_request.dart';
import 'package:flutter_bili/http/request/login_request.dart';
import 'package:flutter_bili/http/request/register_request.dart';

class LoginDao {
  static const boardingPass = 'boarding-pass';
  static Future login(
    String userName,
    String password,
  ) {
    return _send(userName, password);
  }

  static Future register(
    String userName,
    String password,
    String imoocId,
    String orderId,
  ) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  static Future _send(
    String userName,
    String password, {
    String? imoocId,
    String? orderId,
  }) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegisterRequest();
    } else {
      request = LoginRequest();
    }

    request
        .addParams('userName', userName)
        .addParams('password', password)
        .addParams('imoocId', imoocId!)
        .addParams('orderId', orderId!);

    var result = await HiNet.getInstance().fire(request);

    if (result['code'] == 0 && result['data'] != null) {
      HiCache.getInstance().setString(boardingPass, result['data']);
    }
    return result;
  }

  static getToken() {
    return HiCache.getInstance().get(boardingPass);
  }
}
