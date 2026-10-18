import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/user.login.dart';
import 'pages/customer.signup.dart';
import 'pages/customer.dashboard.dart';
import 'pages/shop.signup.dart';
import 'pages/shop.dashboard.dart';
import 'pages/item.add.dart';
import 'theme/app_theme.dart';


void main() async {
  dev.log('This is main function');
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString('token'),
  ));
}

class MyApp extends StatelessWidget {
  var id;
  final token;
  //final shopid;
  MyApp({
    required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store Locator',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routes: {
        //'/': (context) => CustomerDashboardPage(),
        '/': (context) => LoginPage(),
        // customer signup page
        '/customer_signup': (context) => RegisterPage(),
        // shop signup page
        '/shop_signup': (context) => ShopRegisterPage(),
        // customer dashboard page
        '/customer_dashboard': (context) => CustomerDashboardPage(),
        // shop dashboard page
        '/shop_dashboard': (context) => ShopDashboard(shopId: "65a9d9388ed17b6d45c3bb48"),
        //item add page
        '/item_add': (context) => AddItemPage(shopId: "65a9d9388ed17b6d45c3bb48"),
      },
    );
  }
}
