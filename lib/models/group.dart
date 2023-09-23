import 'package:hng_events_app/classes/user.dart';
import 'package:hng_events_app/models/event_model.dart';

class Group {
  String id;
  String name;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  List<User>? members; // You can change the type of members as needed
  List<Event> events;

  Group({
    required this.id,
    required this.name,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    this.members,
    this.events = const [],
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    List<User>? members;
    List<Event> events = [];
    if (json['members'] != null) {
      members = List<User>.from(
          json['members'].map((member) => User.fromJson(member)));
    }

    if (json['events'] != null) {
      events =
          List<Event>.from(json['events'].map((event) => Event.fromMap(event)));
    }
    return Group(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      members: members,
      events: events,
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
          List<Group>.from(json['data'].map((group) => Group.fromJson(group)));
    }

    return GroupListModel(
      groups: groups,
      message: json['message'],
      status: json['status'],
    );
  }
}
