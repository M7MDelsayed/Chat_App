class Room {
  String? id;
  String? title;
  String? description;
  String? categoryId;

  Room({this.id, this.title, this.description, this.categoryId});

  Room.fromFireStore(Map<String, dynamic> data)
      : this(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          categoryId: data['categoryId'],
        );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'categoryId': categoryId,
    };
  }
}
