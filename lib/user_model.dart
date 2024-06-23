import 'dart:convert';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? number;
  String? userId;
  String? uid;
  String? createdOn;
  UserModel({
    this.id,
    this.name,
    this.email,
    this.number,
    this.userId,
    this.uid,
    this.createdOn,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? number,
    String? userId,
    String? uid,
    String? createdOn,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      number: number ?? this.number,
      userId: userId ?? this.userId,
      uid: uid ?? this.uid,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'userId': userId,
      'uid': uid,
      'createdOn': createdOn,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      number: map['number'],
      userId: map['userId'],
      uid: map['uid'],
      createdOn: map['createdOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, number: $number, userId: $userId, uid: $uid, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.number == number &&
        other.userId == userId &&
        other.uid == uid &&
        other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        number.hashCode ^
        userId.hashCode ^
        uid.hashCode ^
        createdOn.hashCode;
  }
}
