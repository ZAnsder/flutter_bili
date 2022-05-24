enum HttpMethod { get, post, delete, put }

abstract class BaseRequest {
  // http://api.devio.org/v1/test?params=1
  // https://api.devio.org/v1/test/1

  var pathParams;
  var useHttps = true;
  String authority() {
    return 'api.devio.org';
  }

  HttpMethod httpMethod();
  bool needLogin();
  String path();

  String url() {
    Uri? uri;

    var pathStr = path();

    if (pathParams != null) {
      if (pathStr.endsWith('/')) {
        pathStr = '${path()}$pathParams';
      } else {
        pathStr = '${path()}/$pathParams';
      }
    }

    if (useHttps) {
      Uri.https(authority(), pathStr);
    } else {
      Uri.http(authority(), pathStr);
    }

    print('url: ${uri.toString()}');
    return uri.toString();
  }

  Map<String, String> params = Map();

  BaseRequest addParams(String k, Object v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, String> header = Map();

  BaseRequest addHeader(String k, Object v) {
    params[k] = v.toString();
    return this;
  }
}
