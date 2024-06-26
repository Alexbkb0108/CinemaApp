import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  int getCurrentIndex( BuildContext context)  {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/':
        return 0;
      case '/popular':
        return 1;
      case '/favorites':
        return 2;
      default:
        return 0;
    }
  }

  void onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/popular');
        break;
      case 2:
        context.go('/favorites');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        currentIndex: getCurrentIndex(context),
        onTap: (value) {
          onItemTap(context, value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.movie_filter), label: 'Popular'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'favoritos'),
        ]);
  }
}
