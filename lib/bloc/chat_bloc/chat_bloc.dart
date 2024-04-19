// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
   final serviceLocator = GetIt.I.get<DBService>();

  // Map to store ID as a key and 
  //Chat object to store chat data
  Map<String, Chat> chatCache = {}; // تغيير اسم الماب من profileCache إلى chatCache

  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) {});

    //--- Get All Messages ----
    on<GetMessagesEvent>(getMessages);

    // -- Submit/Send a Message ---
    on<SubmitMessageEvent>(submitMessage);
  }

  FutureOr<void> submitMessage(event, emit) async {
    try {
      await serviceLocator.submitMessage(event.message);
      emit(SendMessageState());
      await serviceLocator.getMessagesStream();
      Stream<List<Message>> messages = serviceLocator.listOfMessages;
      emit(ShowMessageStreamState(messages));
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  FutureOr<void> getMessages(event, emit) async {
    await serviceLocator.getMessagesStream();
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    emit(ShowMessageStreamState(messages));
  }

  //------ Loading Chat message Data --- // تغيير اسم الدالة والماب
  Future<void> loadChatCache(String chatId) async { // تغيير اسم الدالة من loadProfileCache إلى loadChatCache
    if (chatCache[chatId] != null) { // تغيير اسم الماب من profileCache إلى chatCache
      return;
    }
    final  chatData = await serviceLocator.getChatData(chatId); // تغيير اسم الدالة من getProfileData إلى getChatData
    chatCache[chatId] = chatData; // تغيير اسم الماب من profileCache إلى chatCache
    await serviceLocator.getMessagesStream();
    Stream<List<Message>> messages = serviceLocator.listOfMessages;
    emit(ShowMessageStreamState(messages));
  }
}
