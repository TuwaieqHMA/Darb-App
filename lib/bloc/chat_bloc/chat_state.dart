part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

// ---- ResultStates ----
final class ChatSuccessState extends ChatState{}
// ignore: must_be_immutable
final class ChatErrorState extends ChatState{
  String msg;
  ChatErrorState(this.msg);
}

// ---- Show Messages State ---
// ignore: must_be_immutable
final class ShowMessageStreamState extends ChatState {
  Stream<List<Message>> messageList;
  ShowMessageStreamState(
    this.messageList,
  );
}
final class ChatLoadingState extends ChatState {}
final class ChatCreatedState extends ChatState {}
// ---- Sending message state -----
final class SendMessageState extends ChatState {}

final class ChatFoundState extends ChatState {
  final int chatId;

  ChatFoundState({required this.chatId});
}

final class ChatNotFoundState extends ChatState {}