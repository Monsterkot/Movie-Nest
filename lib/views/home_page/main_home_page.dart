import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_nest_app/views/home_page/home_page.dart';
import 'package:movie_nest_app/views/home_page/widgets/drawer_screen.dart';

@RoutePage()
class MainHomePage extends StatelessWidget {
  const MainHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
