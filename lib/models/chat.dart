class Comment {
  final String text;
  final String? attachemt;

  Comment({required this.text, this.attachemt});
  
  //TODO: Refactor to use keys from payload
  factory Comment.fromJson(Map<String, dynamic> data){
    final text = data['text'];
    final attachment = data['attachment'];
    return Comment(text: text, attachemt: attachment);
  }
}