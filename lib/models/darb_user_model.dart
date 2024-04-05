class DarUser {
  DarUser({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
  });
  late final String id;
  late final String name;
  late final String email;
  late final String password;
  
  DarUser.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}