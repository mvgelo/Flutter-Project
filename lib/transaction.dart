import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // rebuild when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tabs at the top
          TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            tabs: [
              Tab(text: "Daily"),
              Tab(text: "Calendar"),
              Tab(text: "Notes"),
            ],
          ),

          // Label below tabs, only for Daily tab
          if (_tabController.index == 0)
            Container(
              color: Colors.purple[200],
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Income: 0"),
                  Text("Expenses: 0"),
                  Text("Total: 0"),
                ],
              ),
            ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView(
                  children: [
                    ListTile(title: Text("Income")),
                    ListTile(title: Text("Expenses")),
                  ],
                ),
                Center(child: Text("Home Tab 3")),
                Center(child: Text("Home Tab 3")),
              ],
            ),
          ),

          // Button at the bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print("Button Pressed");
                },
                child: Text("Add Transaction"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
