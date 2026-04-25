import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tipidbuddy/search.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _dailyItems = [
    'Salary',
    'Freelance',
    'Groceries',
    'Rent',
    'Utilities',
  ];

  // Notes list
  final List<String> _notes = [];

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

  // Function to show dialog to add a new note
  void _addNoteDialog() {
    String newNote = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newNote = value;
            },
            decoration: InputDecoration(hintText: 'Type your note here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newNote.isNotEmpty) {
                  setState(() {
                    _notes.add(newNote);
                  });
                }
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Search button
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Only show search for Daily tab (optional)
              if (_tabController.index == 0) {
                showSearch(
                  context: context,
                  delegate: DailySearchDelegate(dailyItems: _dailyItems),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs at the top
          TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent,
            indicatorColor: const Color(0xFFA5B4FC),
            unselectedLabelColor: Colors.white70,
            labelColor: Colors.white,
            tabs: const [
              Tab(text: "Daily"),
              Tab(text: "Calendar"),
              Tab(text: "Notes"),
            ],
          ),

          // Label below tabs, only for Daily tab
          if (_tabController.index == 0 ||
              _tabController.index == 1 ||
              _tabController.index == 2)
            Container(
              color: const Color(0xFF151C33),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Income: 0", style: TextStyle(color: Color(0xFF22C55E))),
                  Text("Expenses: 0", style: TextStyle(color: Color(0xFFEF4444))),
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
                  children: const [
                    ListTile(
                      leading: Icon(Icons.arrow_downward_rounded, color: Color(0xFF22C55E)),
                      title: Text("Income"),
                    ),
                    ListTile(
                      leading: Icon(Icons.arrow_upward_rounded, color: Color(0xFFEF4444)),
                      title: Text("Expenses"),
                    ),
                  ],
                ),
                TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: DateTime.now(),
                ),
                // Notes Tab
                Column(
                  children: [
                    Expanded(
                      child: _notes.isEmpty
                          ? const Center(child: Text('No notes yet'))
                          : ListView.builder(
                              itemCount: _notes.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: const Icon(Icons.note),
                                  title: Text(_notes[index]),
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Note'),
                          onPressed: _addNoteDialog,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Button at the bottom
          // Show button only on Daily (0) and Calendar (1) tabs
          if (_tabController.index == 0 || _tabController.index == 1)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Add Transaction Pressed");
                  },
                  child: const Text("Add Transaction"),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
