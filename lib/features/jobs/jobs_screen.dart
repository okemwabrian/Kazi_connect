import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Jobs'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list_rounded)),
        ],
      ),
      body: Column(
        children: [
          _buildJobStats(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 10,
              itemBuilder: (context, index) {
                return _buildJobCard(context);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppTheme.emeraldGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Post a Job', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildJobStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppTheme.deepNavy,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatTile(label: 'Active Jobs', value: '45'),
          _StatTile(label: 'Near You', value: '12'),
          _StatTile(label: 'Applied', value: '3'),
        ],
      ),
    );
  }

  Widget _buildJobCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/job-details'),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.emeraldGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Full Time',
                      style: TextStyle(color: AppTheme.emeraldGreen, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text('2 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Experienced Nanny for 2 Kids',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
              ),
              const SizedBox(height: 8),
              const Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text('Runda, Nairobi', style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Salary Range', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('KSh 15k - 20k', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => context.push('/application-success'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text('Apply'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}
