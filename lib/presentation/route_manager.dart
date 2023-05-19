import 'package:cater_ease/presentation/auth/login.dart';
import 'package:cater_ease/presentation/auth/register.dart';
import 'package:cater_ease/presentation/function/new_function.dart';
import 'package:cater_ease/presentation/function/new_function_detail.dart';
import 'package:cater_ease/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

import 'style_manager.dart';

class Routes {
  static const String loginRoute = "/login";
  static const String homeRoute = "/home";
  static const String registerRoute = "/register";
  static const String mainRoute = "/";
  static const String testRoute = "/test";
  static const String newFunction = "/newFunction";
  static const String newFunctionDetail = "/newFunctionDetail";
  
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.registerRoute:
        {
          return MaterialPageRoute(
              builder: (_) => RegisterScreen(), settings: settings);
        }
      case Routes.loginRoute:
        {
          return MaterialPageRoute(
              builder: (_) => LoginScreen(), settings: settings);
        }
      case Routes.homeRoute:{
        return MaterialPageRoute(builder: (_) => HomeScreen());
      }
      case Routes.newFunction:{
        return MaterialPageRoute(builder: (_) => NewFunctionScreen());
      }
      case Routes.newFunctionDetail:{
        return MaterialPageRoute(builder: (_) => NewFunctionDetailScreen());
      }

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                  child: Text(
                "NO Route Found",
                style: getBoldStyle(fontColor: ColorManager.darkgrey),
              )),
            ));
  }
}
