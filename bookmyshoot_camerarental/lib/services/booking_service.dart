import '../models/booking_model.dart';
import '../models/camera_model.dart';

class BookingService {
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  
  // In-memory storage for bookings (in a real app, this would be a database)
  final List<Booking> _bookings = [];

  // Initialize with sample data
  BookingService._internal() {
    _initializeSampleData();
  }

  void _initializeSampleData() {
    // Sample equipment data
    final sampleEquipment = [
      Camera(
        id: 'cam1',
        name: 'Canon EOS R5',
        description: 'Professional mirrorless camera',
        price: 120.0,
        rating: 4.8,
        imageUrl: 'assets/canon_eos_r5.jpg',
        features: ['45MP Full-Frame CMOS Sensor', '8K RAW Video', 'Dual Pixel CMOS AF II'],
      ),
      Camera(
        id: 'cam2',
        name: 'Sony A7 IV',
        description: '33MP full-frame hybrid camera',
        price: 95.0,
        rating: 4.7,
        imageUrl: 'assets/sony_a7_iv.jpg',
        features: ['33MP Full-Frame Sensor', '4K 60p Video', 'Real-time Eye AF'],
      ),
      Camera(
        id: 'lens1',
        name: 'Canon RF 24-70mm f/2.8',
        description: 'Professional standard zoom lens',
        price: 65.0,
        rating: 4.9,
        imageUrl: 'assets/canon_rf_24_70mm.jpg',
        features: ['f/2.8 constant aperture', 'Nano USM Motor', 'Weather Sealed'],
      ),
    ];

    // Sample bookings
    final now = DateTime.now();
    final sampleBookings = [
      Booking(
        id: '1',
        customerName: 'Daniel De Asis',
        equipment: sampleEquipment[0], // Canon EOS R5
        dateTime: now.add(const Duration(days: 1, hours: 2)),
        price: 120.0,
        status: 'Confirmed',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      Booking(
        id: '2',
        customerName: 'daniel',
        equipment: sampleEquipment[1], // Sony A7 IV
        dateTime: now.add(const Duration(days: 2, hours: 10)),
        price: 95.0,
        status: 'Pending',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      Booking(
        id: '3',
        customerName: 'Zilong',
        equipment: sampleEquipment[2], // Canon RF 24-70mm
        dateTime: now.subtract(const Duration(hours: 4)), // Overdue booking
        price: 65.0,
        status: 'Confirmed',
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      Booking(
        id: '4',
        customerName: 'Pharsa',
        equipment: sampleEquipment[0], // Canon EOS R5
        dateTime: now.subtract(const Duration(days: 1)),
        price: 120.0,
        status: 'Completed',
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ];

    _bookings.addAll(sampleBookings);
  }

  // Get all bookings
  List<Booking> getAllBookings() {
    return List.from(_bookings);
  }

  // Get active bookings (not completed or cancelled)
  List<Booking> getActiveBookings() {
    return _bookings.where((booking) => booking.isActive).toList();
  }

  // Get bookings by status
  List<Booking> getBookingsByStatus(String status) {
    return _bookings.where((booking) => booking.status == status).toList();
  }

  // Get overdue bookings
  List<Booking> getOverdueBookings() {
    return _bookings.where((booking) => booking.isOverdue).toList();
  }

  // Add a new booking
  bool addBooking(Booking booking) {
    try {
      _bookings.add(booking);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Update booking status
  bool updateBookingStatus(String bookingId, String newStatus) {
    try {
      final bookingIndex = _bookings.indexWhere((b) => b.id == bookingId);
      if (bookingIndex != -1) {
        final oldBooking = _bookings[bookingIndex];
        final updatedBooking = Booking(
          id: oldBooking.id,
          customerName: oldBooking.customerName,
          equipment: oldBooking.equipment,
          dateTime: oldBooking.dateTime,
          price: oldBooking.price,
          status: newStatus,
          createdAt: oldBooking.createdAt,
        );
        _bookings[bookingIndex] = updatedBooking;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Delete a booking
  bool deleteBooking(String bookingId) {
    try {
      final initialLength = _bookings.length;
      _bookings.removeWhere((b) => b.id == bookingId);
      return _bookings.length < initialLength;
    } catch (e) {
      return false;
    }
  }

  // Get booking statistics
  Map<String, dynamic> getBookingStats() {
    final totalBookings = _bookings.length;
    final activeBookings = getActiveBookings().length;
    final pendingBookings = getBookingsByStatus('Pending').length;
    final confirmedBookings = getBookingsByStatus('Confirmed').length;
    final completedBookings = getBookingsByStatus('Completed').length;
    final overdueBookings = getOverdueBookings().length;

    // Calculate total revenue
    final totalRevenue = _bookings
        .where((b) => b.status == 'Completed')
        .fold(0.0, (sum, booking) => sum + booking.price);

    return {
      'totalBookings': totalBookings,
      'activeBookings': activeBookings,
      'pendingBookings': pendingBookings,
      'confirmedBookings': confirmedBookings,
      'completedBookings': completedBookings,
      'overdueBookings': overdueBookings,
      'totalRevenue': totalRevenue,
    };
  }

  // Check if equipment is available for a specific date/time
  bool isEquipmentAvailable(String equipmentId, DateTime dateTime) {
    final conflictingBookings = _bookings.where((booking) {
      if (booking.equipment.id != equipmentId) return false;
      if (booking.status == 'Completed' || booking.status == 'Cancelled') return false;
      
      // Check if the booking time overlaps with the requested time
      // For simplicity, we'll consider a 2-hour rental period
      final bookingStart = booking.dateTime;
      final bookingEnd = bookingStart.add(const Duration(hours: 2));
      final requestedStart = dateTime;
      final requestedEnd = requestedStart.add(const Duration(hours: 2));
      
      return (requestedStart.isBefore(bookingEnd) && requestedEnd.isAfter(bookingStart));
    });
    
    return conflictingBookings.isEmpty;
  }

  // Get recent bookings (last 10)
  List<Booking> getRecentBookings({int limit = 10}) {
    final sortedBookings = List<Booking>.from(_bookings)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return sortedBookings.take(limit).toList();
  }

  // Validate booking data
  Map<String, String?> validateBookingData({
    required String customerName,
    required Camera? equipment,
    required DateTime? dateTime,
    required double? price,
  }) {
    return {
      'customerName': Booking.validateCustomerName(customerName),
      'equipment': Booking.validateEquipment(equipment),
      'dateTime': Booking.validateDateTime(dateTime),
      'price': Booking.validatePrice(price),
    };
  }

  // Check if there are any validation errors
  bool hasValidationErrors(Map<String, String?> errors) {
    return errors.values.any((error) => error != null);
  }

  // Get validation error messages
  List<String> getValidationErrorMessages(Map<String, String?> errors) {
    return errors.values.where((error) => error != null).cast<String>().toList();
  }
} 