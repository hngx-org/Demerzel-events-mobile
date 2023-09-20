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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // Add the action you want when the return icon is pressed.
            // Typically, you'd use Navigator.pop(context) to navigate back.
          },
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 44.0),
            child: Text('Create Events',
              style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontWeight: FontWeight.bold
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
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Event Description',
                    hintText: 'Type Event Description',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(32.0),
                    prefixIcon: Column(
                        mainAxisSize: MainAxisSize.min, // Ensure the icon is aligned at the bottom
                        children: [
                        SizedBox(height: 8.0), // Adjust the height between label and icon
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        // Add the action you want when the IconButton is pressed.
                      },
                    ),
                        ],
                    ),
                  ),
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
                          child: Text('Starts',
                            style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 110.0),
                          child: Container(
                            height: 30,
                            width: 95,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius:BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 4, // Spread radius
                                  blurRadius: 4, // Blur radius
                                  offset: Offset(0, 2), // Offset in x and y directions
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
                                  color: ProjectColors. black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
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
                          child: Text('Ends',
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
                            height: 30,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black, // Shadow color
                                  spreadRadius: 4, // Spread radius
                                  blurRadius: 4, // Blur radius
                                  offset: Offset(0, 2), // Offset in x and y directions
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
                            height: 30,
                            decoration: BoxDecoration(
                              color: ProjectColors.purple,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 4,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
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
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Text('Add a Location',
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
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.group_add,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Create a group',
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
                      padding: EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.group,
                            color: ProjectColors.purple,
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Text('Select Groups',
                              style: TextStyle(
                                color:ProjectColors.black,
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
              Container(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.only(top: 128.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreateEvents()),
                      );
                    },
                    child:  Text('Create Event',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ProjectColors.black,
                      fontFamily: 'NotoSans',
                      fontSize: 20,
                    ),
                    ),
                    style:  ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ProjectColors.purple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(10.0),
                      shadowColor: MaterialStateProperty.all(ProjectColors.black),
                      overlayColor: MaterialStateProperty.all(ProjectColors.black),
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
