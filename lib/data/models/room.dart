class Room {
  int? id;
  String? name;
  String? userId;
  String? photoLink;

  Room(
      {this.id,
      this.name,
      this.userId,
      this.photoLink,
      });

  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    photoLink = json['photo_link'];
    
  }
}
