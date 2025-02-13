import '../../enums.dart';

String generateAppConstantsUtilsTemplate() {
  return '''
class AppConstantsUtils {}
''';
}

String generateAppStringsUtilsTemplate() {
  return '''
class AppStringsUtils {
  static const String appName = "app_name";
  static const String appVersion = "app_version";
}
''';
}

String generateFontsNamesUtilsTemplate() {
  return '''
class FontsNamesUtils {
  static const String fontName = "font_name_from_pubscpec";
}
''';
}

String generateImagesSourcesUtilsTemplate() {
  return '''
class ImagesSourcesUtils {
  static const String image1 = "image1_src";
}
''';
}

String generateRoutesUtilsTemplate({required StateManagementTypes stateManagement}) {

  return '''
// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
${stateManagement.isGetX ? '''
import 'package:get/get.dart';
import '../../../bindings/app_bindings.dart';
''' : ''}

class AppRoutes {
  static const SPLASH = "/splash";
  static const HOME = "/home";
}

Map<String, Widget Function(BuildContext)> getAppRoutes(BuildContext context) => {
  AppRoutes.SPLASH: (context) => const Scaffold(),
  AppRoutes.HOME: (context) => const Scaffold(),
};

${stateManagement.isGetX ? '''
List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.SPLASH, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
  GetPage(name: AppRoutes.HOME, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
];
''' : ""}

class RoutesUtils {
  final String route;
  final dynamic arguments;
  final bool replace;
  final bool rewrite;
  const RoutesUtils({required this.route, this.arguments, this.replace = false, this.rewrite = false});

  static Future<void> buildPath({required List<RoutesUtils> pages}) async {
    if(pages.isEmpty) return;
    
    for(final page in pages) {
      changePage(page.route, arguments: page.arguments, replace: page.replace, rewrite: page.rewrite);
      
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

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
''';
}

String generateTextUtilsTemplate() {
  return '''
import 'package:flutter/material.dart';

import 'fonts_names_utils.dart';

class TextUtils {
  static TextStyle getSimpleTextStyle(
    bool bold, {
    Color? color,
    int? size,
    bool withFont = true,
    String? font,
    bool underline = false,
    double? height,
    double? letterSpacing,
    double? wordSpacing,
    FontStyle? fontStyle,
    Paint? foreground,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontFamily: withFont ? ( font ?? FontsNamesUtils.fontName) : null,
      decoration: underline ? TextDecoration.underline : TextDecoration.none,
      fontWeight: fontWeight ?? (bold ? FontWeight.bold : FontWeight.normal),
      fontSize: size != null ? (size == 3 ? 10 : size.toDouble()) : null,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      fontStyle: fontStyle,
      foreground: foreground,
    );
  }

  static RegExp regExpForRemoveHTMLTags = RegExp(r"<[^>]*>");
  static RegExp nbsp = RegExp(r"&nbsp;");

  static String textWorker(String str) {
    String option1 = str.replaceAll(TextUtils.regExpForRemoveHTMLTags, "");
    String option2 = option1.replaceAll(TextUtils.nbsp, " ");
    return option2;
  }
}

''';
}