class Timer {
  String? time;
  int? userId;
  int? switchId;
  int? state;
  String? subNo;
  int? id;

  Timer(
      {this.time,
      this.userId,
      this.switchId,
      this.state,
      this.subNo,
      this.id});

  Timer.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    userId = json['user_id'];
    switchId = json['switch_id'];
    state = json['state'];
    subNo = json['sub_no'];
    id = json['id'];
  }
}