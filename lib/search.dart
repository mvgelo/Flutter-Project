import 'package:flutter/material.dart';

/// SearchDelegate for Daily Tab
class DailySearchDelegate extends SearchDelegate<String> {
  final List<String> dailyItems;

  DailySearchDelegate({required this.dailyItems});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // clear search
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // close search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Show results when user submits search
    final results = dailyItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results
          .map(
            (item) => ListTile(
              title: Text(item),
              onTap: () {
                close(context, item); // close and return selection
              },
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show suggestions while typing
    final suggestions = dailyItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map(
            (item) => ListTile(
              title: Text(item),
              onTap: () {
                query = item;
                showResults(context);
              },
            ),
          )
          .toList(),
    );
  }
}
