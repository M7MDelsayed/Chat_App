import 'package:chat_app/Base/base_state.dart';
import 'package:chat_app/View/add_room/add_room_screen.dart';
import 'package:chat_app/View/home/home_navigator.dart';
import 'package:chat_app/View/home/home_viewModel.dart';
import 'package:chat_app/View/home/room_widget.dart';
import 'package:chat_app/View/login/login_screen.dart';
import 'package:chat_app/shared_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadRooms();
  }

  @override
  Widget build(BuildContext context) {
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
              title: const Text('Chat App'),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                    SharedData.user = null;
                  },
                  child: const Icon(Icons.logout),
                )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddRoom.routeName);
              },
              child: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Consumer<HomeViewModel>(
                    builder: (context, homeViewModel, child) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          return RoomWidget(homeViewModel.rooms[index]);
                        },
                        itemCount: homeViewModel.rooms.length,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel initViewModel() {
    return HomeViewModel();
  }
}
