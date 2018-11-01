import 'package:flutter/material.dart';
import 'package:login_app/src/widgets/blog/blog_screen.dart';
import 'package:login_app/src/widgets/login/login_screen.dart';

final routes = {
  "/login": (BuildContext context) => new LoginScreen(),
  "/blog": (BuildContext context) => new BlogScreen(),
  "/home": (BuildContext context) => new LoginScreen(),
};
