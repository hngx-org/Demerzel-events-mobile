import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/user_provider.dart';
import 'package:hng_events_app/features/main/screen_util.dart';
import 'package:svg_flutter/svg.dart';
import 'package:hng_events_app/constants/colors.dart';

class SignIn extends ConsumerWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final authReader = ref.read(AuthRepository.provider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Welcome on board!',
                style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 22,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign in or Create an account',
                    style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer(builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        await ref
                            .read(appUserProvider.notifier)
                            .siginInWithGoogle()
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Successful!')));
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ScreenUtilInitScreen()));
                          // Navigator.pop(context);
                        // }).then((value) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(
                        //           content: Text('failed to signin!')));
                        }).catchError((error) {
                          Navigator.pop(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.symmetric(vertical: 9)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/google-color-icon.svg',
                            height: 24,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Continue with Google',
                            style: TextStyle(
                              fontFamily: 'NotoSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: ProjectColors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
