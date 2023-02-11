import 'package:chat_app/Base/base_viewModel.dart';
import 'package:chat_app/DataBase/my_database.dart';
import 'package:chat_app/Model/room.dart';

import 'add_room_navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator> {
  void addRoom(String title, String description, String categoryId) async {
    try {
      navigator?.showLoading('Creating Room...');
      await MyDataBase.createRoom(
        Room(title: title, description: description, categoryId: categoryId),
      );
      navigator?.hideLoading();
      navigator?.showMessage('Room Created Successfully ', 'OK', () {
        navigator?.goBack();
        navigator?.goBack();
      });
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage(
          'SomeThing Went Wrong . ${e.toString()}', 'Try Again', () {
        navigator?.hideLoading();
      });
    }
  }
}
