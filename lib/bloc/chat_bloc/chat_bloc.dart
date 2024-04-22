// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:darb_app/data_layer/home_data_layer.dart';
import 'package:darb_app/models/chat_model.dart';
import 'package:darb_app/models/message_model.dart';
import 'package:darb_app/services/database_service.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

// For ChatBloc:
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final serviceLocator = GetIt.instance.get<DBService>();

  int? currentChatId;

  ChatBloc() : super(ChatInitial()) {
    on<GetMessagesEvent>(getMessages);
    on<SubmitMessageEvent>(submitMessage);
    on<CheckChatEvent>(checkChat);
    on<CreateChatEvent>(createChat);
  }

  Future<void> submitMessage(
      SubmitMessageEvent event, Emitter<ChatState> emit) async {
    if (event.message.trim().isNotEmpty) {
      try {
        await serviceLocator.submitMessage(event.message, currentChatId!);
      } catch (error) {
        emit(ChatErrorState(error.toString()));
      }
    }
  }

  Future<void> getMessages(
      GetMessagesEvent event, Emitter<ChatState> emit) async {
    Stream<List<Message>> messages =
        await serviceLocator.getMessagesStream(event.chatId);
    emit(ShowMessageStreamState(messages));
  }
//  Future<void> loadChatCache(int chatId) async {
//     if (chatCache[chatId] != null) {
//       return;
//     }
//     final  chatData = serviceLocator.getChatData(chatId );
//     chatCache[chatId] = chatData ;
//     await serviceLocator.getMessagesStream();
//     Stream<List<Message>> messages = serviceLocator.listOfMessages;
//     // ignore: invalid_use_of_visible_for_testing_member
//     emit(ShowMessageStreamState(messages));
//   }

  FutureOr<void> checkChat(
      CheckChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());

    try {
      List<Map<String, dynamic>> chatIdMap =
          await serviceLocator.checkChat(event.driverId, event.studentId);
          print(chatIdMap);
      if (chatIdMap.isNotEmpty) {
        currentChatId = chatIdMap[0]["id"];
        emit(ChatFoundState(chatId: chatIdMap[0]["id"]));
      } else {
        emit(ChatNotFoundState());
      }
    } catch (e) {
      print(e);
      emit(ChatErrorState(" هناك مشكلة في تحميل المحادثة "));
    }
  }

  FutureOr<void> createChat(
      CreateChatEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoadingState());
    try {
      await serviceLocator.createChat(event.driverId, event.studentId);
      await checkChat(
          CheckChatEvent(
            studentId: event.studentId,
            driverId: event.driverId,
          ),
          emit);
    } catch (e) {
      emit(ChatErrorState('هناك مشكلة'));
    }
  }
}

// class ChatBloc extends Bloc<ChatEvent, ChatState> {
//   final Locator = GetIt.I.get<HomeData>();
//    final serviceLocator = GetIt.I.get<DBService>();

//   // Map to store ID as a key and
//   //Chat object to store chat data
//   Map<String, Chat> chatCache = {}; // تغيير اسم الماب من profileCache إلى chatCache

//   ChatBloc() : super(ChatInitial()) {
//     on<ChatEvent>((event, emit) {});

//     //--- Get All Messages ----
//     on<GetMessagesEvent>(getMessages);

//     // -- Submit/Send a Message ---
//     on<SubmitMessageEvent>(submitMessage);

//     on<CheckChatEvent>(checkChat);

//     on<CreateChatEvent>(createChat);
//   }

//   FutureOr<void> submitMessage(event, emit) async {
//     try {
//       await serviceLocator.submitMessage(event.message);
//       emit(SendMessageState());
//       await serviceLocator.getMessagesStream();
//       Stream<List<Message>> messages = serviceLocator.listOfMessages;
//       emit(ShowMessageStreamState(messages));
//     } catch (error) {
//       emit(ChatErrorState(error.toString()));
//     }
//   }

//   FutureOr<void> getMessages(event, emit) async {
//     await serviceLocator.getMessagesStream();
//     Stream<List<Message>> messages = serviceLocator.listOfMessages;
//     emit(ShowMessageStreamState(messages));
//   }

//   //------ Loading Chat message Data --- // تغيير اسم الدالة والماب
//

//   FutureOr<void> checkChat(CheckChatEvent event, Emitter<ChatState> emit) async{
//     emit(ChatLoadingState());

//     try {
//        Map<String,dynamic> chatIdMap = await serviceLocator.checkChat(event.driverId, event.studentId);
//       if(chatIdMap.isNotEmpty){
//         emit(ChatFoundState(chatId: chatIdMap["chat_id"]));
//       }else{
//         emit(ChatNotFoundState());
//       }
//     } catch (e) {
//       emit(ChatErrorState(" هناك مشكلة في تحميل المحادثة "));
//     }
//   }

//   FutureOr<void> createChat(CreateChatEvent event, Emitter<ChatState> emit) async{
//     emit(ChatLoadingState());
//     try {
//       await serviceLocator.createChat(event.driverId, event.studentId);
//       checkChat(CheckChatEvent(studentId: event.studentId, driverId: event.driverId,), emit);
//     } catch (e) {
//       emit(ChatErrorState('هناك مشكلة'));
//     }
//   }
// }
