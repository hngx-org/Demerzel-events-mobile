import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/models/event_model.dart';

Widget TimelineEventCard(
    {required BuildContext context,
    required Size screensize,
    required Event event,
    Null Function(String eventId)? onDelete,
    Null Function()? onEdit,
    
    required String eventId,
    required bool showVert}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          offset: Offset(4, 4),
          color: ProjectColors.black,
        ),
      ],
      borderRadius: BorderRadius.all(
        Radius.circular(10.r),
      ),
      border: Border.all(color: ProjectColors.black, width: 1),
      color: Theme.of(context).cardColor,
    ),
    child: SizedBox(
      height: 150.h,
      width: screensize.width * 0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                child: event.thumbnail == null
                    ? ColoredBox(
                        color: Colors.grey,
                        child: SizedBox.square(dimension: 100.r),
                      )
                    : SizedBox(
                        height: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            event.thumbnail,
                            height: 90.r,
                            width: 90.r,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              )),
          Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            event.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )),
                    Expanded(
                        flex: 1,
                        child: Text(event.startTime,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))),
                    Expanded(
                        flex: 1,
                        child: Text(event.startDate,
                            style: TextStyle(
                                fontSize: 12.r, color: ProjectColors.grey))),
                    Expanded(
                        flex: 1,
                        child: Text(event.location,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.r))),
                  ],
                ),
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  showVert
                      ? PopupMenuButton<String>(
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
                          child: const Icon(Icons.more_vert),
                          onSelected: (String value) async {
                            if (value == "Delete") {
                              await onDelete!(eventId);
                            } else if (value == "Edit") {
                              await onEdit!();
                            }
                          },
                        )
                      : const SizedBox(),
                ],
              )),
        ],
      ),
    ),
  );
}
