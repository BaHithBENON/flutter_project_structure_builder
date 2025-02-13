import '../../enums.dart';

/// Generates the AppConstantsUtils class template.
///
/// This function returns a string containing the definition of the
/// AppConstantsUtils class, which serves as a placeholder for
/// application-wide constant utilities.
String generateAppConstantsUtilsTemplate() {
  return '''
/// A utility class for defining application-wide constants.
///
/// This class is meant to hold constant values that are used
/// throughout the application.
class AppConstantsUtils {}
''';
}

/// Generates the AppStringsUtils class template.
///
/// This function returns a string containing the definition of the
/// AppStringsUtils class, which serves as a placeholder for
/// application-wide string utilities.
///
/// The class contains two constant string values:
/// - [appName]: the name of the application.
/// - [appVersion]: the version of the application.
String generateAppStringsUtilsTemplate() {
  return '''
/// A utility class for defining application-wide strings.
///
/// This class is meant to hold string values that are used
/// throughout the application.
class AppStringsUtils {
  /// The name of the application.
  static const String appName = "app_name";

  /// The version of the application.
  static const String appVersion = "app_version";
}
''';
}

/// Generates the FontsNamesUtils class template.
///
/// This function returns a string containing the definition of the
/// FontsNamesUtils class, which serves as a placeholder for
/// application-wide font name utilities.
///
/// The class contains one constant string value:
/// - [fontName]: the name of the font.
String generateFontsNamesUtilsTemplate() {
  return '''
/// A utility class for defining application-wide font names.
///
/// This class is meant to hold font name values that are used
/// throughout the application.
class FontsNamesUtils {
  /// The name of the font.
  static const String fontName = "font_name_from_pubscpec";
}
''';
}

/// Generates the ImagesSourcesUtils class template.
///
/// This function returns a string containing the definition of the
/// ImagesSourcesUtils class, which serves as a placeholder for
/// application-wide image source utilities.
///
/// The class contains one constant string value:
/// - [image1]: the source of the first image.
String generateImagesSourcesUtilsTemplate() {
  return '''
/// A utility class for defining application-wide image sources.
///
/// This class is meant to hold image source values that are used
/// throughout the application.
class ImagesSourcesUtils {
  /// The source of the first image.
  static const String image1 = "image1_src.jpg";
}
''';
}

/// Generates the AppRoutesUtils class template.
///
/// This function returns a string containing the definition of the
/// AppRoutesUtils class, which serves as a placeholder for
/// application-wide route utilities.
///
/// The class contains the following properties and methods:
/// - [route]: the route of the page.
/// - [arguments]: the arguments of the page.
/// - [replace]: whether to replace the current page with the new one.
/// - [rewrite]: whether to rewrite the current page with the new one.
/// - [buildPath]: a static method that builds the path of the pages.
/// - [changePage]: a static method that changes the current page.
String generateRoutesUtilsTemplate({required StateManagementTypes stateManagement}) {

  return '''
// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
${stateManagement.isGetX ? '''
import 'package:get/get.dart';
import '../../../bindings/app_bindings.dart';
''' : ''}

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

${stateManagement.isGetX ? '''
/// A list of the pages and their corresponding bindings.
///
/// The list contains the following pages:
/// - [AppRoutes.SPLASH]: the splash page.
/// - [AppRoutes.HOME]: the home page.
List<GetPage<dynamic>> getPages = [
  GetPage(name: AppRoutes.SPLASH, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
  GetPage(name: AppRoutes.HOME, page: () => const Scaffold(), transition: Transition.noTransition, binding: AppBinding()), 
];
''' : ""}

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
''';
}

/// A utility class for defining text related utilities.
///
/// The class contains the following properties and methods:
/// - [getSimpleTextStyle]: a method that returns a simple text style.
/// - [textWorker]: a method that removes HTML tags from a string.
/// - [regExpForRemoveHTMLTags]: a regular expression that matches HTML tags.
/// - [nbsp]: a regular expression that matches the HTML entity for a non-breaking space.
String generateTextUtilsTemplate() {
  return '''
import 'package:flutter/material.dart';

import 'fonts_names_utils.dart';

class TextUtils {
  /// Returns a simple text style.
  ///
  /// The method takes a boolean argument [bold] that defines whether the text
  /// style should be bold or not.
  /// The method also takes the following optional arguments:
  /// - [color]: the color of the text.
  /// - [size]: the size of the text.
  /// - [withFont]: whether to use a font or not.
  /// - [font]: the name of the font.
  /// - [underline]: whether to underline the text or not.
  /// - [height]: the height of the text.
  /// - [letterSpacing]: the letter spacing of the text.
  /// - [wordSpacing]: the word spacing of the text.
  /// - [fontStyle]: the font style of the text.
  /// - [foreground]: the foreground paint of the text.
  /// - [fontWeight]: the font weight of the text.
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
      fontFamily: withFont ? (font ?? FontsNamesUtils.fontName) : null,
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

  /// A regular expression that matches HTML tags.
  static final RegExp regExpForRemoveHTMLTags = RegExp(r"<[^>]*>");

  /// A regular expression that matches the HTML entity for a non-breaking space.
  static final RegExp nbsp = RegExp(r"&nbsp;");

  /// Removes HTML tags and non-breaking spaces from a string.
  ///
  /// The method takes a string as an argument and returns a new string with all
  /// HTML tags and non-breaking spaces removed.
  static String textWorker(String str) {
    String option1 = str.replaceAll(regExpForRemoveHTMLTags, "");
    String option2 = option1.replaceAll(nbsp, " ");
    return option2;
  }
}

''';
}