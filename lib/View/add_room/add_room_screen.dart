import 'package:chat_app/Base/base_state.dart';
import 'package:chat_app/Model/add_room.dart';
import 'package:chat_app/View/add_room/add_room_navigator.dart';
import 'package:chat_app/View/add_room/add_room_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoom extends StatefulWidget {
  static const String routeName = 'Add-Room';

  @override
  State<AddRoom> createState() => _AddRoomState();
}

class _AddRoomState extends BaseState<AddRoom, AddRoomViewModel>
    implements AddRoomNavigator {
  var formKey = GlobalKey<FormState>();

  var roomNameController = TextEditingController();

  var roomDescriptionController = TextEditingController();

  List<RoomCategory> allCategory = RoomCategory.getRoomCategory();

  late RoomCategory selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = allCategory[0];
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
            ),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.all(12),
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Create New Room',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset('assets/images/add_room_image.png'),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Room Name';
                              }
                              return null;
                            },
                            controller: roomNameController,
                            decoration: InputDecoration(
                              hintText: 'Enter Room Name',
                              labelText: 'Room Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButton<RoomCategory>(
                            value: selectedCategory,
                            underline: Container(),
                            items: allCategory.map((category) {
                              return DropdownMenuItem<RoomCategory>(
                                value: category,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/${category.imageName}',
                                        width: 45,
                                        height: 45,
                                      ),
                                    ),
                                    Text(category.name),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (item) {
                              if (item == null) return;
                              setState(() {
                                selectedCategory = item;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            validator: (text) {
                              if (text == null || text.trim().isEmpty) {
                                return 'Please Enter Room Description';
                              }
                              return null;
                            },
                            controller: roomDescriptionController,
                            minLines: 3,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Room Description',
                              labelText: 'Room Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF3598DB),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(12),
                                )),
                            onPressed: () {
                              submit();
                            },
                            child: const Text(
                              'Create',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submit() {
    if (formKey.currentState?.validate() == false) return;
    viewModel.addRoom(roomNameController.text, roomDescriptionController.text,
        selectedCategory.id);
  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  goBack() {
    Navigator.pop(context);
  }
}
