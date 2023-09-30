import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/repositories/auth_repository.dart';
import 'package:hng_events_app/services/local_storage/shared_preference.dart';
import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.name, required this.image});
  final String name;
  final String? image;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController namectrl = TextEditingController();
  String image = '';
  AuthRepository repo = AuthRepository(localStorageService: const LocalStorageService());
  @override
  void initState() {
    namectrl.text = widget.name;
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
              CircleAvatar(
                // backgroundImage: ,
                radius: 40,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: (){}, 
                    icon: Icon(
                      Icons.camera_alt, 
                      color: Theme.of(context).colorScheme.primary,)
                  ),
                ),
              ),
              TextField(
                controller: namectrl,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: Icon(Icons.edit)
                ),
              ),
              const TextField(
                enabled: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  suffixIcon: Icon(Icons.edit)
                ),
              ),
              SizedBox(
                height: 20,
                width: screensize.width*0.9,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Consumer(
                    builder: (context, ref, child) {
                      return HngPrimaryButton(
                        onPressed: () async{
                          showDialog(
                            context: context, 
                            builder: (context){
                              return const CircularProgressIndicator();
                            }
                          );
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
                                  content: Center(child: Text(error))
                                )
                              );
                            });
                          Navigator.pop(context);
                        },
                        text: 'Save',);
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