// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/models/group_tag_model.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
  MultiSelectController dropDownCtrl = MultiSelectController();
  @override
  Widget build(BuildContext context) {
    final groupsNotifier = ref.watch(GroupProvider.groupProvider);
    final tags = ref.watch(groupTagProvider);
    // ref.refresh(groupTagProvider);

    Size screensize = MediaQuery.of(context).size;
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
          // centerTitle: true,
          title: const Text(
            'Create Group',
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Group Name',
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: groupNameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.background,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
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
                  decoration: ProjectConstants.appBoxDecoration.copyWith(
                      color: Theme.of(context).colorScheme.background,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.onBackground)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(imagePath.split('/').last),
                        SvgPicture.asset(
                          ProjectConstants.imagePicker,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: tagDropDown(tags, context),
              ),
              const SizedBox.square(
                dimension: 12,
              ),
              GestureDetector(
                onTap: () async {
                  if (groupNameController.text.isNotEmpty &&
                      dropDownCtrl.selectedOptions.isNotEmpty) {
                    await createGroup(groupsNotifier, ref);

                    log('refrshed');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please fill required fields'),
                    ));

                    return;
                  }
                },
                child: SizedBox(
                  height: 150,
                  width: screensize.width,
                  child: Center(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black, // Shadow color
                            spreadRadius: 0, // Spread radius
                            blurRadius: 0, // Blur radius
                            offset:
                                Offset(4, 5), // Offset in x and y directions
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xffE78DFB),
                        border: Border.all(width: 2),
                      ),
                      child: Center(
                        child: isLoading
                            ? const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Creating group',
                                      // style: TextStyle(fontSize: 18),
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
                                  // fontSize: 17,
                                  // fontWeight: FontWeight.w700,
                                  color: Colors.black, // Text color
                                ),
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

  MultiSelectDropDown tagDropDown(
      AsyncValue<List<GroupTagModel>> tags, BuildContext context) {
    return MultiSelectDropDown(
      controller: dropDownCtrl,
      onOptionSelected: (List<ValueItem> selectedOptions) {},
      maxItems: 5,
      suffixIcon: tags.when(
        data: (data) => const Icon(Icons.arrow_drop_down),
        error: (error, stackTrace) => const Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
        loading: () => const Icon(
          Icons.circle,
          color: Colors.grey,
        ),
      ),
      options: tags.when(
          data: (data) => List.generate(
              data.length,
              (index) => ValueItem(
                  label:
                      "#${data.map((e) => e.name.toLowerCase().replaceAll(RegExp(' '), '')).toList()[index]}",
                  value: data.map((e) => e.id.toString()).toList()[index])),
          error: (error, stackTrace) => <ValueItem>[],
          loading: () => <ValueItem>[]),
      // controller: ,
      inputDecoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Theme.of(context).textTheme.bodyMedium!.color!)),
      hint: 'Add #tags',
      optionsBackgroundColor: Theme.of(context).cardColor,
      optionTextStyle:
          TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(wrapType: WrapType.wrap),
      dropdownHeight: 300,
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }

  Future<void> createGroup(GroupProvider groupController, WidgetRef ref) async {
    isLoading = true;
    setState(() {});

    final body = {
      "image": image,
      "name": groupNameController.text,
      "tags":
          dropDownCtrl.selectedOptions.map((e) => int.parse(e.value!)).toList()
    };

    final result = await groupController.createGroup(body);
    // await Future.delayed(const Duration(seconds: 5));
    setState(() {
      isLoading = false;
    });

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Group create successful!",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
      ref.refresh(groupsProvider);
      await groupController.getGroups();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            groupController.error,
            style: const TextStyle(color: Colors.white),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
