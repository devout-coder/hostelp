import 'package:flutter/material.dart';
import 'package:hostelp/mytheme.dart';
import 'package:hostelp/router.dart';
import 'package:routemaster/routemaster.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      darkTheme: darktheme,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedInRoute),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
