class Account {
  int? id;
  String? fname;
  String? lname;
  String? phone;
  String? email;
  String? password;
  map(dynamic obj) {
    this.email = obj['email'];
    this.password = obj['password'];
  }

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['fname'] = fname!;
    mapping['lname'] = lname!;
    mapping['phone'] = phone!;
    mapping['email'] = email!;
    mapping['password'] = password!;
    return mapping;
  }
}
