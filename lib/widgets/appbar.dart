import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final VoidCallback? leadingOnTap;
  final SystemUiOverlayStyle overlay;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.overlay,
    this.actions = const [],
    this.leadingOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w300,
            ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: leadingOnTap ?? () {},
      ),
      actions: actions,
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: overlay,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
