class ThoughtModel {
  int? id;
  String? quote;
  int? createdAt;
  ThoughtUserModel? user;

  ThoughtModel({this.id, this.quote, this.createdAt, this.user});

  ThoughtModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    quote = json['quote'];
    createdAt = int.parse(json['created_At']);
    user =
        json['user'] != null ? ThoughtUserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quote'] = quote;
    data['created_At'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ThoughtUserModel {
  int? id;
  String? username;
  String? password;
  String? name;
  int? createdAt;

  ThoughtUserModel(
      {this.id, this.username, this.password, this.name, this.createdAt});

  ThoughtUserModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    username = json['username'];
    password = json['password'];
    name = json['name'];
    createdAt = int.parse(json['createdAt']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['password'] = password;
    data['name'] = name;
    data['createdAt'] = createdAt;
    return data;
  }
}
