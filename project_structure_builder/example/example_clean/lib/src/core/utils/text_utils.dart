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

