import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class EmployerDashboard extends StatelessWidget {
  const EmployerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employer Dashboard'),
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
            _buildWelcomeSection(),
            const SizedBox(height: 24),
            _buildStatsGrid(context),
            const SizedBox(height: 32),
            const Text(
              'Hiring Trends',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
            ),
            const SizedBox(height: 16),
            _buildLineChart(),
            const SizedBox(height: 32),
            const Text(
              'Worker Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
            ),
            const SizedBox(height: 16),
            _buildPieChart(),
            const SizedBox(height: 32),
            const Text(
              'Recent Activity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
            ),
            const SizedBox(height: 16),
            _buildRecentActivityList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, Sarah!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
        ),
        Text(
          'Here is your hiring summary for this month.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          label: 'Total Hires',
          value: '12',
          icon: Icons.people_alt,
          color: AppTheme.emeraldGreen,
          onTap: () => context.push('/my-workers'),
        ),
        _StatCard(
          label: 'Open Jobs',
          value: '4',
          icon: Icons.work,
          color: AppTheme.deepNavy,
          onTap: () => context.push('/my-jobs'),
        ),
        _StatCard(
          label: 'Applications',
          value: '28',
          icon: Icons.description,
          color: AppTheme.gold,
          onTap: () => context.push('/applications'),
        ),
        _StatCard(
          label: 'Avg. Rating',
          value: '4.8',
          icon: Icons.star,
          color: Colors.orange,
          onTap: () => context.push('/reviews'),
        ),
      ],
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(2.6, 2),
                FlSpot(4.9, 5),
                FlSpot(6.8, 3.1),
                FlSpot(8, 4),
                FlSpot(9.5, 3),
                FlSpot(11, 4),
              ],
              isCurved: true,
              color: AppTheme.emeraldGreen,
              barWidth: 4,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.emeraldGreen.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(value: 40, color: AppTheme.emeraldGreen, title: 'House Help', radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.white)),
            PieChartSectionData(value: 30, color: AppTheme.deepNavy, title: 'Nanny', radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.white)),
            PieChartSectionData(value: 15, color: AppTheme.gold, title: 'Driver', radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.white)),
            PieChartSectionData(value: 15, color: Colors.grey, title: 'Other', radius: 50, titleStyle: const TextStyle(fontSize: 10, color: Colors.white)),
          ],
          sectionsSpace: 2,
          centerSpaceRadius: 40,
        ),
      ),
    );
  }

  Widget _buildRecentActivityList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (ctx, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            onTap: () => context.push('/worker-profile'),
            leading: const CircleAvatar(
              backgroundColor: AppTheme.emeraldGreen,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: const Text('Application Received', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('Mercy Wambui applied for House Help position'),
            trailing: const Text('2h ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _StatCard({
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
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
