import 'package:invest/imports/imports.dart';

class ApiClient {
  final Dio _dio = Dio();
  late String? _token;

  ApiClient(String token) {
    _token = token;
    // _dio.options.baseUrl = 'https://api.mvest.africa';
    _dio.options.baseUrl = 'http://192.168.100.247:8090';
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    logger('GET Request: $url');
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': 'Bearer ${_token ?? ''}'}),
      );
    } on DioException catch (e) {
      logger('<<<<<<<<<<<<<<<<<<<GET ERROR>>>>>>>>>>>>>>>>>>>');
      logger(e.response);
      throw e.response!;
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? body}) async {
    logger('POST Request: $url');
    logger('POST body: $body');

    try {
      return await _dio.post(
        url,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer ${_token ?? ''}'}),
      );
    } on DioException catch (e) {
      logger('<<<<<<<<<<<<<<<<<<<POST ERRO1R>>>>>>>>>>>>>>>>>>>');
      logger(e.response);
      throw e.response?.data['error'];
    }
  }

  Future<Response> upload(
    String url, {
    Map<String, File?>? files,
  }) async {
    logger('UPLOAD Request: $url');
    try {
      FormData formData = FormData.fromMap({});

      for (var entry in files!.entries) {
        formData.files.add(
          MapEntry(
            entry.key,
            await MultipartFile.fromFile(entry.value!.path),
          ),
        );
      }

      return await _dio.post(
        url,
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer ${_token ?? ''}'}),
      );
    } on DioException catch (e) {
      logger('<<<<<<<<<<<<<<<<<<<Upload ERROR>>>>>>>>>>>>>>>>>>>');
      logger(e.response?.data);
      throw e.response?.data['error'];
    }
  }
}

apiCall(String method, String url, Map<String, dynamic> body) async {
  logger('This was called');
  late ApiClient apiClient = ApiClient('');

  try {
    // Initialize the response with a default value
    Response response =
        Response(data: null, requestOptions: RequestOptions(path: ''));
    // Use the ApiClient here
    if (method == 'GET') {
      response = await apiClient.get(url);
    } else if (method == 'POST') {
      response = await apiClient.post(
        url,
        body: body,
      );
    } else if (method == 'UPLOAD') {
      response = await apiClient.upload(
        url,
        files: body['files'],
      );
    }
    return {'isSuccessful': true, 'data': response.data};
  } catch (e) {
    logger('apiCall Error: $e');
    return {'isSuccessful': false, 'error': e};
  }
}
