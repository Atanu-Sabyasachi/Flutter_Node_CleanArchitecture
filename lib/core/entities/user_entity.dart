import 'dart:convert';

class UserEntity {
  String? name;
  String? email;
  String? number;
  String? userId;
  String? uid;
  String? createdOn;
  UserEntity({
    this.name,
    this.email,
    this.number,
    this.userId,
    this.uid,
    this.createdOn,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? number,
    String? userId,
    String? uid,
    String? createdOn,
  }) {
    return UserEntity(
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
      'name': name,
      'email': email,
      'number': number,
      'userId': userId,
      'uid': uid,
      'createdOn': createdOn,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['name'],
      email: map['email'],
      number: map['number'],
      userId: map['userId'],
      uid: map['uid'],
      createdOn: map['createdOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserEntity(name: $name, email: $email, number: $number, userId: $userId, uid: $uid, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.name == name &&
        other.email == email &&
        other.number == number &&
        other.userId == userId &&
        other.uid == uid &&
        other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        number.hashCode ^
        userId.hashCode ^
        uid.hashCode ^
        createdOn.hashCode;
  }
}
