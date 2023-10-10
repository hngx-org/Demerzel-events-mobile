// import 'package:hng_events_app/repositories/auth_repository.dart';
// import 'package:hng_events_app/repositories/event_repository.dart';
// import 'package:hng_events_app/services/api_service.dart';
// import 'package:hng_events_app/services/http_service/image_upload_service.dart';
// import 'package:hng_events_app/services/local_storage/shared_preference.dart';

// class DeleteEvent{
//   final EventRepository _eventRepository = EventRepository(
//     authRepository: AuthRepository(
//       localStorageService: LocalStorageService.provider,
//     ),
//     apiService: ApiService.provider,
//     imageUploadService: ImageUploadService.provider,
//   );
//   Future<void> deleteEvent(String eventId) async {
//     await _eventRepository.deleteEvent(eventId);
//   }

// }