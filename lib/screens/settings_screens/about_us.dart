
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const  Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Our App!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'WetynDeySup is an Event Management Application allows you to create and manage events, keep track of attendees, and even subscribe to groups.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'With our app, you can:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '- Create and organize events effortlessly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Manage event cards with ease.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Keep track of the number of people attending your events.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              '- Subscribe to groups and stay updated on group events.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Get Started Today',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(
                height: 5,
              ),
            Text(
              "Join the Wetin dey Sup community and experience the future of event management."
                  " Whether you're an event organizer looking for a powerful platform "
                  "or an event enthusiast seeking exciting experiences, we've got you covered.",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            Text(
              "Start creating, managing, and attending events that leave a lasting impression. "
                  "Your journey to unforgettable events management  begins here.",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),



          ],
        ),
      ),
    );
  }
}
