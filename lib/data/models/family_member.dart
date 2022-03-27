class FamilyMember {
  int? id;
  String? name;
  String? phone;
  String? address;
  String? accountType;
  String? email;
  int? userId;
  String? registerationType;

  FamilyMember({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.accountType,
    this.email,
    this.userId,
    this.registerationType,
  });

  FamilyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    accountType = json['account_type'];
    email = json['email'];
    userId = json['user_id'];
    registerationType = json['registeration_type'];
  }
}
