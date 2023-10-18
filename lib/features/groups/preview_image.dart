import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/comment_provider.dart';
import 'package:image_picker/image_picker.dart';

class PreviewImage extends ConsumerStatefulWidget {
  const PreviewImage({
    super.key,
    required this.image,
    required this.eventId,
  });
  final XFile? image;
  final String eventId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreviewImageState();
}

class _PreviewImageState extends ConsumerState<PreviewImage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final commentNotifier = ref.watch(CommentProvider.provider);
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.crop)),
              ],
            ),
            Expanded(
                // height: 500,
                // width: double.infinity,
                child: Image.file(File(widget.image!.path))),
            // SendBar(controller: controller, commentNotifier: commentNotifier, eventId: widget.eventId,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.8,
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
                  commentNotifier.isAddingComments
                      ? const SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator())
                      : InkWell(
                          onTap: () {
                            commentNotifier
                                .createComment(
                                  controller.text,
                                  widget.eventId,
                                  File(widget.image!.path),
                                )
                                .then((value) => {
                                      Navigator.pop(context),
                                      controller.clear()
                                    });
                          },
                          child: Icon(
                            Icons.send,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
