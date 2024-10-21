import 'package:invest/imports/imports.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

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
    logger(page == 'Home');
    return PersistentBottomNavBarItem(
      icon: SvgPicture.asset(
        'assets/svg/${page.toLowerCase()}.svg',
        width: 20,
        colorFilter: ColorFilter.mode(
          activePage ==
                  [
                    'Home',
                    'Plans',
                    'Transactions',
                    'Profile',
                  ].indexOf(page)
              ? primaryColor
              : Colors.grey,
          BlendMode.srcIn,
        ),
      ),
      title: page,
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: CupertinoColors.systemGrey,
      activeColorSecondary: Colors.black,
    );
  }

  _fetchTransactions(BuildContext context) async {
    // Retrieve user information from provider
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    // final token = userProvider.user?.token;

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
    //   // logger('error');
    //   // logger(error);
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
        systemNavigationBarColor: Colors.white,
      ),
    );
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: bottomNavigationController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        // confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: Colors.white,
        ),
        // popActionScreens: PopActionScreensType.all,
        // itemAnimationProperties: const ItemAnimationProperties(
        //   duration: Duration(milliseconds: 200),
        //   curve: Curves.ease,
        // ),
        // screenTransitionAnimation: const ScreenTransitionAnimation(
        //   animateTabTransition: true,
        //   curve: Curves.ease,
        //   duration: Duration(milliseconds: 200),
        // ),
        navBarStyle: NavBarStyle.style9,
        onItemSelected: (value) {
          setState(() {
            activePage = value;
          });
        },
      ),
    );
  }
}
