import 'package:flutter/material.dart';
import 'package:invest/utils/theme.dart';

class InputWidget extends StatefulWidget {
  final String? hintText;
  final bool? obscureText;
  final bool? enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final Color inputTextColor;
  final String? initialValue;

  const InputWidget({
    Key? key,
    this.hintText,
    this.obscureText,
    this.enabled = true,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.inputTextColor = Colors.black,
    required this.onChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  bool obscure = true;
  TextEditingController? controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: controller,
      obscureText: widget.obscureText == true ? obscure : false,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: widget.inputTextColor,
          ),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: (widget.suffixIcon != null)
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.obscureText == true) {
                      obscure = !obscure;
                    }
                  });
                },
                child: widget.suffixIcon,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            // color: inputInactiveColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: primaryColor,
            width: 2,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: textGreyColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 30,
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
