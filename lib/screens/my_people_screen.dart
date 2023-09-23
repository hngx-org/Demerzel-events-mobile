import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/screens/event_list_screen.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:hng_events_app/widgets/my_people_header.dart';

class PeopleScreen extends ConsumerStatefulWidget {
  const PeopleScreen({super.key});

  @override
  ConsumerState<PeopleScreen> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<PeopleScreen> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final groups = ref.watch(groupsProvider);
    // ref.watch(groupListProvider);

    return Scaffold(
      backgroundColor: ProjectColors.bgColor,
      appBar: const MyPeopleHeader(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: groups.when(data: (data) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                //childAspectRatio: 3 / 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            itemCount: data.data.group.length,
            itemBuilder: (BuildContext context, int index) {
              return MyPeopleCard(
                  title: data.data.group[index].name,
                  image:  NetworkImage(data.data.group[index].groupImage!),
                  bubbleVisible: true,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EventsScreen(),
                        ));
                  });
            },
          );
        }, error: (error, stackTrace) {
          return const Center(
            child: Text('Error loading groups'),
          );
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
