import 'package:flutter/material.dart';

import 'views/home_page.dart';
import 'views/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StopWatch - rxNotifier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => SplashPage(),
        '/home': (_) => HomePage(),
      },
    );
  }
}
