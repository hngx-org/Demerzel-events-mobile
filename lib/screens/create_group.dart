import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';

class CreateGroup extends ConsumerStatefulWidget {
  const CreateGroup({super.key});

  @override
  ConsumerState<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<CreateGroup> {
  bool pressed = false;
  bool isLoading = false;
  String imagePath = '';
  File? image;

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

  TextEditingController groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final groupsNotifier = ref.watch(GroupProvider.groupProvider);
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
              
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text(
            'Create Group',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, ),
          )),
      //backgroundColor: const Color(0xffFFF8F5),
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
                controller: groupNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:Theme.of(context).colorScheme.background,
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
              InkWell(
                onTap: () {
                  _getFromGallery();
                },
                child: Container(
                  height: 50,
                  decoration: ProjectConstants.appBoxDecoration
                      .copyWith(color: Theme.of(context).colorScheme.background, border: Border.all(color: Theme.of(context).colorScheme.onBackground)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(imagePath.split('/').last),
                        SvgPicture.asset(ProjectConstants.imagePicker, color: Theme.of(context).colorScheme.onBackground,),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (groupNameController.text.isNotEmpty) {
                    // final result = await ref
                    //     .read(groupProvider)
                    //     .createGroup(groupNameController.text, image!);

                    await createGroup(groupsNotifier);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Group name can not be empty'),
                    ));

                    return;
                  }
                },
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Center(
                      child: isLoading
                          ? const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Creating group',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            )
                          : const Text(
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

  Future<void> createGroup(GroupProvider groupController) async {
    // if (isFormValid() == false) return;

    try {
      isLoading = true;
      setState(() {});

      final body = {
        "image": image,
        "name": groupNameController.text,
      };

      final result = await groupController.createGroup(body);
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        isLoading = false;
      });

      if (result) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Group created",
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        await groupController.getGroups();
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Group could not be created",
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
