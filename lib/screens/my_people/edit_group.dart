import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/group_provider.dart';

class EditGroupName extends ConsumerStatefulWidget {
  final String currentGroupName;

  const EditGroupName({
    Key? key,
    required this.currentGroupName,
  }) : super(key: key);

  @override
  _EditGroupNameState createState() => _EditGroupNameState();
}

class _EditGroupNameState extends ConsumerState<EditGroupName> {
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupNameController.text = widget.currentGroupName;
  }

  @override
  Widget build(BuildContext context) {
    final groupProvider = ref.read(GroupProvider.groupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Group Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'New Group Name'),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final newGroupName = _groupNameController.text;

                   await groupProvider.updateGroupName(
                    newGroupName,
                  );
                  
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
