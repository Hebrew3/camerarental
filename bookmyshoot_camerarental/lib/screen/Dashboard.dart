import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BookMyShoot Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF121212),  // Dark background
                Color(0xFF242424),  // Slightly lighter dark
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF121212),  // Dark background
              Color(0xFF1E1E1E),  // Slightly lighter dark
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with stats
              _buildStatsRow(),
              const SizedBox(height: 24),
              // Recent bookings title
              const Text(
                'Recent Bookings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,  // White text for better contrast
                ),
              ),
              const SizedBox(height: 16),
              // Bookings list
              Expanded(
                child: _buildBookingsList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/rent'),
        backgroundColor: const Color(0xFFE6B325),  // Gold accent color
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _StatCard(
            title: 'Total Bookings',
            value: '24',
            icon: Icons.calendar_today,
            color: const Color(0xFFE6B325),  // Gold
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Active Rentals',
            value: '5',
            icon: Icons.camera_alt,
            color: const Color(0xFF4ECDC4),  // Teal
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Revenue',
            value: '\$1,240',
            icon: Icons.attach_money,
            color: const Color(0xFFFF6B6B),  // Coral
          ),
        ),
      ],
    );
  }

  Widget _buildBookingsList() {
    final bookings = [
      {
        'name': 'John Doe', 
        'gear': 'Canon EOS R5', 
        'date': 'Today, 2:00 PM',
        'status': 'Confirmed',
        'amount': '\$250'
      },
      {
        'name': 'Jane Smith', 
        'gear': 'Sony A7IV', 
        'date': 'Tomorrow, 10:00 AM',
        'status': 'Pending',
        'amount': '\$180'
      },
      {
        'name': 'Mike Johnson', 
        'gear': 'Full Lighting Kit', 
        'date': 'Jun 15, 1:30 PM',
        'status': 'Completed',
        'amount': '\$350'
      },
    ];

    return ListView.separated(
      itemCount: bookings.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[800],  // Darker divider
        height: 1,
      ),
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: const Color(0xFF242424),  // Dark card background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2C3E50),  // Dark blue-gray
                    Color(0xFF4CA1AF),  // Teal
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(
              booking['name']!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,  // White text
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking['gear']!,
                  style: TextStyle(
                    color: Colors.grey[400],  // Lighter gray
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking['status']!)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        booking['status']!,
                        style: TextStyle(
                          color: _getStatusColor(booking['status']!),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      booking['date']!,
                      style: TextStyle(
                        color: Colors.grey[500],  // Medium gray
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  booking['amount']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6B325),  // Gold
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFE6B325),  // Gold
                ),
              ],
            ),
            onTap: () {
              // Navigate to booking details
            },
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return const Color(0xFF4ECDC4);  // Teal
      case 'Pending':
        return const Color(0xFFE6B325);  // Gold
      case 'Completed':
        return const Color(0xFFA5D8FF);  // Light blue
      default:
        return Colors.grey;
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: const Color(0xFF242424),  // Dark card background
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],  // Lighter gray
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}