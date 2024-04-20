import 'package:flutter/material.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';

// KeyPad
class Keypad extends StatelessWidget {
  final dynamic dot;
  final ValueSetter<dynamic>? callback;
  const Keypad({super.key, @required this.dot, this.callback});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      callback!('1');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '1',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTapDown: (x) {
                      callback!('4');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '4',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('7');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '7',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  dot == false
                      ? Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 7,
                            right: SizeConfig.blockSizeHorizontal * 7,
                            top: SizeConfig.blockSizeHorizontal * 4,
                            bottom: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          child: Text(
                            '',
                            style: displayKeyPadTextBlack,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            callback!('.');
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 7,
                              right: SizeConfig.blockSizeHorizontal * 7,
                              top: SizeConfig.blockSizeHorizontal * 4,
                              bottom: SizeConfig.blockSizeHorizontal * 4,
                            ),
                            child: Text(
                              '.',
                              style: displayKeyPadTextBlack,
                            ),
                          ),
                        ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      callback!('2');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '2',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('5');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '5',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('8');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '8',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('0');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '0',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      callback!('3');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '3',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('6');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '6',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('9');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Text(
                        '9',
                        style: displayKeyPadTextBlack,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      callback!('<');
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeHorizontal * 4,
                        bottom: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      child: Image.asset(
                        'assets/icons/backButton.png',
                        width: SizeConfig.blockSizeHorizontal * 5,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
