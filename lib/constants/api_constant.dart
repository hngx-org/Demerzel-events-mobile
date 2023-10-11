class ApiRoutes {
  static const baseUrl =  "https://ev-l4gd.onrender.com/api";
  // static const baseUrl = "https://api-s65g.onrender.com/api";
   //static const baseUrl = "https://hng.jameesjohn.com/api";

  static const String scheme = 'https';
    static const String host = "ev-l4gd.onrender.com";
  // static const String host = 'api-s65g.onrender.com';
  //static const String host = 'hng.jameesjohn.com';

  static const int receiveTimeout = 10000;
  static const int sendTimeout = 5000;

  static Uri baseUri = Uri(scheme: scheme, host: host, path: '/');
 static final userURI = Uri.parse('$baseUrl/users');
  static final authGoogleURI = Uri.parse('$baseUrl/auth/verify');
  static final groupURI = Uri.parse('$baseUrl/groups');
  static final eventURI = baseUri.replace(path: '/api/events');
  static final currentUserURI = baseUri.replace(path: '/api/users/current');
  static final notificationURI = baseUri.replace(path: '/api/notifications');
   static final notificationPrefsURI = baseUri.replace(path: '/api/notifications/settings');
  static eventURII(String limit, String page) =>
      baseUri.replace(path: '/api/events?limit=$limit&page=$page');
  static final upcomingEventURI = baseUri.replace(path: '/api/events/upcoming');
  static final userEventURI = baseUri.replace(path: '/api/events/subscriptions');
  static subscribeToEventURI(String eventId) =>
      baseUri.replace(path: '/api/events/$eventId/subscribe');
  static subscribeToGroupURI(String groupId) =>
      baseUri.replace(path: '/api/groups/$groupId/subscribe');
  static unSubscribeFromGroupURI(String groupId) =>
      baseUri.replace(path: '/api/groups/$groupId/unsubscribe');
  static final commentURI = Uri.parse('$baseUrl/comments');
  static final imageUploadURI = Uri.parse('$baseUrl/images/upload');
  static eventByDateURI(String date) => baseUri.replace(path: '/api/events?start_date=$date');
  static groupEventURI(String id) => Uri.parse('$baseUrl/events/group/$id');
  static eventCommentURI(String id) =>
      Uri.parse('$baseUrl/events/comments/$id');
  static deleteEventURI(String id)=> Uri.parse("$baseUrl/events/$id");
}
