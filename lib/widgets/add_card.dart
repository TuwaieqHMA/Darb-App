import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SupervisorAddCard extends StatelessWidget {
  SupervisorAddCard(
      {super.key,
      required this.text,
      required this.bgColor,
      required this.isPadding,
      required this.img,
      required this.img1,
      required this.mianAxis,
      required this.crossAxis,
      required this.imgColor,
      required this.onTap});
  String text;
  Color bgColor;
  String img;
  Color imgColor;
  bool img1;
  MainAxisAlignment mianAxis;
  CrossAxisAlignment crossAxis;
  bool isPadding;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth() * 0.9,
      height: context.getHeight() * 0.27, // 0.2
      margin: const EdgeInsets.only(
        top: 24,
      ),
      decoration: BoxDecoration(
        color: bgColor, // signatureBlueColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          width20,
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 38, // context.getWidth() * 0.1,
                  height: 40, // context.getWidth() * 0.1,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(60, 250, 246, 238),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 25,
                  ),
                ),
                width8,
                Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: inukFont,
                    color: whiteColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: mianAxis,
            crossAxisAlignment: crossAxis,
            children: [
              Stack(
                children: [
                  Image.asset(
                    img,
                    color: imgColor,
                  ),
                  img1
                      ? Positioned(
                          top: 30,
                          left: 10,
                          child: Image.asset(
                            "assets/images/school_bus.png",
                            color: const Color.fromARGB(255, 48, 126, 126),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ],
          ),
          isPadding
            ? width16
            : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
