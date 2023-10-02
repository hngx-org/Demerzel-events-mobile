import 'package:hng_events_app/classes/user.dart';
import 'package:hng_events_app/models/event_model.dart';

class Group {
  String id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  int membersCount;
  int eventCount;


  Group({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.membersCount,
    required this.eventCount,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
   
    // if (json['members'] != null) {
    //   members = List<User>.from(
    //       json['members'].map((member) => User.fromJson(member)));
    // }

    // if (json['events'] != null) {
    //   events = List<Event>.from(
    //       json['events'].map((event) => Event.fromMap(event)));
    // }
    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      membersCount: json['members_count'],
      eventCount: json['events_count'],
      
    );
  }
}

class GroupListModel {
  List<Group> groups;
  String message;
  String status;

  GroupListModel({
    required this.groups,
    required this.message,
    required this.status,
  });

  factory GroupListModel.fromJson(Map<String, dynamic> json) {
    List<Group> groups = [];
    if (json['data'] != null) {
      groups =
          List<Group>.from(json['data']['groups'].map((group) => Group.fromJson(group)));
    }

    return GroupListModel(
      groups: groups,
      message: json['message'],
      status: json['status'],
    );
  }
}

class GroupEventListModel {
  final Data data;
  final String message;
  final String status;

  GroupEventListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GroupEventListModel.fromMap(Map<String, dynamic> json) {
    return GroupEventListModel(
      data: Data.fromMap(json["data"]["group"]),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "data": data.toMap(),
      "message": message,
      "status": status,
    };
  }
}

class Data {
  final List<Event> events;

  Data({required this.events});

  factory Data.fromMap(Map<String, dynamic> json) {
   if ( json.containsKey('events')) {
      return Data(
      events: List<Event>.from(json["events"].map((x) => Event.fromMap(x))),
    );
   }

   return Data(events: []);
  }



  Map<String, dynamic> toMap() {
    return {"events": List<dynamic>.from(events.map((x) => x.toMap()))};
  }
}
