import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/comment_provider.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/util/date_formatter.dart';
import 'package:hng_events_app/widgets/comment_card.dart';
import 'package:hng_events_app/widgets/date_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final Event event;
  const CommentScreen({super.key, required this.event});

  @override
  ConsumerState<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref
          .read(CommentProvider.provider.notifier)
          .getEventComments(widget.event.id);
    });
    controller = TextEditingController();
    super.initState();
  }

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentNotifier = ref.watch(CommentProvider.provider);
    final eventNotifier = ref.watch(EventProvider.provider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        //SvgPicture.asset('assetName'),
        title: Text('${commentNotifier.comments.length} comments'),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            height: 1,
            color: Colors.black,
          ),
        ),
      ),
      body: Visibility(
        visible: !commentNotifier.isBusy,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: DateCard()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CommentPageCard(
                          event: widget.event,
                          joined: !eventNotifier.userEvents
                              .any((element) => element.id == widget.event.id),
                          onSubscribe: () async {
                            await eventNotifier
                                .subscribeToEvent(widget.event.id);
                            await eventNotifier.getUserEvent();
                            await commentNotifier
                                .getEventComments(widget.event.id);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          itemCount: commentNotifier.comments.length,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              userName:
                                  commentNotifier.comments[index].creator.name,
                              text: commentNotifier.comments[index].body,
                              profilePic: commentNotifier
                                  .comments[index].creator.avatar,
                              chatPicture: commentNotifier
                                      .comments[index].images.isNotEmpty
                                  ? commentNotifier.comments[index].images[0]
                                  : null,
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
                  child: Column(
                    children: [
                      Text(imagePath.split('/').last),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: _getFromGallery,
                              child: SvgPicture.asset(
                                ProjectConstants.imagePicker,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.7,
                              height: 45,
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Type a message here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                commentNotifier
                                    .createComment(
                                        controller.text, widget.event.id, image)
                                    .then((value) => {controller.clear()});
                              },
                              child: const Icon(
                                Icons.send,
                                color: ProjectColors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                    child: profilePic.isEmpty
                        ? Image.asset(
                            profilePic,
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                          )
                        : Image.network(
                            profilePic,
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                          )))
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
                                child: Image.network(chatPicture!)))
                        : const SizedBox(),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

// List<Comment> chats = [
//   Comment(
//     text: "I will be there, no matter what.",
//   ),
//   Comment(text: "I defo won’t miss this", attachemt: ProjectConstants.chatPicture),
//   Comment(
//       text: "Snippet of the race, more picture coming",
//       attachemt: ProjectConstants.chatPicture2),
// ];