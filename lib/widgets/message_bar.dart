import 'package:darb_app/bloc/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class MessageBar extends StatelessWidget {
  const MessageBar({
    super.key,
    required this.msgController,
  });

  final TextEditingController msgController;

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>(); //-----------
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTapOutside: (event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              controller: msgController,
              decoration: InputDecoration(
                hintText: '...اكتب هنا ',
                contentPadding: const EdgeInsets.all(8),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(35),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              String message = msgController.text.trim();
              if (message.isNotEmpty) {
                chatBloc.add(SubmitMessageEvent(
                    message: msgController.text,
                    chatId: chatBloc.currentChatId!));
                msgController.clear();
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(10),
              // decoration: const BoxDecoration(
              //   color: Color.fromARGB(255, 249, 249, 156),
              //   shape: BoxShape.circle,
              // ),
              child: const Icon(
                Icons.send,
                color: Color.fromARGB(255, 249, 249, 156),
                size: 45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
