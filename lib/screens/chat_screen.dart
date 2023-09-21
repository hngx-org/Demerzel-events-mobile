// import 'package:flutter/material.dart';
// import 'package:hng_events_app/constants/colors.dart';
// import 'package:hng_events_app/constants/constants.dart';
// import 'package:hng_events_app/constants/images.dart';
// import 'package:hng_events_app/constants/styles.dart';
// import 'package:hng_events_app/widgets/components/button/hng_primary_button.dart';

// class ChatScreen extends StatelessWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         leading: GestureDetector(
//           child: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: ProjectColors.black,
//           ),
//         ),
//         title: const Text(
//           '11 Comments',
//           style: TextStyle(color: ProjectColors.black),
//         ),
//       ),
//       bottomSheet: const InputField(),
//       body:
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Divider(),
//               const SizedBox(
//                 height: 5,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   color: ProjectColors.grey.withOpacity(0.5),
//                 ),
//                 child: Text(
//                   'Today',
//                   style: normalTextStyle.copyWith(fontSize: 10),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(15),
//                   border: Border.all(color: ProjectColors.lightBoxBorderColor),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                             flex: 4,
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   ProjectConstants.profileImage,
//                                   height: 20,
//                                   width: 20,
//                                 ),
//                                 const SizedBox(
//                                   width: 10,
//                                 ),
//                                 const Text(
//                                   'Full game',
//                                   style: TextStyle(
//                                       fontWeight: textBold,
//                                       color: ProjectColors.purple),
//                                 ),
//                               ],
//                             )),
//                         Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   border: Border.all(
//                                       color: ProjectColors.grey.withOpacity(0.5))),
//                               child: const Center(
//                                   child: Text(
//                                     'May 20',
//                                     style: TextStyle(fontSize: 10),
//                                   )),
//                             )),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Icon(
//                           Icons.location_on_outlined,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('Teslim Balogun Stadium'),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 8,
//                     ),
//                     const Row(
//                       children: [
//                         Icon(
//                           Icons.access_time_outlined,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text('Friday 4 - 7 PM'),
//                       ],
//                     ),
//                     const Divider(),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: false,
//                           onChanged: (val) {},
//                         ),
//                         const Text('Check box to invite to Techies')
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     SizedBox(
//                       height: 40,
//                       child: HngPrimaryButton(
//                         onPressed: () {},
//                         text: 'Share',
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               const Messages(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Messages extends StatelessWidget {
//   const Messages({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (context, index) {
//           return Row(
//             // mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CircleAvatar(
//                 radius: 15,
//                 backgroundImage:
//                 AssetImage(ProjectImages.chatAvatarImage1),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(
//                         color: ProjectColors.lightBoxBorderColor),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'jonexx',
//                         style: TextStyle(
//                             fontSize: 9,
//                             color: ProjectColors.mainPurple),
//                       ),
//                       const SizedBox(height: 7,),
//                       const Text("I defo wont't miss it"),
//                       const SizedBox(height: 7,),
//                       Container(
//                         height: 300,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           image: const DecorationImage(
//                               image: AssetImage(
//                                 ProjectImages.chatAvatarImage2,),
//                               fit: BoxFit.cover),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//             ],
//           );
//         });
//   }
// }

// class InputField extends StatelessWidget {
//   const InputField({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       width: MediaQuery.of(context).size.width,
//       height: 80,
//       color: Colors.white,
//       child: Row(
//         children: [
//           const Icon(Icons.image),
//           const SizedBox(width: 10,),
//           Expanded(child: TextFormField(
//             decoration: InputDecoration(
//                 hintText: 'Type a message',
//               hintStyle: const TextStyle(
//                 fontSize: 14,
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
//             ),
//           )),
//           const SizedBox(width: 10,),
//           const Icon(Icons.mic),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/models/chat.dart';
import 'package:hng_events_app/widgets/comment_card.dart';
import 'package:hng_events_app/widgets/date_card.dart';
import 'package:svg_flutter/svg.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        //SvgPicture.asset('assetName'),
        title: const Text('11 comments'),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            height: 1,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: DateCard()),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: CommentPageCard(
                          eventTitle: 'Football Game',
                          dateAndTime: 'Friday 4 - 7 PM',
                          location: "Teslim Balogun Stadium",
                          day: 'May 20'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        //TODO change to event count from backend
                        itemCount: chats.length,
                        itemBuilder: (context, index) {
                          return ChatCard(
                            userName: 'Johnexx',
                            text: chats[index].text,
                            profilePic: ProjectConstants.profilePicture,
                            chatPicture: chats[index].attachemt,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          ProjectConstants.imagePicker,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 70,
                        height: 45,
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            hintText: 'Type a message here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          ProjectConstants.microphone,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.userName,
    required this.text,
    required this.profilePic,
    this.chatPicture,
  });

  final String userName, text, profilePic;
  final String? chatPicture;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 30,
                width: 30,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      profilePic,
                      fit: BoxFit.cover,
                      height: 30,
                      width: 30,
                    ))),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.sizeOf(context).width * 0.73518,
              // width: double.infinity,
              decoration: ProjectConstants.appBoxDecoration,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: normalTextStyle,
                    ),
                    Text(
                      text,
                      style: normalTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    chatPicture != null
                        ? SizedBox(
                            // height: 60,
                            // width: 60,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.asset(chatPicture!)))
                        : const SizedBox(),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

List<Chat> chats = [
  Chat(
    text: "I will be there, no matter what.",
  ),
  Chat(text: "I defo won’t miss this", attachemt: ProjectConstants.chatPicture),
  Chat(
      text: "Snippet of the race, more picture coming",
      attachemt: ProjectConstants.chatPicture2),
];
