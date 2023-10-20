// ignore_for_file: use_build_context_synchronously, unused_result

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/features/events/timeline_screen/upcoming_screen.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/widgets/ongoing_bottom_widget.dart';
import '../../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../riverpod/event_provider.dart';

class MyEventScreen extends ConsumerWidget {
  MyEventScreen({Key? key}) : super(key: key);
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.of(context).size.width * 0.2;
      if (maxScroll - currentScroll <= delta) {
        ref.read(myEventsProvider.notifier).fetchNextBatch();
      }
    });
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                shape: const CircleBorder(),
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.refresh),
                onPressed: () => ref.refresh(myEventsProvider)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
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
            events: ref.watch(myEventsProvider),
          ),
          OngoingBottomWidget(
            state: ref.watch(myEventsProvider),
          )
        ],
      ),
    );
  }
}
