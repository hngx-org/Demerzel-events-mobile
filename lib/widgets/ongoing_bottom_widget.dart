import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/models/event_model.dart';
import 'package:hng_events_app/riverpod/pagination_state.dart';

class OngoingBottomWidget extends ConsumerWidget {
  const OngoingBottomWidget({
    super.key,
    required this.state,
  });

  final PaginationState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          onGoingLoading: (events) => const Center(
            child: CircularProgressIndicator(),
          ),
          onGoingError: (items, e, stk) => const Column(
            children: [
              Icon(Icons.info),
              SizedBox(
                height: 20,
              ),
              Text('Error fetching more items'),
            ],
          ),
        ),
      ),
    );
  }
}
