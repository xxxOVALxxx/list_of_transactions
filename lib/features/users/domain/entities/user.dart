import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 5)
class User {
  User(this.login, this.password);

  @HiveField(0)
  final String login;
  @HiveField(1)
  final String password;
}
