class ApiRoutes {
  static const baseUrl = "https://api-s65g.onrender.com/api";

  static final authGoogleURI = Uri.parse('$baseUrl/auth/verify');
  static final groupURI = Uri.parse('$baseUrl/groups');
  static final eventURI = Uri.parse('$baseUrl/events');
  static eventByDateURI(String date) => Uri.parse('$baseUrl/events?date=$date');
}
