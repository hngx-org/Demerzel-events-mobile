import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/comment_provider.dart';
import 'package:hng_events_app/util/snackbar_util.dart';
import 'package:image_cropper/image_cropper.dart';
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
  CroppedFile? _croppedFile;
  String? filePath ;
  bool empty = true;
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
                IconButton(onPressed: _cropImage, icon: const Icon(Icons.crop)),
              ],
            ),
            Expanded(
                // height: 500,
                // width: double.infinity,
                child: _image(),),
                //Image.file(File(widget.image!.path))),
            // SendBar(controller: controller, commentNotifier: commentNotifier, eventId: widget.eventId,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                 padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 10.0),
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
                        onChanged: (value) {
                          if (value != '') {
                            setState(() {
                              empty = false;
                            });
                          }else{
                            setState(() {
                              empty = true;
                            });
                          }
                        },
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
                    // commentNotifier.isAddingComments
                    //     ? const SizedBox(
                    //         width: 30,
                    //         height: 30,
                    //         child: CircularProgressIndicator())
                        //:
                         empty? SizedBox.shrink():
                         InkWell(
                            onTap: () {
                              if (_croppedFile != null) {
                                filePath = _croppedFile!.path;
                              }else{
                                filePath = widget.image!.path;
                              }
                              
                              
                              log(filePath!);
                              if ( controller.text.isEmpty ) {
                                showSnackBar(context, "You can't send a comment without a caption", Colors.red);
                                return;
                              }
                              Navigator.pop(context);
                                      
                              commentNotifier
                                  .createComment(
                                    controller.text ,
                                    widget.eventId,
                                    File(filePath!),
                                  ).then((value) => controller.clear());
                                    
                            },
                            child: Icon(
                              Icons.send,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
 Widget _image() {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
    
      final path = _croppedFile!.path;
       
        filePath = path;
   
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.maxFinite,
          //0.8 * screenWidth,
          maxHeight: double.maxFinite
          //0.8 * screenHeight,
        ),
        child:  Image.file(File(path)),
      );
    } else if (widget.image != null) {
      final path = widget.image!.path;
      return ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: double.maxFinite,
          //0.8 * screenWidth,
          maxHeight:double.maxFinite,
          // 0.8 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
  Future<void> _cropImage() async {
    if (widget.image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: widget.image!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              //toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
          filePath = _croppedFile!.path;
        });
      }
    }
  }

}

