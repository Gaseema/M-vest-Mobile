import 'package:invest/imports/imports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget> actions;
  final VoidCallback? leadingOnTap;
  final Brightness statusBarBrightness;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions = const [],
    this.leadingOnTap,
    this.statusBarBrightness = Brightness.light,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: statusBarBrightness,
      ),
    );
    return AppBar(
      titleSpacing: 0,
      foregroundColor: Colors.white,
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
