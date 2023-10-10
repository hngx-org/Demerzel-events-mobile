import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as googleAuth
    show AuthClient;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

class CalendarClient {
  //static const _scopes = [CalendarApi.calendarScope];

  insert(context, title, startDate, startTime, endTime, endDate) async {


    googleAuth.AuthClient? client = await googleSignIn.authenticatedClient();
    var calendar = CalendarApi(client!);

    DateTime combinedStartDateTime(DateTime date, TimeOfDay time) => DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
    String calendarId = "primary";
    Event event = Event();

    event.summary = title;

    EventDateTime start = EventDateTime();
    start.dateTime = combinedStartDateTime(startDate, startTime);
    //start.timeZone = "GMT+05:00";

    event.start = start;

    //DateTime endDateTime = DateTime.parse("$endDate $endTime");
    EventDateTime end = EventDateTime();
    //end.timeZone = "GMT+05:00";
    end.dateTime = combinedStartDateTime(endDate, endTime);

    event.end = end;

    try {
      calendar.events.insert(event, calendarId).then((value) {
        print("ADDEDDD_________________${value.status}");
        if (value.status == "confirmed") {
          // Dialogs().displayToast(
          //     context, "Event added in google calendar", 0);
          log('Event added in google calendar');
        } else {
          log("Unable to add event in google calendar");
          // Dialogs().displayToast(
          //     context, "Unable to add event in google calendar", 0);
        }
      });
    } catch (e) {
      log('Error creating event $e');
      // Dialogs().displayToast(context, e, 0);
    } // function to insert event
    // incase of any confusion i will recommed to go to implementation of calendar/v3.dart
    // and read comments of their codez
  }

  void prompt(String url) async {
    print("Please go to the following URL and grant access:");
    print("  => $url");
    print("");
    await launch(url);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // insert(title, startTime, endTime) {
  //   var _clientID = new ClientId("425241698743-a2ajas2uscn7fpv91v5ib5rmke9phtio.apps.googleusercontent.com", "");
  //   clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
  //     var calendar = CalendarApi(client);
  //     calendar.calendarList.list().then((value) => print("VAL________$value"));

  //     String calendarId = "primary";
  //     Event event = Event(); // Create object of event

  //     event.summary = title;

  //     EventDateTime start =  EventDateTime();
  //     start.dateTime = startTime;
  //     start.timeZone = "GMT+05:00";
  //     event.start = start;

  //     EventDateTime end =  EventDateTime();
  //     end.timeZone = "GMT+05:00";
  //     end.dateTime = endTime;
  //     event.end = end;
  //     try {
  //       calendar.events.insert(event, calendarId).then((value) {
  //         print("ADDEDDD_________________${value.status}");
  //         if (value.status == "confirmed") {
  //           log('Event added in google calendar');
  //         } else {
  //           log("Unable to add event in google calendar");
  //         }
  //       });
  //     } catch (e) {
  //       log('Error creating event $e');
  //     }
  //   });
  // }

  // void prompt(String url) async {
  //   print("Please go to the following URL and grant access:");
  //   print("  => $url");
  //   print("");

  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
