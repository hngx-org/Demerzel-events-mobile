import '../classes/user.dart';

class AuthRepository {
  Future<User> signin () async{
    return User(id: 'id', avatar: 'avatar', email: 'email', name: 'name');
  }
  
}