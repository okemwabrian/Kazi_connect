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
            _buildQuickStats(),
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
                TextButton(onPressed: () {}, child: const Text('View All')),
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
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(child: _StatBox(label: 'Total Workers', value: '450', icon: Icons.people_outline, color: AppTheme.emeraldGreen)),
        const SizedBox(width: 16),
        Expanded(child: _StatBox(label: 'Active Jobs', value: '124', icon: Icons.assignment_outlined, color: AppTheme.deepNavy)),
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
          barTouchData: BarTouchData(enabled: false),
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
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=10')),
            title: const Text('John Mutua', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('ID: 12345678 • Driver'),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(80, 36), padding: EdgeInsets.zero),
              child: const Text('Verify', style: TextStyle(fontSize: 12)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentJobs(BuildContext context) {
    return Column(
      children: List.generate(3, (index) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          onTap: () => context.push('/job-details'),
          leading: const Icon(Icons.work_outline, color: AppTheme.emeraldGreen),
          title: Text(['Nanny for 2 kids', 'Professional Driver', 'Compound Cleaner'][index]),
          subtitle: const Text('Posted by: Elite Agency'),
          trailing: const Icon(Icons.chevron_right),
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

  const _StatBox({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
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
    );
  }
}
