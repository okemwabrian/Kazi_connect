import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class BureauDashboard extends StatelessWidget {
  const BureauDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Bureau Management'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickStats(context),
            const SizedBox(height: 32),
            const Text(
              'Revenue Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
            ),
            const SizedBox(height: 16),
            _buildBarChart(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pending Verifications',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Navigating to all verifications...')),
                    );
                  },
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildPendingVerifications(context),
            const SizedBox(height: 32),
            const Text(
              'Recent Job Postings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
            ),
            const SizedBox(height: 16),
            _buildRecentJobs(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Opening Job Posting form...')),
          );
        },
        backgroundColor: AppTheme.emeraldGreen,
        icon: const Icon(Icons.add),
        label: const Text('Post New Job'),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatBox(
            label: 'Total Workers',
            value: '450',
            icon: Icons.people_outline,
            color: AppTheme.emeraldGreen,
            onTap: () => context.push('/saved-workers'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatBox(
            label: 'Active Jobs',
            value: '124',
            icon: Icons.assignment_outlined,
            color: AppTheme.deepNavy,
            onTap: () => context.push('/main'),
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 20,
          barTouchData: BarTouchData(enabled: true),
          titlesData: const FlTitlesData(show: false),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: AppTheme.emeraldGreen, width: 16)]),
            BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: AppTheme.deepNavy, width: 16)]),
            BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: AppTheme.emeraldGreen, width: 16)]),
            BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: AppTheme.gold, width: 16)]),
            BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: AppTheme.emeraldGreen, width: 16)]),
            BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 10, color: AppTheme.deepNavy, width: 16)]),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingVerifications(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (ctx, index) {
        final names = ['John Mutua', 'Sarah Juma'];
        final roles = ['Driver', 'House Help'];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            onTap: () => context.push('/worker-profile'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=${index + 20}'),
            ),
            title: Text(names[index], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('ID: 1234567${index} • ${roles[index]}'),
            trailing: ElevatedButton(
              onPressed: () {
                _showVerifyDialog(context, names[index]);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.emeraldGreen,
                foregroundColor: Colors.white,
                minimumSize: const Size(80, 36),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Verify', style: TextStyle(fontSize: 12)),
            ),
          ),
        );
      },
    );
  }

  void _showVerifyDialog(BuildContext context, String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Verify Worker'),
        content: Text('Are you sure you want to verify $name? This will allow them to apply for premium jobs.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$name has been verified successfully!')),
              );
            },
            child: const Text('Verify'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentJobs(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          onTap: () => context.push('/job-details'),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.emeraldGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.work_outline, color: AppTheme.emeraldGreen),
          ),
          title: Text(['Nanny for 2 kids', 'Professional Driver', 'Compound Cleaner'][index]),
          subtitle: const Text('Posted by: Elite Agency'),
          trailing: const Icon(Icons.chevron_right, size: 18),
        ),
      )),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatBox({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color),
              ),
              const SizedBox(height: 16),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.deepNavy)),
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
