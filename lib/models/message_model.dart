class Message {
  Message({
    this.id,
    this.createdAt,
    required this.message,
    required this.userId,
    required this.chatId,
  });
  
  late final int? id;
  late final DateTime? createdAt;
  late final String message;
  late final String userId;
  late final int chatId;
  
  Message.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json['created_at']),
        message = json['message'],
        userId = json['user_id'],
        chatId = json['chat_id'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['id'] = id; // No Need to send the id, since it's auto-generated
    // _data['created_at'] = createdAt.toIso8601String(); // No need to send the creation time since it's auto generated
    _data['message'] = message;
    _data['user_id'] = userId;
    _data['chat_id'] = chatId;
    return _data;
  }
}


// {
//      "id": 13,
//      "created_at": "2024-04-12T00:00:00.000",
//      "message": "hello, can you please come down?",
//      "user_id": "bfihebwieh873y872",
//      "chat_id": 19
// }