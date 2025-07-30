import 'package:flutter/material.dart';
import '../models/camera_model.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';
import '../utils/theme.dart';

class RentEquipmentScreen extends StatefulWidget {
  const RentEquipmentScreen({super.key});

  @override
  State<RentEquipmentScreen> createState() => _RentEquipmentScreenState();
}

class _RentEquipmentScreenState extends State<RentEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();
  final _priceController = TextEditingController();
  
  Camera? _selectedEquipment;
  DateTime? _selectedDateTime;
  
  final List<Camera> _availableEquipment = const [
    Camera(
      id: 'cam1',
      name: 'Canon EOS R5',
      description: 'Professional mirrorless camera',
      price: 120.0,
      rating: 4.8,
      imageUrl: 'assets/canon_eos_r5.jpg',
      features: [
        '45MP Full-Frame CMOS Sensor',
        '8K RAW Video',
        'Dual Pixel CMOS AF II'
      ],
    ),
    Camera(
      id: 'cam2',
      name: 'Sony A7 IV',
      description: '33MP full-frame hybrid camera',
      price: 95.0,
      rating: 4.7,
      imageUrl: 'assets/sony_a7_iv.jpg',
      features: [
        '33MP Full-Frame Sensor',
        '4K 60p Video',
        'Real-time Eye AF'
      ],
    ),
    Camera(
      id: 'lens1',
      name: 'Canon RF 24-70mm f/2.8',
      description: 'Professional standard zoom lens',
      price: 65.0,
      rating: 4.9,
      imageUrl: 'assets/canon_rf_24_70mm.jpg',
      features: [
        'f/2.8 constant aperture',
        'Nano USM Motor',
        'Weather Sealed'
      ],
    ),
    Camera(
      id: 'acc1',
      name: 'Manfrotto Tripod',
      description: 'Professional camera tripod',
      price: 45.0,
      rating: 4.5,
      imageUrl: 'assets/logo.png',
      features: [
        'Carbon fiber',
        'Max height 160cm',
        'Load capacity 8kg'
      ],
    ),
    Camera(
      id: 'acc2',
      name: 'Godox V1 Flash',
      description: 'Round-head speedlight',
      price: 40.0,
      rating: 4.4,
      imageUrl: 'assets/logo.png',
      features: [
        'Round head for soft shadows',
        'Li-ion battery',
        '2.4G wireless system'
      ],
    ),
  ];

  final BookingService _bookingService = BookingService();

  @override
  void initState() {
    super.initState();
    // Set default price when equipment is selected
    _priceController.addListener(_updatePrice);
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _updatePrice() {
    if (_selectedEquipment != null) {
      setState(() {
        _priceController.text = _selectedEquipment!.price.toString();
      });
    }
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: CinematicColors.secondary,
              onPrimary: CinematicColors.onSecondary,
              surface: CinematicColors.surface,
              onSurface: CinematicColors.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(
                primary: CinematicColors.secondary,
                onPrimary: CinematicColors.onSecondary,
                surface: CinematicColors.surface,
                onSurface: CinematicColors.onSurface,
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _showEquipmentSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: CinematicColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: CinematicColors.primaryGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  const Text(
                    'Select Equipment',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CinematicColors.onPrimary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: CinematicColors.onPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _availableEquipment.length,
                itemBuilder: (context, index) {
                  final equipment = _availableEquipment[index];
                  final isSelected = _selectedEquipment?.id == equipment.id;
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: isSelected ? CinematicColors.secondary.withOpacity(0.1) : CinematicColors.surfaceVariant,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          equipment.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: CinematicColors.primaryGradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: CinematicColors.secondary,
                                size: 24,
                              ),
                            );
                          },
                        ),
                      ),
                      title: Text(
                        equipment.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CinematicColors.onSurface,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            equipment.description,
                            style: TextStyle(
                              color: CinematicColors.onSurface.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₱${equipment.price.toStringAsFixed(0)}/day',
                            style: const TextStyle(
                              color: CinematicColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: CinematicColors.secondary,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          _selectedEquipment = equipment;
                          _priceController.text = equipment.price.toString();
                        });
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

  void _createBooking() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final customerName = _customerNameController.text.trim();
    final price = double.tryParse(_priceController.text) ?? 0.0;

    // Validate all fields
    final validationErrors = _bookingService.validateBookingData(
      customerName: customerName,
      equipment: _selectedEquipment,
      dateTime: _selectedDateTime,
      price: price,
    );

    if (_bookingService.hasValidationErrors(validationErrors)) {
      final errorMessages = _bookingService.getValidationErrorMessages(validationErrors);
      _showValidationErrors(errorMessages);
      return;
    }

    // Check equipment availability
    if (!_bookingService.isEquipmentAvailable(_selectedEquipment!.id, _selectedDateTime!)) {
      _showValidationErrors(['Equipment is not available for the selected date and time']);
      return;
    }

    // Create booking
    final booking = Booking.createBooking(
      customerName: customerName,
      equipment: _selectedEquipment!,
      dateTime: _selectedDateTime!,
      price: price,
    );

    if (booking != null && _bookingService.addBooking(booking)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Booking created successfully!'),
          backgroundColor: CinematicColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      Navigator.pop(context);
    } else {
      _showValidationErrors(['Failed to create booking. Please try again.']);
    }
  }

  void _showValidationErrors(List<String> errors) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: CinematicColors.surface,
        title: const Text(
          'Validation Errors',
          style: TextStyle(color: CinematicColors.onSurface),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: errors.map((error) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '• $error',
              style: const TextStyle(color: CinematicColors.error),
            ),
          )).toList(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Booking',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Customer Name Field
                TextFormField(
                  controller: _customerNameController,
                  style: const TextStyle(color: CinematicColors.onSurface),
                  decoration: const InputDecoration(
                    labelText: 'Customer Name',
                    labelStyle: TextStyle(color: CinematicColors.onSurface),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: CinematicColors.surfaceVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: CinematicColors.secondary, width: 2),
                    ),
                    filled: true,
                    fillColor: CinematicColors.surfaceVariant,
                  ),
                  validator: (value) => Booking.validateCustomerName(value),
                ),
                const SizedBox(height: 16),

                // Equipment Selection
                InkWell(
                  onTap: _showEquipmentSelection,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CinematicColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedEquipment != null 
                            ? CinematicColors.secondary 
                            : CinematicColors.surfaceVariant,
                        width: _selectedEquipment != null ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: _selectedEquipment != null 
                              ? CinematicColors.secondary 
                              : CinematicColors.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedEquipment?.name ?? 'Select Equipment',
                                style: TextStyle(
                                  color: _selectedEquipment != null 
                                      ? CinematicColors.onSurface 
                                      : CinematicColors.onSurface.withOpacity(0.6),
                                  fontWeight: _selectedEquipment != null 
                                      ? FontWeight.bold 
                                      : FontWeight.normal,
                                ),
                              ),
                              if (_selectedEquipment != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  _selectedEquipment!.description,
                                  style: TextStyle(
                                    color: CinematicColors.onSurface.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: CinematicColors.onSurface.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_selectedEquipment == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      'Please select equipment',
                      style: TextStyle(
                        color: CinematicColors.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Date & Time Selection
                InkWell(
                  onTap: _selectDateTime,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CinematicColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedDateTime != null 
                            ? CinematicColors.secondary 
                            : CinematicColors.surfaceVariant,
                        width: _selectedDateTime != null ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: _selectedDateTime != null 
                              ? CinematicColors.secondary 
                              : CinematicColors.onSurface.withOpacity(0.6),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            _selectedDateTime != null 
                                ? _formatDateTime(_selectedDateTime!)
                                : 'Select Date & Time',
                            style: TextStyle(
                              color: _selectedDateTime != null 
                                  ? CinematicColors.onSurface 
                                  : CinematicColors.onSurface.withOpacity(0.6),
                              fontWeight: _selectedDateTime != null 
                                  ? FontWeight.bold 
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: CinematicColors.onSurface.withOpacity(0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_selectedDateTime == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: Text(
                      'Please select date and time',
                      style: TextStyle(
                        color: CinematicColors.error,
                        fontSize: 12,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Price Field
                TextFormField(
                  controller: _priceController,
                  style: const TextStyle(color: CinematicColors.onSurface),
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: CinematicColors.onSurface),
                    prefixText: '₱ ',
                    prefixStyle: TextStyle(color: CinematicColors.onSurface),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: CinematicColors.surfaceVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: CinematicColors.secondary, width: 2),
                    ),
                    filled: true,
                    fillColor: CinematicColors.surfaceVariant,
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => Booking.validatePrice(double.tryParse(value ?? '')),
                ),
                const SizedBox(height: 24),

                // Create Booking Button
                ElevatedButton(
                  onPressed: _createBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CinematicColors.secondary,
                    foregroundColor: CinematicColors.onSecondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: CinematicColors.secondary.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Create Booking',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${displayHour}:${minute.toString().padLeft(2, '0')} $period';
  }
}