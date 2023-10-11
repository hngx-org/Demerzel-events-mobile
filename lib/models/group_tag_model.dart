class GroupTagModel {
  final String name;
  final int id;

  GroupTagModel({required this.name, required this.id});

  GroupTagModel.fromJson(Map data):
  name= data["title"],
  id= data['id'];  

  GroupTagModel.custom():
  id= 30,
  name = 'tech';
}
