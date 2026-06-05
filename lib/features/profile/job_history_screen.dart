import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../shared/widgets.dart';

class JobHistoryScreen extends StatelessWidget {
  const JobHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job History')),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHistoryItem(
                  title: 'House Cleaning',
                  bureau: 'CleanHomes Bureau',
                  date: '12 June 2024',
                  status: 'Completed',
                  amount: 'KSh 1,500',
                  statusColor: AppTheme.emeraldGreen,
                ),
                _buildHistoryItem(
                  title: 'Professional Nanny',
                  bureau: 'Elite Agency',
                  date: '05 June 2024',
                  status: 'In Progress',
                  amount: 'KSh 25,000',
                  statusColor: AppTheme.gold,
                ),
                _buildHistoryItem(
                  title: 'Garden Maintenance',
                  bureau: 'GreenScape',
                  date: '28 May 2024',
                  status: 'Cancelled',
                  amount: 'KSh 2,000',
                  statusColor: Colors.red,
                ),
                _buildHistoryItem(
                  title: 'Laundry Service',
                  bureau: 'QuickWash',
                  date: '20 May 2024',
                  status: 'Completed',
                  amount: 'KSh 800',
                  statusColor: AppTheme.emeraldGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String title,
    required String bureau,
    required String date,
    required String status,
    required String amount,
    required Color statusColor,
  }) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.deepNavy.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.work_history_rounded, color: AppTheme.deepNavy),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(bureau, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.emeraldGreen)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  status,
                  style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
