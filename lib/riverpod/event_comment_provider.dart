import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/repositories/event_comment_repository.dart';

import '../classes/event_comment.dart';

final repo = Provider<EventCommentRepository>((ref) => EventCommentRepository());

final getEventCommentsProvider = FutureProvider.autoDispose.family<List<EventComment>, String>((ref, eventid) async{
  Map<String, List> data = await ref.read(repo).getComments();
  return data['data']!.map((e) => EventComment.fromJson(e)).toList();
},);

final postEventCommentProvider = Provider.autoDispose.family<Future<void>, CommentPost>((ref, comment) async{
  return await ref.read(repo).postComment(comment.body, comment.eventid, comment.images);
});

class CommentPost {
  final String body, eventid;
  final List<String> images;
  CommentPost({required this.body, required this.eventid, required this.images});

  List<Object> get props => [eventid, body, images];
}


