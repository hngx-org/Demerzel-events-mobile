import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/images.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ProjectColors.black,
          ),
        ),
        title: const Text(
          '11 Comments',
          style: TextStyle(color: ProjectColors.black),
        ),
      ),
      bottomSheet: InputField(),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ProjectColors.grey.withOpacity(0.5),
                ),
                child: Text(
                  'Today',
                  style: normalTextStyle.copyWith(fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ProjectColors.lightBoxBorderColor),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Row(
                              children: [
                                Image.asset(
                                  ProjectConstants.profileImage,
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Full game',
                                  style: TextStyle(
                                      fontWeight: textBold,
                                      color: ProjectColors.purple),
                                ),
                              ],
                            )),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ProjectColors.grey.withOpacity(0.5))),
                              child: Center(
                                  child: Text(
                                    'May 20',
                                    style: TextStyle(fontSize: 10),
                                  )),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Teslim Balogun Stadium'),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('Friday 4 - 7 PM'),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (val) {},
                        ),
                        Text('Check box to invite to Techies')
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: HngPrimaryButton(
                        onPressed: () {},
                        text: 'Share',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Messages(),
            ],
          ),
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  const Messages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Row(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:
                AssetImage(ProjectImages.chatAvatarImage1),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: ProjectColors.lightBoxBorderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'jonexx',
                        style: TextStyle(
                            fontSize: 9,
                            color: ProjectColors.mainPurple),
                      ),
                      const SizedBox(height: 7,),
                      Text("I defo wont't miss it"),
                      const SizedBox(height: 7,),
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage(
                                ProjectImages.chatAvatarImage2,),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          const Icon(Icons.image),
          const SizedBox(width: 10,),
          Expanded(child: TextFormField(
            decoration: InputDecoration(
                hintText: 'Type a message',
              hintStyle: const TextStyle(
                fontSize: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            ),
          )),
          const SizedBox(width: 10,),
          const Icon(Icons.mic),
        ],
      ),
    );
  }
}
