import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';
import 'package:hng_events_app/screens/create_group.dart';
import 'package:hng_events_app/screens/group_event_list_screen.dart';
import 'package:hng_events_app/screens/group_screens/group_search_delegate.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';
import 'package:hng_events_app/models/group.dart';

class PeopleScreen extends ConsumerStatefulWidget {
  const PeopleScreen({super.key});

  @override
  ConsumerState<PeopleScreen> createState() => _CreateGroupState();
}

class _CreateGroupState extends ConsumerState<PeopleScreen> {
  @override
  Widget build(BuildContext context) {
    final groupsNotifier = ref.watch(GroupProvider.groupProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                height: 1,
                color: Colors.black,
              )),
          title: Text(
            'My People',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: NeuTextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateGroup(),
                    ),
                  );
                },
                buttonColor: Theme.of(context).primaryColor,
                shadowColor: Theme.of(context).colorScheme.onBackground,
                borderColor: Theme.of(context).colorScheme.onBackground,
                buttonHeight: 40,
                borderRadius: BorderRadius.circular(8),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'Create',
                          style: TextStyle(
                            fontFamily: 'NotoSans',
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const Icon(Icons.add),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Consumer(
              builder: (context, ref, child) {
                List<Group> groups = ref.watch(groupSearchprovider);
                return IconButton(
                  onPressed: ()=> showSearch(
                    context: context, delegate: GroupSearchDelegate(groups: groups)), 
                  icon: const Icon(Icons.search)
                );
              }
            )
          ],
        ),
        body: 
        
        groupsNotifier.groups.isNotEmpty?
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Visibility(
            visible: !groupsNotifier.isBusy,
            replacement: const Center(child: CircularProgressIndicator()),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
                ),
              itemCount: groupsNotifier.groups.length,
              itemBuilder: (BuildContext context, int index) {
                final currentGroup = groupsNotifier.groups[index];
                return MyPeopleCard(
                    title: currentGroup.name,
                    image: currentGroup.image,
                    eventLength: currentGroup.eventCount,
                    bubbleVisible: true,
                    onPressed: () async{
              
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventsScreen(
                              group: currentGroup,
                            ),
                          ));
                    });
              },
            ),
          ),
        ):
        groupsNotifier.isBusy? const Center(child: CircularProgressIndicator(),):
        Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("No group was found", textAlign: TextAlign.center),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => groupsNotifier.getGroups(),
              child: const Text(
                "Tap to Retry",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      )
    );
  }
}