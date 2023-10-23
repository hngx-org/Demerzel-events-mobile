import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/features/events/timeline_screen/upcoming_screen.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/widgets/ongoing_bottom_widget.dart';
import '../../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../riverpod/event_provider.dart';

class AllEventsScreen extends ConsumerWidget {
  AllEventsScreen({super.key});
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.2;
      if (maxScroll - currentScroll <= delta) {
        ref.read(allEventsProvider.notifier).fetchNextBatch();
      }
    });

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding:  EdgeInsets.all(8.0.w),
            child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.refresh),
                onPressed: () =>ref.refresh(allEventsProvider)),
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 70.h),
            child: FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: const CircleBorder(),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CreateEvents();
                  }));
                },
                child: Container(
                  height: 70.r,
                  width: 70.r,
                  decoration: BoxDecoration(
                    color: ProjectColors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.black,
                  ),
                )),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          EventList(
            events: ref.watch(allEventsProvider),
          ),
          OngoingBottomWidget(
            state: ref.watch(allEventsProvider),
          )
        ],
      ),
    );
  }
}
