import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/pages/chat_view.dart';
import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/enums.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:darb_app/utils/spaces.dart';
import 'package:darb_app/widgets/atttendanceWidget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ListViewBar extends StatelessWidget {
  const ListViewBar({super.key, required this.i, required this.name, required this.status, this.isCurrent});

  final int i;
  final String name;
  final AttendanceStatus status;
  final bool? isCurrent;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: i.isEven ? lightyellowColor : whiteColor,
        border: const Border(
            bottom: BorderSide(color: signatureTealColor, width: 2)),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '$i  - $name',
                style: const TextStyle(
                  color: signatureTealColor,
                  fontFamily: inukFont,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                      context.push(ChatView(studentId: '', driverId: locator.currentUser.id!,), true);
                    
                  },
                  child: (isCurrent!) ? Image.asset(
                    "assets/icons/Messaging.png",
                  ) : nothing,
                ),
                const SizedBox(width: 12),
                (isCurrent!) ? Center(child: (status == AttendanceStatus.assueredPrecense) ? const Waiting() : (status == AttendanceStatus.present) ? const Present() : const Absent()) : nothing,
              ],
            ),
          ],
        ),
      ),
    );
  }
}