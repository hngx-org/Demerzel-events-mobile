import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/widgets/comment_card.dart';
import 'package:hng_events_app/widgets/date_card.dart';
import 'package:svg_flutter/svg.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.chevron_left),
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
                          child:
                              SvgPicture.asset(ProjectConstants.imagePicker)),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 70,
                        height: 35,
                        child: TextField(
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
                          child: SvgPicture.asset(ProjectConstants.microphone))
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

class Chat {
  final String text;
  final String? attachemt;

  Chat({required this.text, this.attachemt});
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
