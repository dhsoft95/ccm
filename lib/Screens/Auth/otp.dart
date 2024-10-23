import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/authProvider.dart';
import 'login.dart';

class OTPConfirmationScreen extends StatefulWidget {
  const OTPConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<OTPConfirmationScreen> createState() => _OTPConfirmationScreenState();
}

class _OTPConfirmationScreenState extends State<OTPConfirmationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthProvider _authProvider;
  bool _isLoading = false;
  int _resendTimer = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void didChangeDependencies() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendTimer = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendTimer > 0) {
        setState(() => _resendTimer--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _resendOTP() async {
    if (_resendTimer > 0) return;

    setState(() => _isLoading = true);
    try {
      final response = await _authProvider.sendOtp(
        phone: _authProvider.registerUser?.phone ?? '',
      );

      if (response['success']) {
        _startResendTimer();
        _showSnackBar('OTP sent successfully.', Colors.green);
      } else {
        String errorMessage = _parseErrorMessage(response['message']);
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      _showErrorDialog('Failed to send OTP. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _parseErrorMessage(dynamic message) {
    try {
      if (message is String && message.contains('{')) {
        // Parse JSON string containing errors
        Map<String, dynamic> errorData = json.decode(message);
        if (errorData.containsKey('errors')) {
          final errors = errorData['errors'] as Map<String, dynamic>;
          String errorMessage = '';
          errors.forEach((key, value) {
            if (value is List) {
              value.forEach((msg) => errorMessage += '• $msg\n');
            } else {
              errorMessage += '• $value\n';
            }
          });
          return errorMessage.trim();
        }
      }
      return message.toString();
    } catch (e) {
      return message.toString();
    }
  }

  Future<void> _verifyOTP() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // First verify the OTP
      final otpResponse = await _authProvider.verifyOtp(
        otp: _otpController.text,
      );

      if (!otpResponse['success']) {
        setState(() => _isLoading = false);
        _showErrorDialog(_parseErrorMessage(otpResponse['message']));
        return;
      }

      // If OTP is verified, proceed with registration
      final registrationResponse = await _authProvider.register();

      setState(() => _isLoading = false);

      if (!mounted) return;

      if (registrationResponse['success']) {
        await _showSuccessDialog();
      } else {
        String errorMessage = _parseErrorMessage(registrationResponse['message']);
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorDialog('An unexpected error occurred. Please try again.');
    }
  }

  void _showSnackBar(String message, Color backgroundColor) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green[400],
                size: 60,
              ),
              const SizedBox(height: 10),
              const Text(
                'Registration Successful',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Your account has been created successfully. Please login to continue.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                      (route) => false,
                );
              },
              child: const Text(
                'Login Now',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red[400],
                size: 60,
              ),
              const SizedBox(height: 10),
              const Text(
                'Registration Failed',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color(0xff009b65),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff009b65), Color(0xff0d1018)],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/ccm_logo.png',
                              width: 120,
                              height: 120,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Title
                          const Text(
                            'OTP Verification',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Phone number display
                          Text(
                            'Enter the verification code sent to\n${_authProvider.registerUser?.phone ?? ''}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // OTP Input field
                          TextFormField(
                            controller: _otpController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            maxLength: 6,
                            enabled: !_isLoading,
                            decoration: InputDecoration(
                              labelText: 'Enter OTP',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                Icons.confirmation_number,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.redAccent),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              counterText: '',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter OTP code';
                              }
                              if (value.length != 6) {
                                return 'OTP must be 6 digits';
                              }
                              if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                                return 'OTP must contain only numbers';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Verify button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _verifyOTP,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff009b65),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 40,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _isLoading ? 'Verifying...' : 'Verify OTP',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Resend button
                          TextButton(
                            onPressed: _isLoading || _resendTimer > 0 ? null : _resendOTP,
                            child: Text(
                              _resendTimer > 0
                                  ? 'Resend OTP in $_resendTimer seconds'
                                  : 'Resend OTP',
                              style: TextStyle(
                                color: Colors.white.withOpacity(
                                  _resendTimer > 0 || _isLoading ? 0.5 : 1,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Back button
                          TextButton(
                            onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Back',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Loading overlay
                if (_isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
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
}