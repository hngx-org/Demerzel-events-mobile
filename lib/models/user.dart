import 'package:equatable/equatable.dart';

class AppUser extends Equatable{
  final String id, email, name;
  final String avatar;
 @override

  List<Object> get props => [id];
 
 const  AppUser(
      {required this.id,
      required this.avatar,
      required this.email,
      required this.name});

  AppUser.fromJson(Map<String, dynamic> map)
      : id = map["data"]["id"],
        avatar = map["data"]["avatar"],
        email = map["data"]["email"],
        name = map["data"]["name"];

  AppUser.custom()
      : id = '',
        avatar = '',
        email = 'abdulramanyusuf125@gmail.com',
        name = 'Abraham Yusuf';
}

class Member extends AppUser  {
  Member({
    required String id,
    required String avatar,
    required String email,
    required String name,
  }) : super(
          id: id,
          avatar: avatar,
          email: email,
          name: name,
        );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  // List<Object> get props => [id];
  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      avatar: json['avatar'],
      email: json['email'],
      name: json['name'],
    );
  }
}