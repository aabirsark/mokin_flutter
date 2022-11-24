import 'dart:ffi';

class Profile {
  int? id;
  String? username;
  String? name;
  int? createdAt;
  ProfileContactInfo? contactInfo;
  List<ProfileThoughts>? thoughts;

  Profile(
      {this.id,
      this.username,
      this.name,
      this.createdAt,
      this.contactInfo,
      this.thoughts});

  Profile.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    username = json['username'];
    name = json['name'];
    createdAt = int.parse(json['createdAt']);
    contactInfo = json['contactInfo'] != null
        ? ProfileContactInfo.fromJson(json['contactInfo'])
        : null;
    if (json['thoughts'] != null) {
      thoughts = <ProfileThoughts>[];
      json['thoughts'].forEach((v) {
        thoughts!.add(ProfileThoughts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['name'] = name;
    data['createdAt'] = createdAt;
    if (contactInfo != null) {
      data['contactInfo'] = contactInfo!.toJson();
    }
    if (thoughts != null) {
      data['thoughts'] = thoughts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProfileContactInfo {
  int? id;
  String? email;
  String? address;
  String? phone;
  String? bio;

  ProfileContactInfo({this.id, this.email, this.address, this.phone, this.bio});

  ProfileContactInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['bio'] = bio;
    return data;
  }
}

class ProfileThoughts {
  int? id;
  String? quote;
  int? createdAt;

  ProfileThoughts({this.id, this.quote, this.createdAt});

  ProfileThoughts.fromJson(Map<String, dynamic> json) {
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
