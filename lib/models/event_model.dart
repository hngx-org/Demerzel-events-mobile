import 'package:equatable/equatable.dart';
import 'package:hng_events_app/models/comment.dart';

class GetListEventModel {
  final Data data;
  final String message;
  final String status;

  GetListEventModel({
    required this.data,
    required this.message,
    required this.status,
  });

  factory GetListEventModel.fromMap(Map<String, dynamic> json) {
    return GetListEventModel(
      data: Data.fromMap(json["data"]),
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
    return Data(
      events: List<Event>.from(json["events"].map((x) => Event.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() {
    return {"events": List<dynamic>.from(events.map((x) => x.toMap()))};
  }
}

class Event extends Equatable {
  final String id;
  final String creatorId;
  final String thumbnail; 
  final String location ;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String createdAt;
  final String updatedAt;
  final Creator? creator;
  final List<FirstComments>? firstComments;

  @override
  List<Object> get props => [id];

  const Event({
    required this.id,
    required this.creatorId,
    required this.thumbnail,
    required this.location,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    this.creator,
    this.firstComments,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
      id: json["id"],
      creatorId: json["creator_id"],
      thumbnail: json["thumbnail"],
      location: json["location"],
      title: json["title"],
      description: json["description"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      creator:
          json["creator"] == null ? null : Creator.fromMap(json["creator"]),
      firstComments: json.containsKey('comments')
          ? List.from(json['comments']
              .map((x) => FirstComments.fromJson(x)))
          : [],
     
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "creator_id": creatorId,
        "thumbnail": thumbnail,
        "location": location,
        "title": title,
        "description": description,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
        "end_time": endTime,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "creator": creator?.toMap(),
      };
}

class Creator {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final dynamic events;
  final dynamic interestedEvents;
  final dynamic userGroup;

  Creator({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.events,
    required this.interestedEvents,
    required this.userGroup,
  });

  factory Creator.fromMap(Map<String, dynamic> json) => Creator(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        avatar: json["avatar"] ?? '',
        events: json["Events"] ?? '',
        interestedEvents: json["InterestedEvents"] ?? '',
        userGroup: json["user_group"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "Events": events,
        "InterestedEvents": interestedEvents,
        "user_group": userGroup,
      };
}
