import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../shared/widgets.dart';

class SavedWorkersScreen extends StatelessWidget {
  const SavedWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Workers')),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildSavedWorker(
                  context,
                  name: 'Mercy Wambui',
                  category: 'Househelp',
                  rating: '4.9',
                  location: 'Kilimani, Nairobi',
                ),
                _buildSavedWorker(
                  context,
                  name: 'Alice Kamau',
                  category: 'Nanny',
                  rating: '4.8',
                  location: 'Westlands, Nairobi',
                ),
                _buildSavedWorker(
                  context,
                  name: 'David Omondi',
                  category: 'Gardener',
                  rating: '4.6',
                  location: 'Runda, Nairobi',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSavedWorker(
    BuildContext context, {
    required String name,
    required String category,
    required String rating,
    required String location,
  }) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () => context.push('/worker-profile'),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: AppTheme.emeraldGreen,
              child: Icon(Icons.person, color: Colors.white, size: 35),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(category, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.emeraldGreen, size: 12),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppTheme.gold, size: 18),
                    Text(rating, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Icon(Icons.favorite, color: Colors.red, size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
