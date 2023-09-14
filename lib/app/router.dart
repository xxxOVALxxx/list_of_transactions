import 'package:go_router/go_router.dart';
import 'package:list_of_transactions/common/pages/home.dart';
import 'package:list_of_transactions/features/users/presentation/pages/login_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomePage())
  ],
);
