import 'package:chat_app/Model/message.dart';
import 'package:chat_app/Model/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/room.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance.collection('users').withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<MyUser?> addUserToFirebaseFireStore(MyUser user) async {
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
    await docRef.set(user);
    return user;
  }

  static Future<MyUser?> getUserFromFireStore(String id) async {
    var collection = getUserCollection();
    var docRef = collection.doc(id);
    var res = await docRef.get();
    return res.data();
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance.collection('rooms').withConverter<Room>(
          fromFirestore: (snapshot, options) =>
              Room.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> createRoom(Room room) async {
    var docRef = getRoomCollection().doc();
    room.id = docRef.id;
    return docRef.set(room);
  }

  static Future<List<Room>> loadRooms() async {
    var querySnapshot = await getRoomCollection().get();
    return querySnapshot.docs
        .map((queryDocsSnapshot) => queryDocsSnapshot.data())
        .toList();
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> sendMessage(String roomId, Message message) {
    var messageDoc = getMessageCollection(roomId).doc();
    message.id = messageDoc.id;
    return messageDoc.set(message);
  }
}
