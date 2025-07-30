import 'camera_model.dart';

class Booking {
  final String id;
  final String customerName;
  final Camera equipment;
  final DateTime dateTime;
  final double price;
  final String status;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.customerName,
    required this.equipment,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.createdAt,
  });

  // Validation methods
  static String? validateCustomerName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Customer name is required';
    }
    if (name.trim().length < 2) {
      return 'Customer name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEquipment(Camera? equipment) {
    if (equipment == null) {
      return 'Please select equipment';
    }
    return null;
  }

  static String? validateDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Please select date and time';
    }
    if (dateTime.isBefore(DateTime.now())) {
      return 'Date and time cannot be in the past';
    }
    return null;
  }

  static String? validatePrice(double? price) {
    if (price == null || price <= 0) {
      return 'Price must be greater than 0';
    }
    return null;
  }

  // Create booking from form data
  static Booking? createBooking({
    required String customerName,
    required Camera equipment,
    required DateTime dateTime,
    required double price,
  }) {
    // Validate all fields
    final nameError = validateCustomerName(customerName);
    final equipmentError = validateEquipment(equipment);
    final dateTimeError = validateDateTime(dateTime);
    final priceError = validatePrice(price);

    if (nameError != null || equipmentError != null || 
        dateTimeError != null || priceError != null) {
      return null;
    }

    return Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: customerName.trim(),
      equipment: equipment,
      dateTime: dateTime,
      price: price,
      status: 'Pending',
      createdAt: DateTime.now(),
    );
  }

  // Convert to map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'equipmentId': equipment.id,
      'equipmentName': equipment.name,
      'dateTime': dateTime.toIso8601String(),
      'price': price,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from map
  factory Booking.fromMap(Map<String, dynamic> map, Camera equipment) {
    return Booking(
      id: map['id'],
      customerName: map['customerName'],
      equipment: equipment,
      dateTime: DateTime.parse(map['dateTime']),
      price: map['price'].toDouble(),
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // Get formatted date string
  String get formattedDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final bookingDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (bookingDate == today) {
      return 'Today, ${_formatTime(dateTime)}';
    } else if (bookingDate == tomorrow) {
      return 'Tomorrow, ${_formatTime(dateTime)}';
    } else {
      return '${_formatDate(dateTime)}, ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    return '${displayHour}:${minute.toString().padLeft(2, '0')} $period';
  }

  String _formatDate(DateTime dateTime) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}';
  }

  // Get formatted price
  String get formattedPrice => '₱${price.toStringAsFixed(0)}';

  // Check if booking is active (not completed or cancelled)
  bool get isActive => status == 'Confirmed' || status == 'Pending';

  // Check if booking is overdue
  bool get isOverdue {
    if (status == 'Completed' || status == 'Cancelled') return false;
    return dateTime.isBefore(DateTime.now());
  }
} 