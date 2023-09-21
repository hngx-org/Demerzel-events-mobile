import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        border: Border.all(
          color: ProjectColors.black,
          width: 2,
        ),
        color: ProjectColors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
        ],
      ),
      child: Column(
        children: [
          //football game listile
          ListTile(
            leading: const CircleAvatar(
              backgroundImage:
                  AssetImage("assets/illustrations/smiley_face.png"),
              radius: 15,
            ),
            title: const Text(
              'Football game',
              style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 24),
            ),
            trailing: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: ProjectColors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: ProjectColors.black),
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
                ],
              ),
              child: const Center(
                child: Text(
                  "May 20",
                  style: TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          //location
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(children: [
              Image.asset('assets/icons/location.png', width: 20),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Teslim Balogun Stadium',
                style: TextStyle(
                    fontFamily: 'inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              )
            ]),
          ),
          const SizedBox(
            height: 5,
          ),
          //time
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(children: [
              Image.asset(
                'assets/icons/clock.png',
                width: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'Friday 4 -7 PM',
                style: TextStyle(
                  fontFamily: 'inter',
                  fontWeight: FontWeight.w600,
                ),
              )
            ]),
          ),
          const SizedBox(
            height: 8,
          ),
          //button widget
          const Button(),
          const SizedBox(
            height: 16,
          ),
          const Divider(height: 0, thickness: 2, color: ProjectColors.grey),

          //inpuField widget
          const InputField()
        ],
      ),
    );
  }
}

//button widget add gesture detector to add functionality
class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: ProjectColors.white,
          border: Border.all(
            color: ProjectColors.black,
            width: 2,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(color: ProjectColors.black, offset: Offset(2, 2))
          ],
        ),
        child: const Center(
          child: Text(
            'I will join',
            style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w700,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}

//inutfield widget
class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListTile(
          leading: Image.asset('assets/icons/comment.png', width: 20),
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: const TextField(
              decoration: InputDecoration(
                  hintText: 'Leave a comment', border: InputBorder.none),
            ),
          ),
          trailing: const Icon(Icons.chevron_right)),
    );
  }
}
