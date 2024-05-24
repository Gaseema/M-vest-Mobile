import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dio/dio.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:invest/utils/api.dart';

class ButtonUtils {
  static Widget ElevatedButton({
    required Function() onPressed,
    required Widget child,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }

  static Widget textButton({
    required Function() onPressed,
    required Widget child,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return Colors.transparent; // Set the color to transparent
            }
            return Colors
                .transparent; // Use the default overlay color for other states
          },
        ),
      ),
      child: child,
    );
  }
}

class CustomButton extends StatefulWidget {
  final bool? formValid;
  final String? validationMessage;
  final String text;
  final Color color;
  final dynamic url;
  final String method;
  final bool filled;
  final Map<String, dynamic> body;
  final Function(dynamic) onCompleted;

  const CustomButton({
    super.key,
    this.formValid,
    this.validationMessage,
    required this.text,
    this.color = primaryColor,
    required this.url,
    required this.method,
    this.filled = true,
    required this.body,
    required this.onCompleted,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isLoading = false;
  late ApiClient _apiClient;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;
    _apiClient = ApiClient(token ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading
          ? null
          : () async {
              // Check if form is valid
              if (widget.formValid == false) {
                return showToast(
                  context,
                  'Error!',
                  widget.validationMessage ?? '',
                  Colors.red[300]!,
                );
              }
              // Check if URL is null
              if (widget.url == null) {
                return widget.onCompleted({
                  'isSuccessful': true,
                });
              }
              setState(() {
                _isLoading = true;
              });
              try {
                // Initialize the response with a default value
                Response response = Response(
                    data: null, requestOptions: RequestOptions(path: ''));
                // Use the ApiClient here
                if (widget.method == 'GET') {
                  response = await _apiClient.get(widget.url);
                } else if (widget.method == 'POST') {
                  response = await _apiClient.post(
                    widget.url,
                    body: widget.body,
                  );
                } else if (widget.method == 'UPLOAD') {
                  response = await _apiClient.upload(
                    widget.url,
                    files: widget.body['files'],
                  );
                }
                widget.onCompleted(
                  {'isSuccessful': true, 'data': response.data},
                );
              } catch (e) {
                widget.onCompleted(
                  {'isSuccessful': false, 'error': e},
                );
                // Handle the error here
              } finally {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: widget.filled == true ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: widget.filled == true
              ? null
              : Border.all(color: primaryColor, width: 1),
        ),
        child: Center(
          child: _isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 20,
                )
              : Text(
                  widget.text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color:
                            widget.filled == true ? Colors.white : primaryColor,
                      ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}

class Budge extends StatelessWidget {
  final String text;
  final Function(dynamic) onTap;

  const Budge({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(true);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(231, 231, 239, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
      ),
    );
  }
}
