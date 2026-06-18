import 'package:flutter/widgets.dart';

class appText {
  static Widget primaryText({
    required var text,
    int? maxLines,
    FontWeight? fontWeight,
    Color? color,
    TextAlign? align,
    double? fontSize,
  }) {
    return Text(
      text ?? "--:--",
      maxLines: maxLines,
      textAlign: align,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "Roboto",
        color: color ?? Color(0xFF262626),
      ),
    );
  }
}
