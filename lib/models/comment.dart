import 'package:hng_events_app/models/event_model.dart';

class Comment {
  final String id;
  final String body;
  final String eventId;
  final List<String> images;
  final Creator creator;

  Comment({
    required this.id,
    required this.body,
    required this.eventId,
    required this.images,
    required this.creator,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['images'] != null) {
      images = List<String>.from(json['images'].map((image) => image));
    }

    return Comment(
      id: json['id'],
      body: json['body'],
      eventId: json['event_id'],
      images: images,
      creator: Creator.fromMap(json['creator']),
    );
  }
}

class FirstComments {
  final String id;
  final String name;
  final String avatar;

  FirstComments({required this.id, required this.name, required this.avatar});

  factory FirstComments.fromJson(Map<String, dynamic> json) {
    return FirstComments(
        id: json['id'], name: json['name'], avatar: json['avatar']);
  }
}
