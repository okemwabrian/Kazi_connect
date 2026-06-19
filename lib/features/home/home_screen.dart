import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme.dart';
import '../../core/constants.dart';
import 'home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCounty = ref.watch(selectedCountyProvider);
    final filteredWorkers = ref.watch(workersProvider);
    final filteredJobs = ref.watch(jobsProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, ref, selectedCounty),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                _buildSearchBar(context, ref, selectedCounty),
                const SizedBox(height: 24),
                _buildCategories(context),
                const SizedBox(height: 32),
                _buildFeaturedSection(context, filteredWorkers, selectedCounty),
                const SizedBox(height: 32),
                _buildRecommendedJobs(context, filteredJobs, selectedCounty),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, WidgetRef ref, String county) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KaziConnect',
            style: TextStyle(
              color: AppTheme.deepNavy,
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: -0.5,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on, color: AppTheme.emeraldGreen, size: 14),
              const SizedBox(width: 4),
              Text(
                '$county County',
                style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () => context.push('/notifications'),
          icon: Stack(
            children: [
              const Icon(Icons.notifications_none_rounded, color: AppTheme.deepNavy, size: 28),
              Positioned(
                right: 4,
                top: 4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, WidgetRef ref, String county) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // Location Dropdown
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showCountySelector(context, ref),
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.location_on, color: AppTheme.emeraldGreen, size: 18),
                        const SizedBox(width: 6),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 80),
                          child: Text(
                            county,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.deepNavy, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 18),
                      ],
                    ),
                  ),
                ),
              ),
              VerticalDivider(color: Colors.grey.shade200, indent: 12, endIndent: 12, width: 1),
              // Search Field

              Expanded(
                child: TextField(
                  onChanged: (value) => ref.read(searchQueryProvider.notifier).update(value),
                  decoration: InputDecoration(
                    hintText: 'Search workers, jobs...',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.deepNavy, size: 20),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
              // Filter Button
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.emeraldGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            itemCount: AppConstants.categories.length,
            itemBuilder: (context, index) {
              final cat = AppConstants.categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                  onTap: () => context.push('/category/${cat['name']}'),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                          ],
                        ),
                        child: Icon(_getIconData(cat['icon']), color: AppTheme.emeraldGreen, size: 28),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        cat['name'],
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.deepNavy),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSection(BuildContext context, List<Worker> workers, String county) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Rated in $county',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
              ),
              TextButton(onPressed: () {}, child: const Text('See All')),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (workers.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: Text('No workers found in this county.', style: TextStyle(color: Colors.grey))),
          )
        else
          SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];
                return GestureDetector(
                  onTap: () => context.push('/worker-profile'),
                  child: Container(
                    width: 170,
                    margin: const EdgeInsets.only(right: 16, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: AppTheme.emeraldGreen,
                            child: Icon(Icons.person, color: Colors.white, size: 45),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            worker.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            worker.category,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.star_rounded, color: AppTheme.gold, size: 18),
                              Text(
                                ' ${worker.rating}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                              Text(' (${worker.reviewCount})', style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context.push('/worker-profile'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 36),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text('View Profile', style: TextStyle(fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildRecommendedJobs(BuildContext context, List<Job> jobs, String county) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Recommended Jobs in $county',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
          ),
        ),
        const SizedBox(height: 16),
        if (jobs.isEmpty)
          const Padding(
            padding: EdgeInsets.all(40),
            child: Center(child: Text('No jobs posted in this county yet.', style: TextStyle(color: Colors.grey))),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return GestureDetector(
                  onTap: () => context.push('/job-details'),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.emeraldGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.business_center_rounded, color: AppTheme.emeraldGreen),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job.title,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.deepNavy),
                              ),
                              Text(
                                'Posted by: ${job.bureau}',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    job.salary,
                                    style: const TextStyle(color: AppTheme.emeraldGreen, fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      job.type,
                                      style: TextStyle(color: Colors.grey.shade700, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  void _showCountySelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                'Select Your County',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.deepNavy),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: AppConstants.kenyanCounties.length,
                itemBuilder: (context, index) {
                  final county = AppConstants.kenyanCounties[index];
                  final isSelected = ref.watch(selectedCountyProvider) == county;
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                      tileColor: isSelected ? AppTheme.emeraldGreen.withOpacity(0.05) : null,
                      title: Text(
                        county,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? AppTheme.emeraldGreen : AppTheme.deepNavy,
                        ),
                      ),
                      trailing: isSelected ? const Icon(Icons.check_circle, color: AppTheme.emeraldGreen) : null,
                      onTap: () {
                        ref.read(selectedCountyProvider.notifier).update(county);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'cleaning_services': return Icons.cleaning_services_rounded;
      case 'child_care': return Icons.child_care_rounded;
      case 'directions_car': return Icons.directions_car_rounded;
      case 'mop': return Icons.cleaning_services_rounded;
      case 'grass': return Icons.grass_rounded;
      case 'security': return Icons.security_rounded;
      case 'volunteer_activism': return Icons.volunteer_activism_rounded;
      default: return Icons.home_repair_service_rounded;
    }
  }
}

