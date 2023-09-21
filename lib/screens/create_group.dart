import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            'Create Group',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          )),
      // bottomNavigationBar:Container(
      //   decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(20.0),
      //       bottomRight: Radius.circular(20.0),
      //     ),
      //   ),
      //   child: BottomNavigationBar(
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.timeline),
      //         label: 'Timeline',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.people_outline),
      //         label: 'My People',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.calendar_month_outlined),
      //         label: 'Calendar',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.settings),
      //         label: 'Settings',
      //       ),
      //     ],
      //     selectedItemColor: const Color(0xffE78DFB),
      //     unselectedItemColor: Colors.grey,
      //     selectedLabelStyle: const TextStyle(
      //       fontWeight: FontWeight.bold,
      //       fontSize: 14,
      //     ),
      //     unselectedLabelStyle: const TextStyle(
      //       fontWeight: FontWeight.normal, // Custom style for unselected labels
      //       fontSize: 12,
      //     ),
      //     showSelectedLabels: true, // Show labels for selected items
      //     showUnselectedLabels: true, // Show labels for unselected items
      //   ),
      // )
      // ,
      backgroundColor: const Color(0xffFFF8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Group Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ProjectColors.white,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  hintText: 'Group Name goes here',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Color(0xff84838B), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Group Image',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ProjectColors.white,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  hintText: 'Select Image',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Color(0xff84838B), width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  suffixIcon: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.photo,
                      color: ProjectColors.black,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black, // Shadow color
                        spreadRadius: 0, // Spread radius
                        blurRadius: 0, // Blur radius
                        offset: Offset(4, 5), // Offset in x and y directions
                      ),
                    ],
                    borderRadius: BorderRadius.circular(8.0),
                    color: const Color(0xffE78DFB),
                    border: Border.all(width: 2),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Center(
                      child: Text(
                        'Create Group',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}