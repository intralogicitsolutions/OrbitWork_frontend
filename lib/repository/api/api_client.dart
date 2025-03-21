import 'package:get/get.dart';
import 'package:orbitwork/repository/api/api_constants.dart';

class ApiClient extends GetConnect{
  @override
  void onInit() {
    httpClient.baseUrl = ApiConstants.BASE_URL;
    super.onInit();
  }

  Future<Response> postRequest(String url , dynamic body) async {
    return await post(url, body);
  }

  Future<Response> getRequest(String url) async {
    return await get(url);
  }

  Future<Response> putRequest(String url , dynamic body) async {
    return await put(url, body);
  }

  Future<Response> deleteRequest(String url) async {
    return await delete(url);
  }


}