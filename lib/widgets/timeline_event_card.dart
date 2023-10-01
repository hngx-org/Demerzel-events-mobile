
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/constants/colors.dart';

Widget TimelineEventCard({required BuildContext context, required Size screensize, required String? image, required String title, required String time, required String location, required String date, required String activity}){
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
      width: screensize.width*0.9,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Material(
              borderRadius: BorderRadius.circular(5),
              child: image== null? ColoredBox(
                color: Colors.grey,
                child: SizedBox.square(
                  dimension: 100.r
                ),
              )              
              :SizedBox(
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    image,
                    height: 90.r,
                    width: 90.r,
                    fit: BoxFit.fill,                
                  ),
                ),
              ),
            )
          ),
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
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16
                      )
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.r, color: ProjectColors.grey
                      )
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      location,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.r)
                    )
                  ),
                ],
              ),
            )
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.more_vert),
                Text(activity)
              ],
            )
          ),
        ],
      ),
    ),
  );
}
