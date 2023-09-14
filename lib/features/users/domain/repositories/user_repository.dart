import 'package:hive/hive.dart';
import 'package:list_of_transactions/features/users/domain/entities/user.dart';

abstract interface class UserRepository {
  Future<User?> fetchUser(String id);
}

class LocalUserRepository implements UserRepository {
  LocalUserRepository._internal(this._box);

  final Box<User> _box;

  @override
  Future<User?> fetchUser(String id) async {
    return _box.get(id);
  }
}

class HiveUserRepositoryConnector {
  static Future<LocalUserRepository> connect() async {
    return LocalUserRepository._internal(await Hive.openBox<User>('users'));
  }
}
