class ApiRoutes {
  //  static const baseUrl = "https://api-s65g.onrender.com/api";
    static const baseUrl = "https://hng.jameesjohn.com/api";

  static const String scheme = 'https';
  // static const String host = 'api-s65g.onrender.com';
   static const String host = 'hng.jameesjohn.com';

  static const int receiveTimeout = 10000;
  static const int sendTimeout = 5000;

  static Uri baseUri = Uri(scheme: scheme, host: host, path: '/');

  static final authGoogleURI = Uri.parse('$baseUrl/auth/verify');
  static final groupURI = Uri.parse('$baseUrl/groups');
  static final eventURI = baseUri.replace(path: '/api/events');
  static final userEventURI = baseUri.replace(path: '/api/events/subscriptions');
  static subscribeToEventURI(String eventId) =>
      baseUri.replace(path: '/api/events/$eventId/subscribe');

  static final commentURI = Uri.parse('$baseUrl/comments');
  static final imageUploadURI = Uri.parse('$baseUrl/images/upload');
  static eventByDateURI(String date) => baseUri.replace(path: '/api/events?start_date=$date');
  static groupEventURI(String id) => Uri.parse('$baseUrl/events/group/$id');
  static eventCommentURI(String id) =>
      Uri.parse('$baseUrl/events/comments/$id');
}
