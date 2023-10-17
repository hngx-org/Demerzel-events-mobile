import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/event_provider.dart';

class GroupMembersPage extends ConsumerWidget {
  const GroupMembersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.watch(EventProvider.provider);
    final members = eventNotifier.allGroupEvents!.data.members;
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
          'Group Memebrs',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView.builder(
            itemCount: members!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
                  shape: const Border(
                    bottom: BorderSide(
                        color: ProjectColors.lightBoxBorderColor, width: 0.5),
                  ),
                  title: Text(
                    members[index].name,
                  ),
                  leading: members[index].avatar.isEmpty
                      ? const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/illustrations/smiley_face.png"),
                          radius: 15,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(members[index].avatar),
                          radius: 15,
                        ),
                )),
      ),
    );
  }
}
