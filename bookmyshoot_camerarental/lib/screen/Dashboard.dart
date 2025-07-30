import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/booking_service.dart';
import '../models/booking_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final BookingService _bookingService = BookingService();
  List<Booking> _recentBookings = [];
  Map<String, dynamic> _stats = {};

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  void _loadDashboardData() {
    setState(() {
      _recentBookings = _bookingService.getRecentBookings(limit: 10);
      _stats = _bookingService.getBookingStats();
    });
  }

  void _refreshDashboard() {
    _loadDashboardData();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Dashboard refreshed!'),
        backgroundColor: CinematicColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showBookingDetails(Booking booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CinematicColors.surface,
        title: Text(
          'Booking Details',
          style: const TextStyle(color: CinematicColors.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Customer', booking.customerName),
            _buildDetailRow('Equipment', booking.equipment.name),
            _buildDetailRow('Date & Time', booking.formattedDate),
            _buildDetailRow('Price', booking.formattedPrice),
            _buildDetailRow('Status', booking.status),
            if (booking.isOverdue) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: CinematicColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.warning,
                      color: CinematicColors.error,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'This booking is overdue',
                      style: const TextStyle(
                        color: CinematicColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: CinematicColors.secondary),
            ),
          ),
          if (booking.status == 'Pending')
            TextButton(
              onPressed: () {
                _updateBookingStatus(booking.id, 'Confirmed');
                Navigator.pop(context);
              },
              child: const Text(
                'Confirm',
                style: TextStyle(color: CinematicColors.success),
              ),
            ),
          if (booking.isActive)
            TextButton(
              onPressed: () {
                _updateBookingStatus(booking.id, 'Completed');
                Navigator.pop(context);
              },
              child: const Text(
                'Complete',
                style: TextStyle(color: CinematicColors.accent),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                color: CinematicColors.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: CinematicColors.onSurface),
            ),
          ),
        ],
      ),
    );
  }

  void _updateBookingStatus(String bookingId, String newStatus) {
    if (_bookingService.updateBookingStatus(bookingId, newStatus)) {
      _loadDashboardData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking status updated to $newStatus'),
          backgroundColor: CinematicColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to update booking status'),
          backgroundColor: CinematicColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  void _showValidationSummary() {
    final overdueBookings = _bookingService.getOverdueBookings();
    final pendingBookings = _bookingService.getBookingsByStatus('Pending');
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CinematicColors.surface,
        title: const Text(
          'Validation Summary',
          style: TextStyle(color: CinematicColors.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (overdueBookings.isNotEmpty) ...[
              _buildValidationItem(
                'Overdue Bookings',
                overdueBookings.length.toString(),
                CinematicColors.error,
                Icons.warning,
              ),
              const SizedBox(height: 8),
            ],
            if (pendingBookings.isNotEmpty) ...[
              _buildValidationItem(
                'Pending Bookings',
                pendingBookings.length.toString(),
                CinematicColors.warning,
                Icons.pending,
              ),
              const SizedBox(height: 8),
            ],
            if (overdueBookings.isEmpty && pendingBookings.isEmpty) ...[
              _buildValidationItem(
                'All Good!',
                'No issues found',
                CinematicColors.success,
                Icons.check_circle,
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(color: CinematicColors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationItem(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: color.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
              colors: CinematicColors.primaryGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshDashboard,
            tooltip: 'Refresh Dashboard',
          ),
          IconButton(
            icon: const Icon(Icons.verified, color: Colors.white),
            onPressed: _showValidationSummary,
            tooltip: 'Validation Summary',
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: CinematicColors.cinematicGradient,
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
              Row(
                children: [
                  const Text(
                    'Recent Bookings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_recentBookings.length} bookings',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
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
        onPressed: () async {
          await Navigator.pushNamed(context, '/rent');
          _loadDashboardData(); // Refresh after returning from booking creation
        },
        backgroundColor: CinematicColors.secondary,
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
            value: (_stats['totalBookings'] ?? 0).toString(),
            icon: Icons.calendar_today,
            color: CinematicColors.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Active Rentals',
            value: (_stats['activeBookings'] ?? 0).toString(),
            icon: Icons.camera_alt,
            color: CinematicColors.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Revenue',
            value: '₱${(_stats['totalRevenue'] ?? 0).toStringAsFixed(0)}',
            icon: Icons.attach_money,
            color: CinematicColors.highlight,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingsList() {
    if (_recentBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 64,
              color: Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              'No bookings yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create your first booking using the + button',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: _recentBookings.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[800],
        height: 1,
      ),
      itemBuilder: (context, index) {
        final booking = _recentBookings[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: const Color(0xFF242424),
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
                    Color(0xFF2C3E50),
                    Color(0xFF4CA1AF),
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
              booking.customerName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.equipment.name,
                  style: TextStyle(
                    color: Colors.grey[400],
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
                        color: _getStatusColor(booking.status)
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        booking.status,
                        style: TextStyle(
                          color: _getStatusColor(booking.status),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    if (booking.isOverdue) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: CinematicColors.error.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'OVERDUE',
                          style: TextStyle(
                            color: CinematicColors.error,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      booking.formattedDate,
                      style: TextStyle(
                        color: Colors.grey[500],
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
                  booking.formattedPrice,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE6B325),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFE6B325),
                ),
              ],
            ),
            onTap: () => _showBookingDetails(booking),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return CinematicColors.success;
      case 'Pending':
        return CinematicColors.warning;
      case 'Completed':
        return CinematicColors.accent;
      case 'Cancelled':
        return CinematicColors.error;
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
      color: const Color(0xFF242424),
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
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}