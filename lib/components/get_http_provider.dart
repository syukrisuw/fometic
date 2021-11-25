import 'package:fometic/models/form_token_model.dart';
import 'package:get/get.dart';

class GetHttpProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/$id');
  // Post request

  //Future<Response> postUser(Map data) => post('http://youapi/users', body: data);
  // Post request with File

  Future<Response<FormToken>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }

  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
}