import 'package:flutter/material.dart';
import 'package:invest/utils/constants.dart';
import 'package:invest/utils/theme.dart';
import 'package:invest/screens/authentication/login.dart';
import 'package:provider/provider.dart';
import 'package:invest/providers/user_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  bool amountHidden = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    Widget profileDetails = Container(
      padding: const EdgeInsets.all(20),
      width: SizeConfig.blockSizeHorizontal * 100,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/icons/user.png',
              width: SizeConfig.blockSizeHorizontal * 20,
            ),
          ),
          const SizedBox(height: 20),
          Text(user!.name, style: displayNormalWhite),
          const SizedBox(height: 10),
          Text(user.email, style: displaySmallWhite),
        ],
      ),
    );
    Widget userInfo = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Info',
            style: displayNormalSlightlyBoldBlack,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: displaySmallThinBlack,
                    ),
                    Text(
                      user.name,
                      style: displayNormalBoldBlack,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: displaySmallThinBlack,
                    ),
                    Text(
                      user.email,
                      style: displayNormalBoldBlack,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: displaySmallThinBlack,
                        ),
                        Text(
                          '***********',
                          style: displayNormalBoldBlack,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Change',
                        style: displaySmallBoldLightGrey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    Widget accountSettings = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: displayNormalSlightlyBoldBlack,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            width: SizeConfig.blockSizeHorizontal * 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logout',
                      style: displaySmallThinBlack,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            activePage = 0;
                          });
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
    Widget profileSection = Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/blob/blob1.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  const Color.fromARGB(255, 2, 7, 93).withOpacity(0.8),
                  const Color.fromARGB(255, 22, 6, 112).withOpacity(0.3),
                ],
              ),
            ),
            child: profileDetails,
          ),
        ),
      ],
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: ListView(
            children: [
              profileSection,
              userInfo,
              accountSettings,
            ],
          ),
        ),
      ),
    );
  }
}
