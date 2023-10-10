import 'package:flutter/material.dart';
import 'package:hng_events_app/models/group.dart';
import 'package:hng_events_app/screens/group_event_list_screen.dart';
import 'package:hng_events_app/widgets/my_people_card.dart';

class GroupSearchDelegate extends SearchDelegate {
    final List<Group> groups;
  GroupSearchDelegate({
    super.searchFieldLabel, super.searchFieldDecorationTheme, super.keyboardType, super.textInputAction, required this.groups});

  @override
  String? get searchFieldLabel => '';

  @override
  TextStyle? get searchFieldStyle => const TextStyle();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: ()=> query ='', 
        icon: const Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: const Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Group> list = groups.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
          ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final currentGroup = list[index];
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Group> list = groups.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
          ),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final currentGroup = list[index];
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
                    )
                  );
              }
          );
        },
      ),
    );
  }
  
}