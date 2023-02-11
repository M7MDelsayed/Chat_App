class RoomCategory {
  String id;
  String name;
  String imageName;

  RoomCategory({required this.id, required this.name, required this.imageName});

  static List<RoomCategory> getRoomCategory() {
    return [
      RoomCategory(id: 'sports', name: 'Sports', imageName: 'sports.png'),
      RoomCategory(id: 'music', name: 'Music', imageName: 'music.png'),
      RoomCategory(id: 'movies', name: 'Movies', imageName: 'movies.png'),
    ];
  }

  static RoomCategory getCategoryById(String id) {
    switch (id) {
      case 'music':
        {
          return RoomCategory(
              id: 'music', name: 'Music', imageName: 'music.png');
        }
      case 'movies':
        {
          return RoomCategory(
              id: 'movies', name: 'Movies', imageName: 'movies.png');
        }
      case 'sports':
        {
          return RoomCategory(
              id: 'sports', name: 'Sports', imageName: 'sports.png');
        }
    }
    return RoomCategory(id: 'sports', name: 'Sports', imageName: 'sports.png');
  }
}
