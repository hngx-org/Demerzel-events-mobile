import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class MyPeopleCard extends StatelessWidget {
  const MyPeopleCard({
    super.key,
    required this.title,
    required this.image,
    required this.bubbleVisible,
    required this.onPressed,
    required this.eventLength,
    this.onDelete,
    this.groupId,
    this.onEdit, required this.showVert,

    //  Null Function(String groupId)? onEdit,
    // required String groupId,
  });
final bool showVert;
  final String title;
  final String image;
  final bool bubbleVisible;
  final VoidCallback onPressed;
  final int eventLength;
  final Function? onDelete;
  final String? groupId;
  final Function? onEdit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    spreadRadius: 0, // Spread radius
                    blurRadius: 0, // Blur radius
                    offset: Offset(4, 5), // Offset in x and y directions
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSans",
                          ),
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Delete',
                              child: Text('Delete'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Edit',
                              child: Text('Edit'),
                            ),
                          ],
                          onSelected: (value) async {
                            if (value == 'Delete') {
                              await onDelete!(groupId);
                            } else if (value == 'Edit') {
                              await onEdit!();
                            }
                          },
                          child: const Icon(Icons.more_vert),
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: image == ''
                            ? Image.asset(
                                'assets/illustrations/dancers_illustration.png')
                            : SizedBox(
                                height: 110,
                                width: 130,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image: image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: bubbleVisible,
              child: Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      "$eventLength events",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
