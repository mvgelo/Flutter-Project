import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tipidbuddy/search.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _dailyItems = [
    'Salary',
    'Freelance',
    'Groceries',
    'Rent',
    'Utilities',
  ];

  final List<String> _notes = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addNoteDialog() {
    String newNote = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Note'),
          content: TextField(
            autofocus: true,
            onChanged: (value) {
              newNote = value;
            },
            decoration: const InputDecoration(hintText: 'Type your note here'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
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
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            _SectionHeader(
              title: 'Transactions',
              subtitle: 'Manage daily entries, calendar, and notes.',
              icon: Icons.receipt_long_outlined,
              trailing: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  if (_tabController.index == 0) {
                    showSearch(
                      context: context,
                      delegate: DailySearchDelegate(dailyItems: _dailyItems),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            TabBar(
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicatorColor: const Color(0xFFA5B4FC),
              unselectedLabelColor: Colors.white70,
              labelColor: Colors.white,
              tabs: const [
                Tab(text: 'Daily'),
                Tab(text: 'Calendar'),
                Tab(text: 'Notes'),
              ],
            ),
            Container(
              color: const Color(0xFF151C33),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              width: double.infinity,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Income: 0', style: TextStyle(color: Color(0xFF22C55E))),
                  Text('Expenses: 0', style: TextStyle(color: Color(0xFFEF4444))),
                  Text('Total: 0'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    children: const [
                      ListTile(
                        leading: Icon(
                          Icons.arrow_downward_rounded,
                          color: Color(0xFF22C55E),
                        ),
                        title: Text('Income'),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.arrow_upward_rounded,
                          color: Color(0xFFEF4444),
                        ),
                        title: Text('Expenses'),
                      ),
                    ],
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: DateTime.now(),
                  ),
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
                        padding: const EdgeInsets.all(8),
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
            if (_tabController.index == 0 || _tabController.index == 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 8, top: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint('Add Transaction Pressed');
                    },
                    child: const Text('Add Transaction'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2745),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFA5B4FC)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
