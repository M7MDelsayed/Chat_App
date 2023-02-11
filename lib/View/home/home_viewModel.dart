import '../../Base/base_viewModel.dart';
import '../../DataBase/my_database.dart';
import '../../Model/room.dart';
import 'home_navigator.dart';

class HomeViewModel extends BaseViewModel<HomeNavigator> {
  List<Room> rooms = [];

  void loadRooms() async {
    rooms = await MyDataBase.loadRooms();
    notifyListeners();
  }
}
