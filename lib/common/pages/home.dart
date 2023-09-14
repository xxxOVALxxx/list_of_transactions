import 'package:flutter/material.dart';
import 'package:list_of_transactions/features/transactions/presentation/pages/pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.money_rounded),
              label: 'Transactions',
            ),
            NavigationDestination(
              icon: Icon(Icons.donut_small),
              label: 'Donut',
            )
          ],
        ),
        body: const [TransactionsPage(), ChartsPage()][_currentPageIndex],
      ),
    );
  }
}
