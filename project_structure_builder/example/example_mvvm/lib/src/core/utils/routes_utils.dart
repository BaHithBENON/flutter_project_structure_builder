// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../bindings/app_bindings.dart';


class AppRoutes {
  /// The name of the splash page.
  static const String SPLASH = "/splash";

  /// The name of the home page.
  static const String HOME = "/home";
}

/// A map of the routes and their corresponding widgets.
///
/// The map contains the following keys:
/// - [AppRoutes.SPLASH]: the splash page.
/// - [AppRoutes.HOME]: the home page.
Map<String, Widget Function(BuildContext)> getAppRoutes(BuildContext context) => {
  AppRoutes.SPLASH: (context) => const Scaffold(),
  AppRoutes.HOME: (context) => const Scaffold(),
};

/// A list of the pages and their corresponding bindings.
///
/// The list contains the following pages:
/// - [AppRoutes.SPLASH]: the splash page.
/// - [AppRoutes.HOME]: the home page.
List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.SPLASH, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
  GetPage(name: AppRoutes.HOME, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
];


/// A utility class for defining application-wide route utilities.
///
/// The class contains the following properties and methods:
/// - [route]: the route of the page.
/// - [arguments]: the arguments of the page.
/// - [replace]: whether to replace the current page with the new one.
/// - [rewrite]: whether to rewrite the current page with the new one.
/// - [buildPath]: a static method that builds the path of the pages.
/// - [changePage]: a static method that changes the current page.
class RoutesUtils {
  /// The route of the page.
  final String route;

  /// The arguments of the page.
  final dynamic arguments;

  /// Whether to replace the current page with the new one.
  final bool replace;

  /// Whether to rewrite the current page with the new one.
  final bool rewrite;

  /// Creates an instance of [RoutesUtils].
  const RoutesUtils({required this.route, this.arguments, this.replace = false, this.rewrite = false});

  /// Builds the path of the pages.
  ///
  /// The method takes a list of [RoutesUtils] as an argument and builds the path
  /// of the pages.
  static Future<void> buildPath({required List<RoutesUtils> pages}) async {
    if(pages.isEmpty) return;
    
    for(final page in pages) {
      changePage(page.route, arguments: page.arguments, replace: page.replace, rewrite: page.rewrite);
      
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  /// Changes the current page.
  ///
  /// The method takes the route of the page and its arguments as arguments.
  /// If [replace] is true, the current page is replaced with the new one.
  /// If [rewrite] is true, the current page is rewritten with the new one.
  static void changePage(String route, {dynamic arguments, bool replace = false, bool rewrite = false}) {
    if(replace) {
      Get.offAllNamed(route, arguments: arguments);
    } else if(rewrite) {
      Get.offNamed(route, arguments: arguments);
    } else {
      Get.toNamed(route, arguments: arguments);
    }
  }
}
