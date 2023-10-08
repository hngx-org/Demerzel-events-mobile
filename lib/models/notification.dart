class UserNotification {
  final String title, content, id;
  final String time;
  bool read;

  UserNotification({required this.title, required this.content, required this.id, required this.time, required this.read});

  UserNotification.custom():
  title = 'Event',
  content = 'Chijindu created an object for notification just today.. Crazy',
  time = 'mon',
  read = false,
  id = '';

  UserNotification.fromJson(Map<String, dynamic> e):
    title = e["notification"]["type"],
    content = e["notification"]["content"],
    id = e["id"],
    read = e["read"] as bool,
    time = getDay(
      DateTime.parse(e["notification"]["created_at"]).weekday
      // DateTime.fromMicrosecondsSinceEpoch(
      //   e["notification"]["created_at"]
      //   ).weekday
      );
  
}

String getDay(int dayint){
  switch (dayint) {
    case 1: return 'Mon';
    case 2: return 'Tues';
    case 3: return 'Wed';
    case 4: return 'Thurs';
    case 5: return 'Fri';
    case 6: return 'Sat';
    case 7: return 'Sun';
    
    default: return 'Mon';
  }
}
