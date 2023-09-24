import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';

class SelectGroup extends ConsumerWidget {
  const SelectGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsNotifier = ref.watch(groupProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.chevron_left)),
        title: const Text('Select Group'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            height: 1,
            color: Colors.black,
          ),
        ),
      ),
      body:           Padding(
                padding: ProjectConstants.bodyPadding,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        groupsNotifier.groups[index].name,
                        style: settingsItemTextStyle,
                      ),
                      onTap: () => Navigator.pop(
                        context,
                       groupsNotifier.groups[index].name,
                      ),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(),
                  borderRadius: BorderRadius.circular(8)),
                  
                    );
                  },
                  itemCount: groupsNotifier.groups.length,
                ))
    );
  }
}
