import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/more_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({
    super.key,
    required this.name,
    this.isSigned,
  });

  final String name;
  final bool? isSigned;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
      height: 52,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset("assets/icons/circle_person_icon.svg"),
          width8,
          Expanded(
              child: Text(
            name,
            style: const TextStyle(
              color: signatureTealColor,
              fontFamily: inukFont,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          )),
          width8,
          (isSigned != null)
              ? Text(
                  isSigned! ? "مسجل" : "غير مسجل",
                  style: TextStyle(
                      color: isSigned! ? greenColor : redColor,
                      fontFamily: inukFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )
              : nothing,
          MoreButton(
            onEditClick: (){},
            onDeleteClick: (){},
          )

        ],
      ),
    );
  }
}

