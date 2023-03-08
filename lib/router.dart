import 'package:flutter/material.dart';
import 'package:hostelp/details_screen.dart';
import 'package:hostelp/features/Hostel_list/hostel_list.dart';
import 'package:hostelp/features/auth/screens/login_screen.dart';
import 'package:hostelp/features/notifications/screens/notification_screen.dart';
import 'package:hostelp/features/home/screens/home_screen_new.dart';
import 'package:hostelp/features/payment/screens/add_members.dart';
import 'package:hostelp/features/search/screens/search_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreenNew()),
  '/search': (_) => const MaterialPage(child: SearchScreen()),
  '/hostel': (_) => const MaterialPage(child: HostelList()),
  '/hostel-detail': (_) => const MaterialPage(child: DetailScreen()),
  '/add-members': (_) => const MaterialPage(child: AddMembersScreen())
  '/notifications': (_) => const MaterialPage(child: NotificationScreen()),
});
