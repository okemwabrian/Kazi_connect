import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import 'home_provider.dart';

class CategoryResultsScreen extends ConsumerWidget {
  final String category;

  const CategoryResultsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final county = ref.watch(selectedCountyProvider);
    // In a real app, we'd filter by category here too
    final workers = ref.watch(workersProvider).where((w) => w.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: workers.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                Text('No $category found in $county', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: workers.length,
            itemBuilder: (context, index) {
              final worker = workers[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundColor: AppTheme.emeraldGreen,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  title: Text(worker.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${worker.category} • ${worker.county}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: AppTheme.gold, size: 16),
                      Text(' ${worker.rating}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            },
          ),
    );
  }
}
