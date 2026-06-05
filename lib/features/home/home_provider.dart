import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Using Notifier for Riverpod 3.0 compatibility
class SelectedCounty extends Notifier<String> {
  @override
  String build() => 'Nairobi';
  void update(String value) => state = value;
}

final selectedCountyProvider = NotifierProvider<SelectedCounty, String>(SelectedCounty.new);

class SearchQuery extends Notifier<String> {
  @override
  String build() => '';
  void update(String value) => state = value;
}

final searchQueryProvider = NotifierProvider<SearchQuery, String>(SearchQuery.new);

class Worker {
  final String name;
  final String category;
  final String county;
  final double rating;
  final int reviewCount;
  final String image;

  Worker({
    required this.name,
    required this.category,
    required this.county,
    required this.rating,
    required this.reviewCount,
    this.image = '',
  });
}

final workersProvider = Provider<List<Worker>>((ref) {
  final county = ref.watch(selectedCountyProvider);
  final search = ref.watch(searchQueryProvider).toLowerCase();

  final allWorkers = [
    Worker(name: 'Mercy Wambui', category: 'Househelp', county: 'Nairobi', rating: 4.9, reviewCount: 124),
    Worker(name: 'John Mutua', category: 'Driver', county: 'Mombasa', rating: 4.7, reviewCount: 89),
    Worker(name: 'Alice Kamau', category: 'Nanny', county: 'Nairobi', rating: 4.8, reviewCount: 56),
    Worker(name: 'David Omondi', category: 'Gardener', county: 'Kisumu', rating: 4.6, reviewCount: 34),
    Worker(name: 'Sarah Njeri', category: 'Househelp', county: 'Kiambu', rating: 4.9, reviewCount: 15),
    Worker(name: 'Peter Kiprop', category: 'Security', county: 'Nakuru', rating: 4.5, reviewCount: 67),
  ];

  return allWorkers.where((w) {
    final matchesCounty = w.county == county;
    final matchesSearch = w.name.toLowerCase().contains(search) ||
        w.category.toLowerCase().contains(search);
    return matchesCounty && (search.isEmpty || matchesSearch);
  }).toList();
});

class Job {
  final String title;
  final String bureau;
  final String county;
  final String salary;
  final String type;

  Job({
    required this.title,
    required this.bureau,
    required this.county,
    required this.salary,
    required this.type,
  });
}

final jobsProvider = Provider<List<Job>>((ref) {
  final county = ref.watch(selectedCountyProvider);

  final allJobs = [
    Job(title: 'Experienced Nanny', bureau: 'Elite Bureau', county: 'Nairobi', salary: 'KSh 25,000', type: 'Full Time'),
    Job(title: 'Professional Driver', bureau: 'Kazi Agencies', county: 'Mombasa', salary: 'KSh 35,000', type: 'Full Time'),
    Job(title: 'House Cleaner', bureau: 'CleanHomes Bureau', county: 'Nairobi', salary: 'KSh 15,000', type: 'Part Time'),
    Job(title: 'Gardener Needed', bureau: 'GreenScape Admin', county: 'Kisumu', salary: 'KSh 18,000', type: 'Monthly'),
  ];

  return allJobs.where((j) => j.county == county).toList();
});

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    this.isRead = false,
  });

  NotificationItem copyWith({bool? isRead}) {
    return NotificationItem(
      title: title,
      description: description,
      time: time,
      icon: icon,
      isRead: isRead ?? this.isRead,
    );
  }
}

class NotificationsNotifier extends Notifier<List<NotificationItem>> {
  @override
  List<NotificationItem> build() {
    return [
      NotificationItem(title: 'Application Status', description: 'Your application for House Help at Runda has been viewed.', time: '1h ago', icon: Icons.assignment_turned_in_outlined),
      NotificationItem(title: 'New Job Match', description: 'A new Driver job matching your profile was posted in Kilimani.', time: '2h ago', icon: Icons.work_outline),
      NotificationItem(title: 'Verification Success', description: 'Your ID verification has been successfully processed.', time: '3h ago', icon: Icons.verified_user_outlined),
      NotificationItem(title: 'Message Received', description: 'Sarah Kamau sent you a new message.', time: '4h ago', icon: Icons.chat_bubble_outline),
      NotificationItem(title: 'Payment Confirmed', description: 'Your payment for premium membership has been confirmed.', time: '5h ago', icon: Icons.payments_outlined),
      NotificationItem(title: 'Profile Viewed', description: '5 employers viewed your profile today.', time: '6h ago', icon: Icons.visibility_outlined),
      NotificationItem(title: 'System Update', description: 'We have updated our terms and conditions.', time: '7h ago', icon: Icons.info_outline),
      NotificationItem(title: 'Welcome!', description: 'Welcome to KaziConnect Kenya!', time: '8h ago', icon: Icons.handshake_outlined),
    ];
  }

  void markAllAsRead() {
    state = state.map((n) => n.copyWith(isRead: true)).toList();
  }
}

final notificationsProvider = NotifierProvider<NotificationsNotifier, List<NotificationItem>>(NotificationsNotifier.new);
