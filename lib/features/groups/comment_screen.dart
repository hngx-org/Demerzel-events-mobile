import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/features/groups/preview_image.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/comment_provider.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';
import 'package:hng_events_app/util/snackbar_util.dart';
import 'package:hng_events_app/widgets/comment_card.dart';
import 'package:hng_events_app/widgets/date_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svg_flutter/svg.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final Event event;
  final String? groupId;
  const CommentScreen({
    super.key,
    required this.event,
    this.groupId,
  });

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

  Future<XFile> _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800.w,
      maxHeight: 1800.h,
    );
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
        imagePath = File(pickedFile.path).path;
        imagePath.split('/').last;
      });
    }
    return pickedFile!;
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
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Comments'),
        //SvgPicture.asset('assetName'),
        // title: Text(!commentNotifier.isBusy?'${commentNotifier.comments.length} comments': ''),

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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: DateCard()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: CommentPageCard(
                          event: widget.event,
                          isSubscribing: commentNotifier.isSubscribing,
                          joined: !eventNotifier.userEvents
                              .any((element) => element.id == widget.event.id),
                          onSubscribe: () async {
                            commentNotifier.setIsSubscribing(true);
                            eventNotifier
                                .subscribeToEvent(widget.event.id)
                                .then((value) => {
                                      if (value)
                                        {
                                          showSnackBar(
                                              context,
                                              'Subscribe successfully',
                                              Colors.green),
                                          eventNotifier.getUserEvent(),
                                        }
                                      else
                                        {
                                          showSnackBar(context,
                                              eventNotifier.error, Colors.red)
                                        },
                                       commentNotifier.setIsSubscribing(false)
                                    });

                           
                          },
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 18.h),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (context, index) =>  SizedBox(
                            height: 10.h,
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
                  height: 80.h,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 7.0, bottom: 5 ),
                    child: SendBar(controller: controller, commentNotifier: commentNotifier, eventId: widget.event.id)
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

class SendBar extends StatefulWidget {
  const SendBar({
    super.key,
    required this.controller,
    required this.commentNotifier,
    required this.eventId,
     this.image,
  });

  final TextEditingController controller;
  final CommentProvider commentNotifier;
  final String eventId;
  final File? image;

  @override
  State<SendBar> createState() => _SendBarState();
}

class _SendBarState extends State<SendBar> {
  final bool showImagePicker = true;
bool empty = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
       showImagePicker? InkWell(
          onTap: () async {
            final pickedFile =
                await ImagePicker().pickImage(
              source: ImageSource.gallery,
              maxWidth: 1800,
              maxHeight: 1800,
            );
            if (pickedFile != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    PreviewImage(image: pickedFile, eventId: widget.eventId, text: widget.controller.text, )));
            }
            
          },
          //() => Navigator.of(context).push(MaterialPageRoute(builder: (context) => CropImageScreen(title: 'Image',),)),

          child: SvgPicture.asset(
            ProjectConstants.imagePicker,
            color:
                Theme.of(context).colorScheme.onBackground,
          ),
        ): SizedBox.shrink(),
         SizedBox(
          width: 10.w,
        ),
        Container(
        width: MediaQuery.sizeOf(context).width * 0.7,
        constraints: BoxConstraints(
          minHeight: 45.0.h, // Set a minimum height for the SizedBox.
        ),
        child: SizedBox(
          height: widget.controller.text.isEmpty ? 45.0 : null,
          child: TextField(
            onChanged: (value) {
              if (value.isNotEmpty) {
          setState(() {
            empty = false;
          });
              } else {
          setState(() {
            empty = true;
          });
              }
            },
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            // maxLines: null, // Set maxLines to null for dynamic expansion.
            decoration: InputDecoration(
              hintText: 'Type a message here',
              border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        )
,
        const SizedBox(
          width: 10,
        ),
        widget.commentNotifier.isAddingComments
            ?  SizedBox(
                width: 30.w,
                height: 30.h,
                child: const CircularProgressIndicator())
            : InkWell(
                onTap: () {
                  if (widget.controller.text.isEmpty) {
                    return;
                  }
                  widget.commentNotifier
                      .createComment(
                        widget.controller.text,
                        widget.eventId,
                        widget.image,
                      )
                      .then(
                          (value) => {widget.controller.clear()});
                },
                child: Icon(
                  Icons.send,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground,
                ),
              ),
      ],
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
                height: 30.h,
                width: 30.w,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: profilePic.isEmpty
                        ? Image.asset(
                            profilePic,
                            fit: BoxFit.cover,
                            height: 30.h,
                            width: 30.w,
                          )
                        : Image.network(
                            profilePic,
                            fit: BoxFit.cover,
                            height: 30.h,
                            width: 30.w,
                          )))
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: MediaQuery.sizeOf(context).width * 0.73518,
              // width: double.infinity,
              decoration: ProjectConstants.appBoxDecoration.copyWith(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style:
                          normalTextStyle.copyWith(fontWeight: FontWeight.w700),
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
