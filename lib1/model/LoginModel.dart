class LoginModel {
  LoginModel({
    required this.status,
    required this.message,
    required this.userId,
    required this.name,
    required this.company,
    required this.userRoll,
  });
  late final bool status;
  late final String message;
  late final String userId;
  late final String name;
  late final String company;
  late final String userRoll;

  LoginModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    name = json['name'];
    company = json['company'];
    userRoll = json['user_roll'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['user_id'] = userId;
    _data['name'] = name;
    _data['company'] = company;
    _data['user_roll'] = userRoll;
    return _data;
  }
}