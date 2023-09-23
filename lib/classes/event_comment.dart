class EventComment {
  final String comment;

  EventComment({required this.comment});
  
  EventComment.fromJson(Map<String, dynamic> data):
  comment = data["comment"];
}