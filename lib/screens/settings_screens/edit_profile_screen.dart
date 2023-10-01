import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.name, required this.image, required this.email});
  final String name;
  final String email;
  final String? image;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController namectrl = TextEditingController();
  TextEditingController emailctrl = TextEditingController();
  String image = '';
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
    return SafeArea(
      child: Scaffold(
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
                    const CircleAvatar(
                      // backgroundImage: ,
                      radius: 100,
                    ),
                     Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          onPressed: (){}, 
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
                            await repo.updateUserProfile(namectrl.text, image).then(
                              (value) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Center(child: Text('Successful'))
                                  )
                                );
                              }).catchError((error){
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(child: Text(error.toString()))
                                  )
                                );
                              });
                            // Navigator.pop(context);
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
      ));
  }
}