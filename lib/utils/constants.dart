import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:io';

List userPlans = [];

num activePage = 0;

class ApiClient {
  final Dio _dio = Dio();
  late String? _token;

  ApiClient(String token) {
    _token = token;
    _dio.options.baseUrl = 'http://192.168.100.20:8080';
  }

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    print('GET Request: $url');
    try {
      return await _dio.get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': 'Bearer ${_token ?? ''}'}),
      );
    } on DioException catch (e) {
      print('<<<<<<<<<<<<<<<<<<<GET ERROR>>>>>>>>>>>>>>>>>>>');
      print(e.response);
      throw e.response!;
    }
  }

  Future<Response> post(String url, {Map<String, dynamic>? body}) async {
    print('POST Request: $url');
    print('POST body: $body');

    try {
      return await _dio.post(
        url,
        data: body,
        options: Options(headers: {'Authorization': 'Bearer ${_token ?? ''}'}),
      );
    } on DioException catch (e) {
      print('<<<<<<<<<<<<<<<<<<<POST ERROR>>>>>>>>>>>>>>>>>>>');
      print(e.response?.data);
      throw e.response?.data;
    }
  }

  Future<Response> upload(
    String url, {
    Map<String, File?>? files,
  }) async {
    print('UPLOAD Request: $url');
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
      print('<<<<<<<<<<<<<<<<<<<Upload ERROR>>>>>>>>>>>>>>>>>>>');
      print(e.response?.data);
      throw e.response?.data;
    }
  }
}

PersistentTabController bottomNavigationController =
    PersistentTabController(initialIndex: 0);

// Media screen height & width
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

String formatDate(String date, minified) {
  final originalFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

  final parsedDate = originalFormat.parseUtc(date);
  final String formattedDate;
  if (minified == true) {
    formattedDate = DateFormat("MMMM dd, yyyy").format(parsedDate);
  } else {
    formattedDate = DateFormat("MMMM dd, yyyy").format(parsedDate);
  }
  return formattedDate;
}

String getGreeting() {
  final now = DateTime.now();
  final currentTime = TimeOfDay.fromDateTime(now);

  if (currentTime.hour < 12) {
    return 'Good Morning';
  } else if (currentTime.hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

// Global Toast
showToast(context, String title, String message, Color? color) {
  return showOverlayNotification(
    (context) {
      return MessageNotification(
        title: title,
        message: message,
        color: color,
        onReply: () {
          OverlaySupportEntry.of(context)!.dismiss();
        },
      );
    },
    duration: const Duration(seconds: 3),
  );
}

class OverLayNotification extends StatelessWidget {
  final String title;
  final Duration duration;

  const OverLayNotification(
      {Key? key, required this.title, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          padding: EdgeInsets.all(16),
          color: Colors.blue,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

// Capitalized String
String capitalizeString(String? str) {
  if (str == null || str.isEmpty) {
    return str!;
  }
  return str[0].toUpperCase() + str.substring(1);
}

// Get percentage difference
double calculateCurrentAmountPercentage(num currentAmount, num targetAmount) {
  if (currentAmount >= targetAmount) {
    return 100.0; // Already reached or surpassed the target amount
  }

  double percentage = (currentAmount / targetAmount) * 100.0;
  return double.parse(percentage.toStringAsFixed(2));
}

class MessageNotification extends StatelessWidget {
  final VoidCallback onReply;
  final String message;
  final String? title;
  final Color? color;

  const MessageNotification({
    Key? key,
    required this.onReply,
    required this.message,
    this.color = Colors.green,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 90,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 1,
        ),
        color: color,
        child: ListTile(
          title: title == null
              ? null
              : Text(
                  '$title',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
          subtitle: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}

const Color primaryDarkColor = Color.fromRGBO(36, 77, 97, 1);
const Color textColor = Colors.black;
const Color secondaryDarkColor = Color.fromRGBO(19, 26, 46, 0.7);
const Color secondaryGoldColor = Color.fromRGBO(255, 199, 39, 1);
const Color secondaryGoldColorDarker = Color.fromARGB(255, 234, 178, 22);
const Color redDarkColor = Color.fromARGB(255, 223, 85, 108);
const Color dark2Color = Color.fromARGB(255, 40, 48, 105);
const Color texformfieldColor = Colors.white;
const Color backColor = Colors.white;
const Color dark4Color = Color(0xff24294C);
const Color dark5Color = Color.fromARGB(255, 65, 71, 123);
const Color labelColor = Color.fromARGB(189, 189, 189, 1);

const Color greyLightColor = Color(0xffF7F7F7);
const Color greyColor = Color(0xff40435d);
const Color greenColor = Color.fromRGBO(43, 141, 87, 1);
const Color containerBg = Color(0xff262B52);

//App colors
const Color codoWhite = Color.fromRGBO(247, 247, 247, 1);

final List<Color> grediantColor1 = [
  secondaryDarkColor,
  secondaryDarkColor.withOpacity(0.0)
];
const List<Color> grediantColor2 = [secondaryDarkColor, Color(0xff0E5944)];
final List<Color> grediantColor3 = [
  redDarkColor,
  redDarkColor.withOpacity(0.3)
];
