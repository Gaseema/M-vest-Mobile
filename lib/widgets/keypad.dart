import 'package:flutter/material.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';

// KeyPad
class Keypad extends StatelessWidget {
  final Widget? actionButton;
  final ValueSetter<dynamic>? callback;

  Keypad({this.actionButton, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                '1',
                onTap: () => callback!('1'),
                context: context,
              ),
              _buildButton(
                '2',
                onTap: () => callback!('2'),
                context: context,
              ),
              _buildButton(
                '3',
                onTap: () => callback!('3'),
                context: context,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                '4',
                onTap: () => callback!('4'),
                context: context,
              ),
              _buildButton(
                '5',
                onTap: () => callback!('5'),
                context: context,
              ),
              _buildButton(
                '6',
                onTap: () => callback!('6'),
                context: context,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                '7',
                onTap: () => callback!('7'),
                context: context,
              ),
              _buildButton(
                '8',
                onTap: () => callback!('8'),
                context: context,
              ),
              _buildButton(
                '9',
                onTap: () => callback!('9'),
                context: context,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                actionButton ?? const SizedBox(width: 24, height: 24),
                onTap: actionButton != null ? () => callback!('.') : null,
                context: context,
              ),
              _buildButton(
                '0',
                onTap: () => callback!('0'),
                context: context,
              ),
              _buildButton(
                const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
                onTap: () => callback!('<'),
                context: context,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(dynamic content,
      {VoidCallback? onTap, required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(8.0), // Adjust the border radius as needed
      child: Container(
        color: Colors.transparent,
        width: SizeConfig.blockSizeHorizontal * 27,
        height: SizeConfig.blockSizeVertical * 10,
        child: content is String
            ? Center(
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            : content is Icon
                ? content
                : SizedBox(),
      ),
    );
  }
}
