import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';

import '../repositories/event_repository.dart';




class EventController extends ChangeNotifier {
  final EventRepository eventRepository;
  EventController({required this.eventRepository}){
    getAllEvent();
  }

  GetListEventModel? events;
  GetListEventModel? allEvents;

  static final provider = ChangeNotifierProvider<EventController>((ref) {
    return EventController(eventRepository: ref.read(EventRepository.provider));
  });

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String _error = "";
  String get error => _error;

  Future<void> getAllEvent() async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getAllEvent();
      allEvents = result;
      notifyListeners();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<void> getEventByDate(String date) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      final result = await eventRepository.getEventsByDate(date);

      events = result;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<bool> createEvent(Map<String, dynamic> body) async {
    _isBusy = true;
    _error = "";
    notifyListeners();

    try {
      await eventRepository.createEvent(body);
      await getAllEvent();
    } catch (e, s) {
      log(e.toString());
      log(s.toString());

      _error = e.toString();
      notifyListeners();
      return false;
    }

    _isBusy = false;
    notifyListeners();
    return true;
  }
}
