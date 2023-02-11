import 'package:chat_app/Model/message.dart';
import 'package:chat_app/shared_data.dart';
import 'package:flutter/material.dart';

import '../../utils.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return message.senderId == SharedData.user?.id
        ? SentMessage(message.dateTime!, message.content!)
        : ReceivedMessage(
            message.dateTime!, message.content!, message.senderName!);
  }
}

class SentMessage extends StatelessWidget {
  int dateTime;
  String content;

  SentMessage(this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0xFF3598DB),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              )),
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Text(formatMessageDate(dateTime)),
      ],
    );
  }
}

class ReceivedMessage extends StatelessWidget {
  int dateTime;
  String content;
  String senderName;

  ReceivedMessage(this.dateTime, this.content, this.senderName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
              color: Color(0x0ff8f8f8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                topLeft: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              )),
          child: Text(
            content,
            style: const TextStyle(color: Color(0xFF787993)),
          ),
        ),
        Text(formatMessageDate(dateTime)),
      ],
    );
  }
}
