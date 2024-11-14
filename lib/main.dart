import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loatodo_app/screens/home_screen.dart';
import 'package:loatodo_app/screens/todo_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
          routes: const [],
        ),
        GoRoute(
          path: '/todo',
          builder: (context, state) => TodoScreen(),
          routes: const [],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: '숙제'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '깐부'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '방명록'),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/todo')) return 1;
    if (location.startsWith('/friends')) return 2;
    if (location.startsWith('/guestbook')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/todo');
        break;
      case 2:
        context.go('/friends');
        break;
      case 3:
        context.go('/guestbook');
        break;
    }
  }
}
