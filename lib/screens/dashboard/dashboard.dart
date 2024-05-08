import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/screens/dashboard/home.dart';
import 'package:invest/screens/dashboard/plans.dart';
import 'package:invest/screens/dashboard/transactions.dart';
import 'package:invest/screens/dashboard/profile.dart';
import 'package:invest/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  List<Widget> _buildScreens() {
    return [
      const Home(),
      const Plans(),
      const Transactions(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      iconBarStyle('Home'),
      iconBarStyle('Plans'),
      iconBarStyle('Transactions'),
      iconBarStyle('Profile'),
    ];
  }

  iconBarStyle(String page) {
    return PersistentBottomNavBarItem(
      icon: Image.asset(
        page == 'Home'
            ? activePage == 0
                ? 'assets/icons/home.png'
                : 'assets/icons/home.png'
            : page == 'Plans'
                ? activePage == 1
                    ? 'assets/icons/clipboard.png'
                    : 'assets/icons/clipboard.png'
                : page == 'Transactions'
                    ? activePage == 2
                        ? 'assets/icons/transaction.png'
                        : 'assets/icons/transaction.png'
                    : activePage == 3
                        ? 'assets/icons/profile.png'
                        : 'assets/icons/profile.png',
        width: SizeConfig.blockSizeHorizontal * 5,
      ),
      title: page,
      activeColorPrimary: primaryDarkColor,

      inactiveColorPrimary: CupertinoColors.systemGrey,
      activeColorSecondary: primaryDarkColor,
      // textStyle: smallTextBlueBold(),
    );
  }

  _fetchTransactions(BuildContext context) async {
    // Retrieve user information from provider
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final token = userProvider.user?.token;

    // final postData = {};
    // final apiClient = ApiClient();
    // final headers = {
    //   'Authorization': 'Bearer $token',
    //   'Content-Type': 'application/json',
    // };
    // await apiClient
    //     .post('/transaction/fetch/user_transactions', postData,
    //         headers: headers)
    //     .then((response) {
    //   final userTransactionsProvider = Provider.of<UserTransactionsProvider>(
    //     context,
    //     listen: false,
    //   );
    //   userTransactionsProvider.updateUserTransactions(response['transactions']);
    // }).catchError((error) {
    //   // Handle the error
    //   // print('error');
    //   // print(error);
    // });
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactions(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: bottomNavigationController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style1,
        onItemSelected: (value) {
          setState(() {
            activePage = value;
          });
        },
      ),
    );
  }
}
