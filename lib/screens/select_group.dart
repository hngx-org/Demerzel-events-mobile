import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/constants/constants.dart';
import 'package:hng_events_app/constants/styles.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';

class SelectGroup extends ConsumerWidget {
  const SelectGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groups = ref.watch(groupsProvider);
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
      body: groups.when(
          data: (data) {
            return Padding(
                padding: ProjectConstants.bodyPadding,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        data[index].name,
                        style: settingsItemTextStyle,
                      ),
                      onTap: () => Navigator.pop(
                        context,
                        data[index].name,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(),
                  borderRadius: BorderRadius.circular(8)),
                  
                    );
                  },
                  itemCount: data.length,
                ));
          },
          error: (error, stackTrace) => const Text('Error Loading Groups'),
          loading: () {
            return const CircularProgressIndicator();
          }),
    );
  }
}
