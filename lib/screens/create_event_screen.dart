import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:svg_flutter/svg_flutter.dart';

class CreateEvents extends ConsumerStatefulWidget {
  const CreateEvents({super.key});

  @override
  ConsumerState<CreateEvents> createState() => _CreateEventsState();
}

class _CreateEventsState extends ConsumerState<CreateEvents> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? groupName;
  bool isLoading = false;

  String imagePath = '';
  File? image;

  Group? selectedGroup;

  bool isFormValid() =>
      titleController.text.isNotEmpty &&
      bodyController.text.isNotEmpty &&
      locationController.text.isNotEmpty &&
      selectedGroup != null &&
      startDate != null &&
      startTime != null &&
      endDate != null &&
      endTime != null;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStart ? startDate ?? DateTime.now() : endDate ?? DateTime.now(),
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
      initialTime:
          isStart ? startTime ?? TimeOfDay.now() : endTime ?? TimeOfDay.now(),
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

  _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        imagePath = File(pickedFile.path).path;
        imagePath.split('/').last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //ref.watch(GroupProvider.groupProvider);

    final eventNotifier = ref.watch(EventProvider.provider);
    final groupsNotifier = ref.watch(GroupProvider.groupProvider);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ProjectColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ProjectColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 44.0),
            child: Text(
              'Create Events',
              style: TextStyle(
                fontFamily: 'NotoSans',
                fontWeight: FontWeight.w600,
                // color: ProjectColors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: titleController,
                cursorColor: ProjectColors.black,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  filled: true,
                  // fillColor: ProjectColors.white,
                  labelText: 'Event Title',
                  labelStyle:
                      TextStyle(
                        // color: ProjectColors.black, 
                        fontSize: 15),
                  alignLabelWithHint: true,
                  hintText: 'Type Event Title',
                  hintStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: locationController,
                cursorColor: ProjectColors.black,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  filled: true,
                  // fillColor: ProjectColors.white,
                  labelText: 'Add a Location',
                  labelStyle:
                      TextStyle(
                        // color: ProjectColors.black, 
                        fontSize: 15),
                  alignLabelWithHint: true,
                  hintText: 'Type The Location of the Event',
                  hintStyle: TextStyle(fontSize: 15),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide()),
                ),
                onChanged: (value) => setState(() {}),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  TextField(
                    controller: bodyController,
                    cursorColor: ProjectColors.black,
                    maxLines: 3,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      filled: true,
                      // fillColor: ProjectColors.white,
                      labelText: 'Event Description',
                      labelStyle: TextStyle(
                        // color: ProjectColors.black,
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
                    onChanged: (value) => setState(() {}),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Container(
                  height: 50,
                  decoration: ProjectConstants.appBoxDecoration
                      .copyWith(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(imagePath.split('/').last.isEmpty
                            ? 'Add a Image'
                            : imagePath.split('/').last),
                        SvgPicture.asset(ProjectConstants.imagePicker),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 1, color: Colors.black),
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
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: ProjectColors.purple,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(4, 5),
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
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(4, 5),
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
                      thickness: 1,
                      color: Colors.black,
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
                        padding: const EdgeInsets.only(left: 80.0),
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: ProjectColors.purple,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(4, 5),
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
                                color: Colors.black,
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(
                                  4,
                                  5,
                                ),
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
                          Icons.group,
                          color: ProjectColors.purple,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DropdownButton<Group>(
                              value: selectedGroup,

                              onChanged: (newValue) {
                                setState(() {
                                  selectedGroup = newValue;
                                });
                              },
                              items: groupsNotifier.groups.map((group) {
                                return DropdownMenuItem(
                                  value: group,
                                  child: Text(
                                    group.name,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                );
                              }).toList(),
                              hint: const Text(
                                'Select a Group',
                                style: TextStyle(
                                  // color: Colors.black,
                                  fontSize: 15,
                                ),
                              ), // Optional hint text
                              isExpanded:
                                  true, // Makes the dropdown button expand to the available width
                              underline: Container(
                                height:
                                    1, // Add an underline with custom styling
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: Offset(4, 5),
                            ),
                          ],
                        ),
                        child: TextButton(
                          onPressed: () => uploadEvent(eventNotifier),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              isFormValid()
                                  ? ProjectColors.purple
                                  : ProjectColors.purple.withOpacity(0.6),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> uploadEvent(EventProvider eventController) async {
    if (isFormValid() == false) return;

    try {
      isLoading = true;
      setState(() {});

      final body = {
        "image": image,
        "location": locationController.text,
        "title": titleController.text,
        "description": bodyController.text,
        "start_date": DateFormat("yyyy-MM-dd").format(startDate!),
        "end_date": DateFormat("yyyy-MM-dd").format(endDate!),
        "start_time":
            "${startTime!.hour.toString().padLeft(2, '0')}:${startTime!.minute.toString().padLeft(2, '0')}",
        "end_time":
            "${endTime!.hour.toString().padLeft(2, '0')}:${endTime!.minute.toString().padLeft(2, '0')}",
        "group_id": [selectedGroup!.id],
      };

      final result = await eventController.createEvent(body);
      await Future.delayed(const Duration(seconds: 5));
      isLoading = false;

      if (result) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Event Uploaded Successfully",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        await eventController.getAllEvent();
        eventController.getUserEvent();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Event Upload Failed",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e, s) {
      isLoading = false;
      log(e.toString());
      log(s.toString());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
