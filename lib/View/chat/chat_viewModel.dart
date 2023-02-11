import 'package:chat_app/DataBase/my_database.dart';
import 'package:chat_app/Model/message.dart';
import 'package:chat_app/Model/room.dart';
import 'package:chat_app/shared_data.dart';

import '../../Base/base_viewModel.dart';
import 'chat_navigator.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;

  void send(String messageContent) {
    if (messageContent.trim().isEmpty) return;
    var message = Message(
      content: messageContent,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      roomId: room.id,
      senderId: SharedData.user?.id,
      senderName: SharedData.user?.userName,
    );
    MyDataBase.sendMessage(room.id ?? '', message).then((value) {
      navigator?.clearMessageText();
    }).onError((error, stackTrace) {
      navigator?.showMessage(
        'Something Went Wrong',
        'Try Again',
        () {
          send(messageContent);
        },
        negButton: 'Cancel',
        negAction: () {
          navigator?.hideLoading();
        },
      );
    });
  }
}
