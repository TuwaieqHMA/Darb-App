import 'package:darb_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:darb_app/helpers/extensions/screen_helper.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/driver_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/bloc/chat_bloc/chat_bloc.dart';
import 'package:darb_app/widgets/chat_bubble.dart';
import 'package:darb_app/widgets/message_bar.dart';
import 'package:darb_app/pages/login_page.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final chatBloc = context.read<ChatBloc>();
    chatBloc.add(GetMessagesEvent());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 54, 54, 54),
        title: const Text(
          "Chat Room",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignedOutState) {
              context.pushAndRemove(LoginPage());
            }
            if (state is SignedOutState) {
              context.showErrorSnackBar(state.msg);
            }
          },
          child: IconButton(
            onPressed: () {
              authBloc.add(SignOutEvent());
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
      //==============================================================
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ShowMessageStreamState) {
            return StreamBuilder<List<Message>>(
              stream: state.messageList,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final messages = snapshot.data;
                  return Column(
                    children: [
                      Expanded(
                        child: messages!.isEmpty
                            ? const Center(
                                child: Text("Start Chatting"),
                              )
                            : ListView.builder(
                                reverse: true,
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  chatBloc.loadChatCache(message.userId);
                                  return ChatBubble(
                                    message: message,
                                    chat: chatBloc
                                            .chatCache[message.userId] ??
                                        Chat(0, DateTime.now(),'haya','nada'),
                                  );
                                },
                              ),
                      ),
                      MessageBar(),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("Sorry Nothing to display"),
                );
              },
            );
          }
          return const Center(
            child: Text("Sorry Nothing to display"),
          );
        },
      ),
    );
  }
}
