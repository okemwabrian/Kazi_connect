import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import 'application_success_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJobHeader(),
            const Divider(height: 1),
            _buildJobInfo(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Job Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'We are looking for an experienced nanny to take care of our two children (ages 3 and 5). The ideal candidate should be patient, energetic, and have previous experience working with toddlers. Responsibilities include preparing meals, engaging in educational play, and light housekeeping related to the children.',
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Requirements',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  SizedBox(height: 12),
                  _RequirementItem(text: 'Minimum 3 years experience'),
                  _RequirementItem(text: 'First Aid certification preferred'),
                  _RequirementItem(text: 'Excellent references'),
                  _RequirementItem(text: 'Fluent in English and Swahili'),
                  SizedBox(height: 32),
                  Text(
                    'Similar Jobs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                ],
              ),
            ),
            _buildSimilarJobs(),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: _buildBottomAction(context),
    );
  }

  Widget _buildJobHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              const SizedBox(width: 12),
              const Text('2 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Experienced Nanny for 2 Kids',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: AppTheme.deepNavy,
                child: Icon(Icons.person, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sarah Kamau', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Individual Employer', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobInfo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _InfoTile(label: 'Salary', value: 'KSh 20k', icon: Icons.payments_outlined),
          _InfoTile(label: 'Location', value: 'Runda', icon: Icons.location_on_outlined),
          _InfoTile(label: 'Duration', value: 'Monthly', icon: Icons.calendar_today_outlined),
        ],
      ),
    );
  }

  Widget _buildSimilarJobs() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20, top: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('House Help Needed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const Text('Kilimani, Nairobi', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('KSh 15,000', style: TextStyle(color: AppTheme.emeraldGreen, fontWeight: FontWeight.bold)),
                        TextButton(onPressed: () {}, child: const Text('View')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Job saved to your profile')),
                );
              },
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 56)),
              child: const Text('Save Job'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => context.push('/application-success'),
              child: const Text('Apply Now'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoTile({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppTheme.emeraldGreen),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  const _RequirementItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppTheme.emeraldGreen, size: 18),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
