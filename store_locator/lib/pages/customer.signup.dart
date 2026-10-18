import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../theme/app_theme.dart';
import 'dart:developer' as dev;

class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
   final _formKey = GlobalKey<FormState>();
   final TextEditingController _nameController = TextEditingController();
   final TextEditingController _addressController = TextEditingController();
   final TextEditingController _phoneNumberController = TextEditingController();
   final TextEditingController _usernameController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   bool _isLoading = false;
   bool _obscurePassword = true;
   String? _errorMessage;
   late AnimationController _animController;
   late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _phoneNumberController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      var regBody = {
        "email": _usernameController.text,
        "password": _passwordController.text,
        "userType": "customer"
      };

      var customerBody = {
        "name": _nameController.text,
        "address": _addressController.text,
        "phoneNumber": _phoneNumberController.text,
        "username": _usernameController.text,
      };

      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));

      var customerResponse = await http.post(Uri.parse(addCustomer),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(customerBody));

      var jsonresponse = jsonDecode(response.body);
      dev.log(jsonresponse.toString());
      var customerJsonResponse = jsonDecode(customerResponse.body);
      dev.log(customerJsonResponse.toString());

      if (jsonresponse['status'] == true &&
          customerJsonResponse['status'] == true) {
        dev.log("User Registered");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Registration successful!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pushNamed(context, '/customer_dashboard');
        }
      } else {
        setState(() {
          _errorMessage = 'Registration failed. Please try again.';
        });
        dev.log("User Registration Failed");
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Connection error. Please check your network.';
      });
      dev.log('Register error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.headerGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22),
                    ),
                    const Spacer(),
                    const Text(
                      'Customer Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.accentLight, size: 32),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Create your account to find stores near you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Form Card
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnim,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(28),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Personal Info', style: AppTextStyles.heading3),
                            const SizedBox(height: 4),
                            const Text('Fill in your details below', style: AppTextStyles.caption),
                            const SizedBox(height: 20),

                            // Error message
                            if (_errorMessage != null) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.error.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.error.withOpacity(0.3)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                                    const SizedBox(width: 10),
                                    Expanded(child: Text(_errorMessage!, style: const TextStyle(color: AppColors.error, fontSize: 13))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            TextFormField(
                              controller: _nameController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Full Name',
                                icon: Icons.person_outline,
                                hint: 'Enter your full name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _addressController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Address',
                                icon: Icons.home_outlined,
                                hint: 'Enter your address',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Phone Number',
                                icon: Icons.phone_outlined,
                                hint: 'Enter your phone number',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 28),
                            const Text('Account Details', style: AppTextStyles.heading3),
                            const SizedBox(height: 4),
                            const Text('Set up your login credentials', style: AppTextStyles.caption),
                            const SizedBox(height: 20),

                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Email / Username',
                                icon: Icons.email_outlined,
                                hint: 'Enter your email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a username';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Password',
                                icon: Icons.lock_outline,
                                hint: 'Create a password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: AppColors.textHint,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),

                            GradientButton(
                              text: 'Create Account',
                              icon: Icons.person_add_rounded,
                              isLoading: _isLoading,
                              onPressed: registerUser,
                            ),
                            const SizedBox(height: 20),

                            // Bottom links
                            Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Already have an account? ',
                                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, '/'),
                                        child: const Text('Login',
                                          style: TextStyle(
                                            color: AppColors.primaryLight,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('Own a store? ',
                                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, '/shop_signup'),
                                        child: const Text('Register as shop',
                                          style: TextStyle(
                                            color: AppColors.accent,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
