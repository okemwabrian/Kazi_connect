import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(),
                  const SizedBox(height: 24),
                  _buildStats(),
                  const SizedBox(height: 32),
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'I am a professional house help with 5 years of experience in Nairobi. I specialize in cleaning, laundry, and basic cooking. I am reliable, hardworking, and have excellent references from previous employers.',
                    style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Work Gallery',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) => Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.image_outlined, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Skills',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildSkillChip('Deep Cleaning'),
                      _buildSkillChip('Laundry'),
                      _buildSkillChip('Ironing'),
                      _buildSkillChip('Cooking'),
                      _buildSkillChip('Child Care'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewItem(),
                  _buildReviewItem(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBottomAction(context),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppTheme.deepNavy),
            const Center(
              child: Icon(Icons.person, color: Colors.white, size: 100),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: const BackButton(color: Colors.white),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Colors.white)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border, color: Colors.white)),
      ],
    );
  }

  Widget _buildHeaderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mercy Wambui',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppTheme.emeraldGreen, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Kilimani, Nairobi',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.emeraldGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.verified, color: AppTheme.emeraldGreen, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'Verified',
                            style: TextStyle(color: AppTheme.emeraldGreen, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        const Column(
          children: [
            Text(
              'KSh 800',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.emeraldGreen),
            ),
            Text(
              '/ day',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem('Rating', '4.9', Icons.star_rounded, AppTheme.gold),
        _buildStatItem('Experience', '5 yrs', Icons.work_rounded, AppTheme.emeraldGreen),
        _buildStatItem('Jobs', '124', Icons.check_circle_rounded, AppTheme.deepNavy),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildReviewItem() {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.emeraldGreen,
                    child: Icon(Icons.person, color: Colors.white, size: 20),
                  ),
                  SizedBox(width: 12),
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alice Maina', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('2 weeks ago', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.star, color: AppTheme.gold, size: 16),
                    Icon(Icons.star, color: AppTheme.gold, size: 16),
                    Icon(Icons.star, color: AppTheme.gold, size: 16),
                    Icon(Icons.star, color: AppTheme.gold, size: 16),
                    Icon(Icons.star, color: AppTheme.gold, size: 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Mercy is very thorough with her work. She arrived on time and did an excellent job with the house cleaning.',
              style: TextStyle(color: Colors.grey.shade700, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_outlined, color: Colors.green),
                  label: const Text('WhatsApp'),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.green),
                    foregroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_outlined),
                  label: const Text('Call'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/chat-detail'),
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('Chat'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 56),
                    side: const BorderSide(color: AppTheme.emeraldGreen),
                    foregroundColor: AppTheme.emeraldGreen,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => context.push('/application-success'),
                  child: const Text('Hire Now'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
