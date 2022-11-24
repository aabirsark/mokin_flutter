class Activity {
  int? id;
  String? type;
  int? createdAt;
  ActivityUser? user;
  ActivityPost? post;

  Activity({this.id, this.type, this.createdAt, this.user, this.post});

  Activity.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    type = json['type'];
    createdAt = int.parse(json['created_At']);
    user = json['user'] != null ? ActivityUser.fromJson(json['user']) : null;
    post = json['post'] != null ? ActivityPost.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['created_At'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (post != null) {
      data['post'] = post!.toJson();
    }
    return data;
  }
}

class ActivityUser {
  int? id;
  String? username;

  ActivityUser({this.id, this.username});

  ActivityUser.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    return data;
  }
}

class ActivityPost {
  int? id;
  String? quote;
  int? createdAt;

  ActivityPost({this.id, this.quote, this.createdAt});

  ActivityPost.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    quote = json['quote'];
    createdAt = int.parse(json['created_At']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quote'] = quote;
    data['created_At'] = createdAt;
    return data;
  }
}
