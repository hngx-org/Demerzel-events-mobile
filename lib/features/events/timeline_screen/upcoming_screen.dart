import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hng_events_app/features/events/create_event/create_event_screen.dart';
import 'package:hng_events_app/riverpod/pagination_state.dart';
import 'package:hng_events_app/widgets/event_listBuilder.dart';
import 'package:hng_events_app/widgets/ongoing_bottom_widget.dart';
import '../../../constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import '../../../riverpod/event_provider.dart';

class UpcomingEventScreen extends ConsumerWidget {
  UpcomingEventScreen({super.key});
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.addListener(() {
      double maxScroll = controller.position.maxScrollExtent;
      double currentScroll = controller.position.pixels;
      double delta = MediaQuery.sizeOf(context).width * 0.2;
      if (maxScroll - currentScroll <= delta) {
        ref.read(upcomingEventsProvider.notifier).fetchNextBatch();
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
                onPressed: () =>
                    //ref.read(itemsProvider.notifier).fetchNextBatch())
                    ref.refresh(upcomingEventsProvider)),
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
            events: ref.watch(upcomingEventsProvider),
          ),
          OngoingBottomWidget(
            state: ref.watch(upcomingEventsProvider),
          )
        ],
      ),
    );
  }
}

class EventList extends ConsumerWidget {
  const EventList({
    super.key,
    required this.events,
  });
  final PaginationState<Event> events;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return events.when(
        error: (error, stackTrace) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 35.0),
                child: Text(
                  'Failed to Retrieve Events',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            //),
          );
        },
        loading: () {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                  ),
                  const CircularProgressIndicator(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Please wait..'),
                  ),
                ],
              ),
            ),
          );
        },
        onGoingError: (List<Event> events, Object? e, StackTrace? stk) =>
            EvenListBuilder(events),
        // const Text('error'),
        onGoingLoading: (events) {
          return EvenListBuilder(events);
          // const SliverToBoxAdapter(
          //     child: Center(child: CircularProgressIndicator()));
        },
        data: (events) => events.isEmpty
            ? const SliverToBoxAdapter(
                child: Center(
                  child: Text('No Events'),
                ),
              )
            : EvenListBuilder(events));
  }
}
