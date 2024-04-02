import '../model/user_model.dart';

abstract class LocaleStorageService {
  saveUser(UserModel user);
  Future<UserModel> readUser();
}