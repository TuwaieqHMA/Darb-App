import 'package:flutter/material.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/chat_model.dart'; // استيراد نموذج الدردشة
import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message,}) : super(key: key); // تحديث المتغيرات

  final Message message; // تحديث المتغير من Profile إلى Chat

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      // إظهار صورة دائرية للمرسل
      if (!message.isMine)
        CircleAvatar(
          backgroundColor: Colors.grey[500],
          child: Text(
            message.userId.substring(0, 2), // استخدام معرف السائق بدلاً من اسم المستخدم
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      SizedBox(height: 8),
      SizedBox(height: 4),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? const Color(0xff79CCC7)
                : const Color(0xffF3F0F3),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(8),
              bottomLeft: message.isMine
                  ? const Radius.circular(8)
                  : const Radius.circular(0),
              bottomRight: message.isMine
                  ? const Radius.circular(0)
                  : const Radius.circular(8),
              topRight: const Radius.circular(8),
            ),
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: message.isMine ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(height: 8),
      SizedBox(height: 4),
      Text(format(message.createdAt, locale: 'en_short')),
      SizedBox(height: 64),
    ];
    if (message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        mainAxisAlignment:
            message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}

/*Copy code
import 'package:flutter/material.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/models/chat_model.dart'; // استيراد نموذج الدردشة
import 'package:timeago/timeago.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message, required this.chat}) : super(key: key); // تحديث المتغيرات

  final Message message;
  final Chat chat; // تحديث المتغير من Profile إلى Chat

  @override
  Widget build(BuildContext context) {
    List<Widget> chatContents = [
      // إظهار صورة دائرية للمرسل
      if (!message.isMine)
        CircleAvatar(
          backgroundColor: Colors.red[200],
          child: Text(
            chat.driverId.substring(0, 2), // استخدام معرف السائق بدلاً من اسم المستخدم
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      SizedBox(height: 8),
      SizedBox(height: 4),
      Flexible(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: message.isMine
                ? const Color.fromARGB(255, 79, 158, 143)
                : const Color.fromARGB(255, 223, 223, 223),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15),
              bottomLeft: message.isMine
                  ? const Radius.circular(15)
                  : const Radius.circular(0),
              bottomRight: message.isMine
                  ? const Radius.circular(0)
                  : const Radius.circular(15),
              topRight: const Radius.circular(15),
            ),
          ),
          child: Text(
            message.message,
            style: TextStyle(
              color: message */