import 'package:equatable/equatable.dart';
import 'package:hng_events_app/models/user.dart';
import 'package:hng_events_app/models/event_model.dart';

class Group extends Equatable {
  final String id;
  final String name;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int membersCount;
  final int eventCount;

  const Group({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.membersCount,
    required this.eventCount,
  });
 @override
  List<Object> get props => [id];

  factory Group.fromJson(Map<String, dynamic> json) {
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
      groups = List<Group>.from(
          json['data']['groups'].map((group) => Group.fromJson(group)));
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
  final List<Member>? members;

  Data({
    required this.events,
    this.members,
  });

  factory Data.fromMap(Map<String, dynamic> json) {
    List<Event> eventsList = [];
    List<Member> membersList = [];
    // List firstComments = [];

    if (json['events'] != null) {
      eventsList =
          List<Event>.from(json['events'].map((x) => Event.fromMap(x)));
    }

    if (json['members'] != null) {
      membersList = List<Member>.from(
          json['members'].map((x) => Member.fromJson(x['user'])));
    }

    return Data(
      events: eventsList,
      members: membersList,
    );
  }


  Map<String, dynamic> toMap() {
    return {"events": List<dynamic>.from(events.map((x) => x.toMap()))};
  }

}
