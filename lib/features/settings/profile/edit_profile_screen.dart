import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.email,
      required this.ref});
  final String name;
  final String email;
  final String image;
  final WidgetRef ref;

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        // isPhotoSet = true;
        imageFile = File(pickedFile.path);
      });
    }
  }

  bool isLoading = false;
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  File? imageFile;
  // AuthRepository repo = AuthRepository(localStorageService: const LocalStorageService());
  @override
  void initState() {
    namectrl.text = widget.name;
    emailctrl.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox.square(
              dimension: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 222, 140, 236),
                    backgroundImage: (imageFile == null)
                        ? NetworkImage(widget.image)
                        : FileImage(imageFile!) as ImageProvider,
                    radius: 100,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                        onPressed: () async {
                          await getFromGallery();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screensize.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    // heightFactor: 0.8,
                    width: screensize.width * 0.8,
                    child: TextField(
                      controller: namectrl,
                      decoration: const InputDecoration(
                          labelText: 'Name',
                          suffixIcon: Icon(
                            Icons.edit,
                            color: ProjectColors.purple,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screensize.width,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: screensize.width * 0.8,
                    child: TextField(
                      controller: emailctrl,
                      enabled: false,
                      decoration: const InputDecoration(
                          labelText: 'Email', suffixIcon: Icon(Icons.edit)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox.square(
              dimension: 30,
            ),
            SizedBox(
              height: 50,
              width: screensize.width * 0.9,
              child: Align(
                  alignment: Alignment.center,
                  child: Consumer(builder: (context, ref, child) {
                    return HngPrimaryButton(
                      isLoading: isLoading,
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          isLoading = true;
                        });
                      final result =  await ref
                            .read(appUserProvider.notifier)
                            .updateUserProfile(namectrl.text, imageFile);
                        setState(() {
                          isLoading = false;
                        });
                        if (!mounted) {
                          return;
                        }

                        if(result == null){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                                content: Center(child: Text('Profile Updated'))));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                                content: Center(child: Text(result))));}

                        
                      },
                      text: 'Save',
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}

Widget saveButton(
    bool isLoading, String text, VoidCallback onPressed, BuildContext context) {
  return ElevatedButton(
      onPressed: !isLoading ? onPressed : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          elevation: 0.0,
          minimumSize: const Size(262, 52),
          padding: const EdgeInsets.all(0.0)),
      child: Container(
          constraints: const BoxConstraints(minWidth: 262.0, minHeight: 52.0),
          alignment: Alignment.center,
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(text,
                  style: const TextStyle(color: ProjectColors.white))));
}
