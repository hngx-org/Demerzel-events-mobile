import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';

class CreateEvents extends StatefulWidget {
  const CreateEvents({super.key});

  @override
  State<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends State<CreateEvents> {
  DateTime? startDate = DateTime.now();
  DateTime? endDate = DateTime.now();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? startDate! : endDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime! : endTime!,
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ProjectColors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ProjectColors.black,
          ),
          onPressed: () {
            // Add the action you want when the return icon is pressed.
            // Typically, you'd use Navigator.pop(context) to navigate back.

            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 44.0),
            child: Text(
              'Create Events',
              style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w600,
                color: ProjectColors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: ProjectColors.bgColor,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    const TextField(
                      cursorColor: ProjectColors.black,
                      maxLines: 3,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ProjectColors.white,
                        labelText: 'Event Description',
                        labelStyle: TextStyle(
                          color: ProjectColors.black,
                          fontSize: 15,
                        ),
                        alignLabelWithHint: true,
                        hintText: 'Type Event Description',
                        hintStyle: TextStyle(
                          fontSize: 15,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                        contentPadding: EdgeInsets.only(
                          top: 15,
                          left: 20,
                          right: 20,
                          bottom: 50,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.image,
                        ),
                        onPressed: () {
                          // Add the action you want when the IconButton is pressed.
                        },
                      ),
                    ),
                  ],
                ),
              ), // Add spacing between the text field and other widgets
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1, // Set the thickness of the line
                        color: Colors.black, // Set the color of the line
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Starts',
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110.0),
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 0, // Spread radius
                                  blurRadius: 0, // Blur radius
                                  offset: Offset(
                                      4, 5), // Offset in x and y directions
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                _selectDate(context, true);
                              },
                              child: Text(
                                startDate != null
                                    ? "${startDate!.toLocal()}".split(' ')[0]
                                    : 'Select Date',
                                style: const TextStyle(
                                  color: ProjectColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 0, // Spread radius
                                  blurRadius: 0, // Blur radius
                                  offset: Offset(
                                      4, 5), // Offset in x and y directions
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                _selectTime(context, true);
                              },
                              child: Text(
                                startTime != null
                                    ? "${startTime!.hour}:${startTime!.minute}"
                                    : 'Select Time',
                                style: const TextStyle(
                                  color: ProjectColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1, // Set the thickness of the line
                        color: Colors.black, // Set the color of the line
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Ends',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 120.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                // BoxShadow(
                                //   color: Colors.black, // Shadow color
                                //   spreadRadius: 4, // Spread radius
                                //   blurRadius: 4, // Blur radius
                                //   offset: Offset(
                                //       0, 2), // Offset in x and y directions
                                // ),
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 0, // Spread radius
                                  blurRadius: 0, // Blur radius
                                  offset: Offset(
                                      4, 5), // Offset in x and y directions
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                _selectDate(context, false);
                              },
                              child: Text(
                                endDate != null
                                    ? "${endDate!.toLocal()}".split(' ')[0]
                                    : 'Select Date',
                                style: const TextStyle(
                                  color: ProjectColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 0, // Spread radius
                                  blurRadius: 0, // Blur radius
                                  offset: Offset(
                                    4,
                                    5,
                                  ), // Offset in x and y directions
                                ),
                              ],
                            ),
                            child: TextButton(
                              onPressed: () {
                                _selectTime(context, false);
                              },
                              child: Text(
                                endTime != null
                                    ? "${endTime!.hour}:${endTime!.minute}"
                                    : 'Select Time',
                                style: const TextStyle(
                                  color: ProjectColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Add a Location',
                              style: TextStyle(
                                color: ProjectColors.black,
                                fontSize: 18,
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.group_add,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Create a group',
                              style: TextStyle(
                                color: ProjectColors.black,
                                fontFamily: 'NotoSans',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.group,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Select Groups',
                              style: TextStyle(
                                color: ProjectColors.black,
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 128.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black, // Shadow color
                            spreadRadius: 0, // Spread radius
                            blurRadius: 0, // Blur radius
                            offset:
                                Offset(4, 5), // Offset in x and y directions
                          ),
                        ]),
                    child: TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const CreateEvents(),
                        //   ),
                        // );
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ProjectColors.purple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(
                            width: 2,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Create Event',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ProjectColors.black,
                          fontFamily: 'NotoSans',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Set your desired background color here
        ),
      ),
    );
  }
}
