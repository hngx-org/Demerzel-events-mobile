import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';

class EveryoneScreen extends StatelessWidget {
  const EveryoneScreen({super.key});

  Widget bodyBuild(String title, String specifictime, String date,
      String location, String time) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ProjectColors.white,
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
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/emoji.png',
                  fit: BoxFit.contain,
                  width: 100.r,
                  height: 100.r,
                ),
                SizedBox(
                  width: 1.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24.h)),
                      SizedBox(height: 6.h),
                      Text(date,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.r)),
                      Text(specifictime,
                          style: TextStyle(
                              fontSize: 12.r, color: ProjectColors.grey)),
                      SizedBox(height: 6.h),
                      Text(location,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.r)),
                    ],
                  ),
                ),
                const Spacer(),
                const Column(
                  children: [Icon(Icons.more_vert), Spacer()],
                )
              ],
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.r,
                  color: ProjectColors.purple,
                ),
              ),
              SizedBox(
                width: 2.w,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(bottom: 90.h),
      child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return bodyBuild('Football game', 'May 20,2023', 'Friday 4 - 6 PM',
                'Teslim Balogun Stadium', 'LIVE');
          }),
    );
  }
}
