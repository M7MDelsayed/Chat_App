import 'package:chat_app/Base/base_state.dart';
import 'package:chat_app/DataBase/my_database.dart';
import 'package:chat_app/Model/message.dart';
import 'package:chat_app/Model/room.dart';
import 'package:chat_app/View/chat/chat_navigator.dart';
import 'package:chat_app/View/chat/chat_viewModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'message_widget.dart';

class ChatThread extends StatefulWidget {
  static const String routeName = 'chat-thread';

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends BaseState<ChatThread, ChatViewModel>
    implements ChatNavigator {
  late Room room;
  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Image.asset(
            'assets/images/main_background.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('${room.title}'),
              centerTitle: true,
            ),
            body: Card(
              elevation: 18,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: MyDataBase.getMessageCollection(room.id ?? '')
                          .orderBy('dateTime', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something Went Wrong'),
                          );
                        }
                        var data = snapshot.data?.docs
                            .map((doc) => doc.data())
                            .toList();
                        return ListView.separated(
                          reverse: true,
                          padding: const EdgeInsets.all(8),
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 8,
                            );
                          },
                          itemBuilder: (context, index) {
                            return MessageWidget(data![index]);
                          },
                          itemCount: data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(12),
                                )),
                            child: TextField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(4),
                                hintText: 'Your Message Here',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        InkWell(
                          onTap: () {
                            viewModel.send(messageController.text);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFF3598DB)),
                            child: Row(
                              children: const [
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatViewModel initViewModel() {
    return ChatViewModel();
  }

  @override
  void clearMessageText() {
    messageController.clear();
  }
}
