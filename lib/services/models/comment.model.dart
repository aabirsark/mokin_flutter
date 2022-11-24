class Comment {
  int? id;
  String? type;
  int? rootUserId;
  String? value;
  int? createdAt;
  ActiviyByUserId? activiyByUserId;

  Comment(
      {this.id,
      this.type,
      this.rootUserId,
      this.value,
      this.createdAt,
      this.activiyByUserId});

  Comment.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    type = json['type'];
    rootUserId = json['rootUserId'];
    value = json['value'];
    createdAt = int.parse(json['createdAt']);
    activiyByUserId = json['activiyByUserId'] != null
        ? ActiviyByUserId.fromJson(json['activiyByUserId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['rootUserId'] = rootUserId;
    data['value'] = value;
    data['createdAt'] = createdAt;
    if (activiyByUserId != null) {
      data['activiyByUserId'] = activiyByUserId!.toJson();
    }
    return data;
  }
}

class ActiviyByUserId {
  int? id;
  String? username;
  String? password;
  String? name;
  int? createdAt;

  ActiviyByUserId(
      {this.id, this.username, this.password, this.name, this.createdAt});

  ActiviyByUserId.fromJson(Map<String, dynamic> json) {
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
