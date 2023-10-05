import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/comment.dart';
import 'package:hng_events_app/repositories/comment_repository.dart';

class CommentProvider extends ChangeNotifier {
  final CommentRepository commentRepository;

  CommentProvider({required this.commentRepository});

  String _error = "";
  String get error => _error;

  bool _isBusy = false;
  bool _isAddingComments = false;
  bool get isBusy => _isBusy;
  bool get isAddingComments => _isAddingComments;

  List<Comment> comments = [];

  Future<bool> createComment(String body, String eventId, File? image) async {
    _isAddingComments = true;
    _error = "";
    notifyListeners();
    await commentRepository
        .createComment(body: body, eventId: eventId, image: image);
    comments= await commentRepository.getEventComments(eventId);
    _isAddingComments = false;
    notifyListeners();
    return true;
  }

  void setIsBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Future<void> getEventComments(String eventId) async {
    _isBusy = true;
    _error = "";
    notifyListeners();
    final result = await commentRepository.getEventComments(eventId);
    comments = result;
    notifyListeners();
    _isBusy = false;
    notifyListeners();
  }

  static final provider = ChangeNotifierProvider<CommentProvider>((ref) =>
      CommentProvider(commentRepository: ref.read(CommentRepository.provider)));
}
