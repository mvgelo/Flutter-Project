import 'package:flutter/material.dart';
import 'package:tipidbuddy/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1020),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomeTab(), StatsPage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Stats',
          ),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'About'),
        ],
      ),
    );
  }
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  static const List<_MonthlyStat> _rows = [
    _MonthlyStat('Jan', 42000, 28000),
    _MonthlyStat('Feb', 38000, 25000),
    _MonthlyStat('Mar', 45000, 29500),
    _MonthlyStat('Apr', 47000, 31000),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Stats',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _buildGraphCard(context),
            const SizedBox(height: 16),
            _buildMonthlyTable(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphCard(BuildContext context) {
    final maxValue = _rows
        .map((entry) => entry.income > entry.expenses ? entry.income : entry.expenses)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income vs Expenses',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 180,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _rows
                    .map((entry) => Expanded(
                          child: _MonthBars(entry: entry, maxValue: maxValue),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                _LegendDot(color: Color(0xFF22C55E), label: 'Income'),
                SizedBox(width: 14),
                _LegendDot(color: Color(0xFFEF4444), label: 'Expenses'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyTable(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(12),
        child: DataTable(
          headingTextStyle: textTheme.titleSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          columns: const [
            DataColumn(label: Text('Month')),
            DataColumn(label: Text('Income')),
            DataColumn(label: Text('Expenses')),
            DataColumn(label: Text('Total')),
          ],
          rows: _rows
              .map(
                (entry) => DataRow(
                  cells: [
                    DataCell(Text(entry.month)),
                    DataCell(Text('₱${entry.income.toStringAsFixed(0)}')),
                    DataCell(Text('₱${entry.expenses.toStringAsFixed(0)}')),
                    DataCell(
                      Text(
                        '₱${entry.total.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            _AboutItem(
              icon: Icons.help_outline_rounded,
              title: 'Help',
              subtitle: 'Learn how to add and review your transactions.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.settings_suggest_outlined,
              title: 'Configuration / Settings',
              subtitle: 'Customize currency, notifications, and display options.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Recommendation',
              subtitle: 'Get practical tips to improve savings and budget control.',
            ),
            SizedBox(height: 12),
            _AboutItem(
              icon: Icons.workspace_premium_outlined,
              title: 'Credits',
              subtitle: 'Built by TipidBuddy Team with Flutter.',
            ),
          ],
        ),
      ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AboutItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF151C33),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFA5B4FC)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

class _MonthBars extends StatelessWidget {
  final _MonthlyStat entry;
  final double maxValue;

  const _MonthBars({required this.entry, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    final incomeRatio = entry.income / maxValue;
    final expenseRatio = entry.expenses / maxValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: 130 * incomeRatio,
                decoration: BoxDecoration(
                  color: const Color(0xFF22C55E),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 12,
                height: 130 * expenseRatio,
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(entry.month),
      ],
    );
  }
}

class _MonthlyStat {
  final String month;
  final double income;
  final double expenses;

  const _MonthlyStat(this.month, this.income, this.expenses);

  double get total => income - expenses;
}
