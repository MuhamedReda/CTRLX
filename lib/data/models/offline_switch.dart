class OfflineSwitch {
  String? serialNumber;
  int? state1;
  int? state2;
  int? state3;

  OfflineSwitch({this.serialNumber, this.state1, this.state2, this.state3});

  OfflineSwitch.fromJson(Map<String, dynamic> json) {
    
    serialNumber = json['serial_number'];

    state1 = int.parse(json['state_1']);
    state2 = int.parse(json['state_2']);
    state3 = int.parse(json['state_3']);
  }
}