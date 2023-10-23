import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/features/groups/group_event_list_screen.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';

class GroupSearchDelegate extends SearchDelegate {
  GroupSearchDelegate(
      {super.searchFieldLabel,
      super.searchFieldDecorationTheme,
      super.keyboardType,
      super.textInputAction});

  @override
  String? get searchFieldLabel => 'Search by name or #<tagname>';

  @override
  TextStyle? get searchFieldStyle => const TextStyle();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = '', icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return Consumer(builder: (context, ref, child) {
      final searchProvider = ref.watch(groupSearchprovider(query));
      return searchProvider.when(data: (data) {
        List<Group> list = query.isEmpty ? [] : data;
        return  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final currentGroup = list[index];
              return Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return MyPeopleCard(
                      showVert: currentGroup.creatorId ==
                          ref.read(appUserProvider)?.id,
                      title: currentGroup.name,
                      image: currentGroup.image,
                      eventLength: currentGroup.eventCount,
                      bubbleVisible: true,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupEventsScreen(
                                group: currentGroup,
                              ),
                            ));
                      });
                },
                //child:
              );
            },
          ),
        );
      }, error: (error, stackTrace) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.0),
            child: Text(
              'Failed to Retrieve Groups',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }, loading: () {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Please wait..'),
              ),
            ],
          ),
        );
      });
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final searchProvider = ref.watch(groupSearchprovider(query));

      return searchProvider.when(data: (data) {
        List<Group> list = query.isEmpty ? [] : data;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              final currentGroup = list[index];
              return Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  return MyPeopleCard(
                      showVert: currentGroup.creatorId ==
                          ref.read(appUserProvider)?.id,
                      title: currentGroup.name,
                      image: currentGroup.image,
                      eventLength: currentGroup.eventCount,
                      bubbleVisible: true,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GroupEventsScreen(
                                group: currentGroup,
                              ),
                            ));
                      });
                },
                //child:
              );
            },
          ),
        );
      }, error: (error, stackTrace) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 35.0),
            child: Text(
              'Failed to Retrieve Groups',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      }, loading: () {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Please wait..'),
              ),
            ],
          ),
        );
      });
    });
  }
}
