class User {
  final String id, avatar, email, name;

  User(
      {required this.id,
      required this.avatar,
      required this.email,
      required this.name});

  User.fromJson(Map<String, dynamic> map)
      : id = map["data"]["id"],
        avatar = map["data"]["avatar"],
        email = map["data"]["email"],
        name = map["data"]["name"];

  User.custom()
      : id = '',
        avatar = '',
        email = 'abdulramanyusuf125@gmail.com',
        name = 'Abraham Yusuf';
}

class Member extends User {
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

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      avatar: json['avatar'],
      email: json['email'],
      name: json['name'],
    );
  }
}