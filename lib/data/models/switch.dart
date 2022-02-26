class Switch {
  int? id;
  String? serialNumber;
  String? type;
  int? state1;
  int? state2;
  int? state3;
  String? sub1;
  String? sub2;
  String? sub3;
  String? activationDate;
  String? name;
  int? roomId;
  String? createdAt;
  String? updatedAt;

  Switch(
      {this.id,
      this.serialNumber,
      this.type,
      this.state1,
      this.state2,
      this.state3,
      this.sub1,
      this.sub2,
      this.sub3,

      this.activationDate,
      this.name,
      this.roomId,
      this.createdAt,
      this.updatedAt});

  Switch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serialNumber = json['serial_number'];
    type = json['type'];
    state1 = json['state_1'];
    state2 = json['state_2'];
    state3 = json['state_3'];
    sub1 = json['sub_1'];
    sub2 = json['sub_2'];
    sub3 = json['sub_3'];
    activationDate = json['activation_date'];
    name = json['name'];
    roomId = json['room_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}