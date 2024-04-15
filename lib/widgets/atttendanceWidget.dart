import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';

class Present extends StatelessWidget {
  const Present({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
        border: Border.all(color: signatureTealColor, width: 2),
      ),
      child: const Center(
        child: Text(
          'حاضر',
          style: TextStyle(
            color: signatureTealColor,
            fontFamily: inukFont,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class Absent extends StatelessWidget {
  const Absent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
        border: Border.all(color: redColor, width: 2),
      ),
      child: const Center(
        child: Text(
          'غائب',
          style: TextStyle(
            color: redColor,
            fontFamily: inukFont,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class Waiting extends StatelessWidget {
  const Waiting({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27,
      width: 98,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: whiteColor,
        border: Border.all(color: signatureYellowColor, width: 2),
      ),
      child: const Center(
        child: Text(
          'انتظار',
          style: TextStyle(
            color: signatureYellowColor,
            fontFamily: inukFont,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}