import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// this funtion redirects the page with animation
Route createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (c, anim, a2, child) =>
        FadeTransition(opacity: anim, child: child),
    transitionDuration: Duration(milliseconds: 500),
  );
}

Future<void> setLoginStatus(value) async {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.setBool("isLoggedIn", value);
}
