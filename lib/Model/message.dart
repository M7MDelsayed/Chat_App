class Message {
  String? id;
  String? content;
  String? senderId;
  String? senderName;
  int? dateTime;
  String? roomId;

  Message(
      {this.id,
      this.content,
      this.senderId,
      this.senderName,
      this.dateTime,
      this.roomId});

  Message.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          content: data['content'],
          senderId: data['senderId'],
          senderName: data['senderName'],
          dateTime: data['dateTime'],
          roomId: data['roomId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'content': content,
      'senderId': senderId,
      'senderName': senderName,
      'dateTime': dateTime,
      'roomId': roomId,
    };
  }
}
