import 'package:flutter/material.dart';
import 'package:hng_events_app/constants/colors.dart';
import 'package:hng_events_app/screens/create_group.dart';

class MyPeopleHeader extends StatelessWidget implements PreferredSizeWidget {
  const MyPeopleHeader({super.key});
  @override
  Size get preferredSize => const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.white,
      padding: const EdgeInsets.only(
        bottom: 18,
        left: 22,
        right: 22,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "My People",
            style: TextStyle(
              fontSize: 27,
              fontFamily: "NotoSans",
              fontWeight: FontWeight.w700,
              color: ProjectColors.black,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black, // Shadow color
                  spreadRadius: -2, // Spread radius
                  blurRadius: 0, // Blur radius
                  offset: Offset(4, 3), // Offset in x and y directions
                ),
              ],
            ),
            child: TextButton(
              onPressed: () {
                 Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateGroup(),
                          ),
                        );
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(ProjectColors.purple),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                side: MaterialStateProperty.all(
                  const BorderSide(
                    width: 2,
                  ),
                ),
              ),
              child: const Row(
                children: [
                  Text(
                    "Create",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "NotoSans",
                      fontWeight: FontWeight.w700,
                      color: ProjectColors.black,
                    ),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Icon(
                    Icons.add,
                    size: 20,
                    color: ProjectColors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
