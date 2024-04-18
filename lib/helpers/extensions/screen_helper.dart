import 'package:darb_app/utils/colors.dart';
import 'package:flutter/material.dart';

extension Screen on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }

  push(Widget view, bool isPushOnly) {
    return Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (route) => view),
        (Route<dynamic> route) => isPushOnly);
  }

  pop() {
    return Navigator.pop(this);
  }

  showSuccessSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: greenColor,
    ));
  }

  showErrorSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: redColor,
    ));
  }

  showTopSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: getHeight() - 100),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: signatureBlueColor,
    ));
  }

}