import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  const AppHeader({super.key, required this.title, this.backButton = true });
  final String title;
  final bool? backButton;
  @override
  Size get preferredSize => const Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRef = ref.watch(UserProvider.notifier);
    return Container(
      color: ProjectColors.white,
      padding: const EdgeInsets.only(
        bottom: 18,
        left: 10,
        right: 20,
      ),
      child: Row(
        
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: backButton!,
            replacement: const SizedBox.shrink(),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.chevron_left)),
          ),
           Align(
            alignment: Alignment.bottomCenter,
             child: Text(
                   title,
                   style: const TextStyle(
                       fontFamily: 'inter',
                       fontWeight: FontWeight.w700,
                       fontSize: 24),
                 ),
           ),
          Visibility(
              visible: userRef.user != null && userRef.user?.photoURL != null,
              replacement: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/img4.png')),
              child: CircleAvatar(
                backgroundImage: NetworkImage(userRef.user?.photoURL ?? ''),
              ))
        ],
      ),
    );
  }
}
