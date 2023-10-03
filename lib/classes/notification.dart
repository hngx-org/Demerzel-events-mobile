class UserNotification {
  final String title, content, id;
  final DateTime time;
  bool read;

  UserNotification({required this.title, required this.content, required this.id, required this.time, required this.read});

  UserNotification.custom():
  title = 'Event',
  content = 'Chijindu created an object for notification just today.. Crazy',
  time = DateTime.now(),
  read = false,
  id = '';

  UserNotification.fromJson(Map<String, dynamic> e):
    title = e["notification"]["type"],
    content = e["notification"]["content"],
    id = e["id"],
    read = e["read"] as bool,
    time = DateTime.fromMicrosecondsSinceEpoch(e["notification"]["created_at"]) ;
  
}
