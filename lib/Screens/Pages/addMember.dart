import 'package:ccm/Models/supporter.dart';
import 'package:ccm/Providers/supporterProvider.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:phone_number/phone_number.dart';
import '../Tabs/home.dart';

// Model class for supporter data
class SupporterData {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String gender;
  final String promised;
  final String details;

  SupporterData({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.promised,
    required this.details,
  });

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'gender': gender,
    'promised': promised,
    'details': details,
  };
}

class AddSupporter extends StatefulWidget {
  const AddSupporter({Key? key}) : super(key: key);

  @override
  State<AddSupporter> createState() => _AddSupporterState();
}

class _AddSupporterState extends State<AddSupporter> {
  // Constants
  static const _backgroundColor = Color(0xff009b65);
  static const _gradientColors = [Color(0xff009b65), Color(0xff0d1018)];
  late SupporterProvider _supporterProvider;

  // Controllers
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _detailsController = TextEditingController();
  final _phoneNumberUtil = PhoneNumberUtil();

  // State variables
  String _selectedGender = '';
  String _promised = '';
  bool _isLoading = false;
  bool _hasFormError = false;

  @override
  void didChangeDependencies() {
   _supporterProvider = Provider.of<SupporterProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            _buildBackground(),
            _buildForm(),
            if (_isLoading) _buildLoadingOverlay(),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_hasUnsavedChanges()) {
      return await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text('Discard Changes?'),
              content: const Text(
                  'You have unsaved changes. Are you sure you want to discard them?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Discard'),
                ),
              ],
            ),
      ) ?? false;
    }
    return true;
  }

  bool _hasUnsavedChanges() {
    return _firstNameController.text.isNotEmpty ||
        _lastNameController.text.isNotEmpty ||
        _phoneNumberController.text.isNotEmpty ||
        _detailsController.text.isNotEmpty ||
        _selectedGender.isNotEmpty ||
        _promised.isNotEmpty;
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: const Text("Add Supporter", style: TextStyle(color: Colors.white)),
      backgroundColor: _backgroundColor,
      elevation: 0,
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _gradientColors,
        ),
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black54,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() => _hasFormError = false);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_hasFormError)
                  _buildErrorBanner(),
                _buildSectionTitle("Supporter Details"),
                const SizedBox(height: 16),
                _buildPersonalInfoFields(),
                const SizedBox(height: 24),
                _buildAdditionalInfoSection(),
                const SizedBox(height: 32),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Please correct the errors in the form',
        style: TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.yellow,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildPersonalInfoFields() {
    return Column(
      children: [
        _buildTextField(
          controller: _firstNameController,
          hintText: "First Name",
          icon: Icons.person,
          validator: _validateName,
        ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _lastNameController,
          hintText: "Last Name",
          icon: Icons.person,
          validator: _validateName,
        ),
        const SizedBox(height: 16),
        _buildPhoneNumberField(),
      ],
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters';
    }
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.yellow),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 16),
      ),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Widget _buildPhoneNumberField() {
    return TextFormField(
      controller: _phoneNumberController,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "Phone Number",
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        prefixIcon: const Icon(Icons.phone, color: Colors.white),
        suffixIcon: IconButton(
          icon: const Icon(Icons.contact_phone, color: Colors.white),
          onPressed: _pickContactNumber,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.yellow),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 16),
      ),
      validator: _validatePhoneNumber,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }

    final cleanNumber = value.replaceAll(RegExp(r'\D'), '');
    if (cleanNumber.length < 10 || cleanNumber.length > 15) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  Widget _buildAdditionalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle("Additional Information"),
        const SizedBox(height: 16),
        _buildSelectionContainer(
          title: "Gender",
          isValid: _selectedGender.isNotEmpty,
          child: Row(
            children: [
              _buildRadioButton("Male", "Male"),
              const SizedBox(width: 16),
              _buildRadioButton("Female", "Female"),
            ],
          ),
        ),
        if (_selectedGender.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 12),
            child: Text(
              'Please select a gender',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 16),
        _buildSelectionContainer(
          title: "Promised",
          isValid: _promised.isNotEmpty,
          child: Row(
            children: [
              _buildRadioButton("Yes", "Yes", isPromised: true),
              const SizedBox(width: 16),
              _buildRadioButton("No", "No", isPromised: true),
            ],
          ),
        ),
        if (_promised.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 8, left: 12),
            child: Text(
              'Please select an option',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        const SizedBox(height: 16),
        _buildTextField(
          controller: _detailsController,
          hintText: "Other Details (Optional)",
          icon: Icons.note,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildSelectionContainer({
    required String title,
    required Widget child,
    required bool isValid,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isValid ? Colors.white : Colors.red,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title, style: const TextStyle(color: Colors.white, fontSize: 16)),
          child,
        ],
      ),
    );
  }

  Widget _buildRadioButton(String value, String label,
      {bool isPromised = false}) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: isPromised ? _promised : _selectedGender,
          onChanged: (String? newValue) {
            setState(() {
              if (isPromised) {
                _promised = newValue!;
              } else {
                _selectedGender = newValue!;
              }
            });
          },
          activeColor: Colors.yellow,
        ),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: _backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: _isLoading ? null : _submitForm,
      child: const Text(
        "Add Supporter",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_validateForm()) {
      setState(() => _hasFormError = true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Create supporter data object
      final supporterData = SupporterData(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        gender: _selectedGender,
        promised: _promised,
        details: _detailsController.text.trim(),
      );

      // Validate phone number format
      bool isPhoneValid = await isValidPhoneNumber(supporterData.phoneNumber);
      if (!isPhoneValid) {
        _showErrorDialog('Please enter a valid phone number');
        return;
      }

String message = await _supporterProvider.addSupporter(supporter: Supporter(
  first_name: _firstNameController.text.trim(),
  last_name: _lastNameController.text.trim(),
  phone_number: _phoneNumberController.text.trim(),
  gender: _selectedGender,
  promised: _promised == 'Yes' ? 1 : 0,
  other_supporter_details: _detailsController.text.trim(),
));

      if(_supporterProvider.supporterAdded){
        // Handle success
        _showSuccessDialog();
      }else{
        _showErrorDialog(message);
      }

    } catch (e) {
      _showErrorDialog('Failed to add supporter: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _validateForm() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return false;
    }

    if (_selectedGender.isEmpty) {
      _showErrorSnackBar('Please select a gender');
      return false;
    }

    if (_promised.isEmpty) {
      _showErrorSnackBar('Please indicate if the supporter has promised');
      return false;
    }

    return true;
  }

  Future<bool> isValidPhoneNumber(String phoneNumber) async {
    try {
      final cleanNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
      // You might want to replace 'US' with the appropriate country code
      return await _phoneNumberUtil.validate(cleanNumber, regionCode: 'TZ');
    } catch (e) {
      print('Phone number validation error: $e');
      return false;
    }
  }

  Future<void> _pickContactNumber() async {
    final PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      try {
        final Contact? contact = await ContactsService
            .openDeviceContactPicker();
        if (contact != null && contact.phones!.isNotEmpty) {
          setState(() {
            _phoneNumberController.text = contact.phones!.first.value ?? '';
          });
        }
      } catch (e) {
        _showErrorDialog('Error accessing contacts: ${e.toString()}');
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    }
    return permission;
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      _showErrorSnackBar('Access to contact data denied');
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      _showErrorDialog(
          'Contact data access is permanently denied.\n'
              'Please enable it in your device settings.'
      );
    }
  }

  void _showSuccessDialog() {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.SUCCESS,
      title: const Text('Success'),
      content: const Text('Supporter added successfully'),
      confirmButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
        ),
        child: const Text(
          'OK',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
    ).show();
  }

  void _showErrorDialog(String message) {
    setState(() => _isLoading = false);
    StylishDialog(
      context: context,
      alertType: StylishDialogType.ERROR,
      title: const Text('Error'),
      content: Text(message),
      confirmButton: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
        ),
        child: const Text(
          'OK',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ).show();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }



}
