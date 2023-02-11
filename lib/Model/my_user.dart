class MyUser {
  String? id;
  String? userName;
  String? fullName;
  String? email;

  MyUser({this.fullName, this.userName, this.email, this.id});

  MyUser.fromFireStore(Map<String, dynamic> data)
      : this(
          fullName: data['fullName'],
          userName: data['userName'],
          email: data['email'],
          id: data['id'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'id': id
    };
  }
}
