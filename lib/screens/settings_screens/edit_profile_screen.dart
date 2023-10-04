import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.name, required this.image, required this.email, required this.ref});
  final String name;
  final String email;
  final String image;
  final WidgetRef ref;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  File? imageFile;
  AuthRepository repo = AuthRepository(localStorageService: const LocalStorageService());
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
                    backgroundImage: (imageFile == null)? NetworkImage(widget.image) : FileImage(imageFile!) as ImageProvider,
                    radius: 100,
                  ),
                   Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: ()async{
                          await getFromGallery();
                        }, 
                        icon: Icon(
                          Icons.camera_alt, 
                          size: 30,
                          color: Theme.of(context).colorScheme.primary,)
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
                        suffixIcon: Icon(Icons.edit, color: ProjectColors.purple,)
                      ),
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
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.edit)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox.square(dimension: 30,),
            SizedBox(
              height: 50,
              width: screensize.width*0.9,
              child: Align(
                alignment: Alignment.centerRight,
                child: Consumer(
                  builder: (context, ref, child) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
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
                      child: HngPrimaryButton(
                        onPressed: () async{
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (imageFile != null) {
                            await repo.updateProfilePhoto(imageFile!).then(
                              (value) {
                                ref.read(appUserProvider.notifier).getUserBE().then((value) {
                                 Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text('Successful'))
                                  )
                                ); 
                                });
                                
                            }).catchError((error){
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text(error.toString()))
                                  )
                                );
                            });
                          }
                          if (namectrl.text != '' && namectrl.text != widget.name) {
                            await repo.updateUserProfile(namectrl.text).then(
                              (value) {
                                ref.read(appUserProvider.notifier).getUserBE().then((value) {
                                  Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text('Successful'))
                                  )
                                );
                                });
                                
                              }).catchError((error){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text(error.toString()))
                                  )
                                );
                              });
                          }
                        },
                        text: 'Save',),
                    );
                  }
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}