class Group {
  final String name;
  final String? groupImage;
final String? events;

  Group({
    required this.name,
     this.groupImage,
   this.events,
  });

  factory Group.fromMap(Map<String, dynamic> json) => Group(
        name: json['name'],
        groupImage: json['image'],
      );

  

  Map<String, dynamic> toMap() => {
    'name':name,
    'image': groupImage,
  };
}

class GetGroupModel {
  final Data data;
  final String message;
  final String status;

  GetGroupModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetGroupModel.fromMap(Map<String, dynamic> json) {
    return GetGroupModel(
      data:Data(group: List<Group>.from(json["data"].map((x) => Group.fromMap(x))),),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
     // "data": data.toMap(),
      "message": message,
      "status": status,
    };
  }
}

class Data {
  final List<Group> group;

  Data({required this.group});

  
}
