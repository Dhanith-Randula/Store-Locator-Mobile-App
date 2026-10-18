import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_picker/map_picker.dart'; //
//dev.log
import 'dart:developer' as dev;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'applogo.dart';
// import 'loginPage.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import '../theme/app_theme.dart';

import 'dart:developer' as dev;

class ShopRegisterPage extends StatefulWidget {
  @override
  State<ShopRegisterPage> createState() => _ShopRegisterPageState();
}

class _ShopRegisterPageState extends State<ShopRegisterPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoriesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final int _photoCount = 0;
  LatLng? selectedLocation = null;
  bool _isLoading = false;
  bool _obscurePassword = true;
  String? _errorMessage;
  int _currentStep = 0;

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
    _ownerNameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _categoriesController.dispose();
    _descriptionController.dispose();
    _businessTypeController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void registerShop() async {
    if (_nameController.text.isNotEmpty &&
        _ownerNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _categoriesController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _businessTypeController.text.isNotEmpty &&
        _openingTimeController.text.isNotEmpty &&
        _closingTimeController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      // Create a shop account
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      var regbody = {
        "email": _usernameController.text,
        "password": _passwordController.text,
        "userType": "shop"
      };
      var shopBody = {
        "ownerName": _ownerNameController.text,
        "shopName": _nameController.text,
        "email": _emailController.text,
        "location": _locationController.text,
        "categories": _categoriesController.text,
        "description": _descriptionController.text,
        "businessType": _businessTypeController.text,
        "openingTime": _openingTimeController.text,
        "closingTime": _closingTimeController.text,
        "username": _usernameController.text,
      };
      dev.log(Uri.parse(registration).toString());
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var shopResponse = await http.post(Uri.parse(addShop),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(shopBody));

      dev.log("regbody > " + regbody.toString());
      dev.log("shopbody > " + shopBody.toString());
      dev.log("request for registration sent successfully");

      var jsonResponse = jsonDecode(response.body);
      var jsonShopResponse = jsonDecode(shopResponse.body);
      dev.log("response body > " + jsonResponse.toString());
      dev.log("response body > " + jsonShopResponse.toString());
      dev.log(jsonResponse['status'].toString() + " " + jsonShopResponse['status'].toString());

      if (jsonResponse['status'] && jsonShopResponse['status']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Shop registered successfully!'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
          Navigator.pushNamed(context, '/shop_dashboard');
        }
      } else {
        setState(() {
          _errorMessage = 'Registration failed. Please try again.';
        });
        dev.log("Something Went Wrong");
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Connection error. Please check your network.';
      });
      dev.log('Shop register error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildSectionTitle(String title, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.heading3),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Shop Info', 'Details', 'Account'];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: Row(
        children: List.generate(steps.length, (index) {
          final isActive = index <= _currentStep;
          final isCompleted = index < _currentStep;
          return Expanded(
            child: Row(
              children: [
                if (index > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isActive ? AppColors.accentLight : Colors.white.withOpacity(0.3),
                    ),
                  ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.accentLight : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: AppColors.primaryDark, size: 16)
                        : Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: isActive ? AppColors.primaryDark : Colors.white.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
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
                      'Register Your Shop',
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

              // Icon + Step indicator
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.store_rounded, color: AppColors.accentLight, size: 30),
              ),
              const SizedBox(height: 12),
              _buildStepIndicator(),
              const SizedBox(height: 16),

              // Form
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

                            // Section 1: Shop Information
                            _buildSectionTitle('Shop Information', 'Basic details about your store', Icons.storefront_outlined),

                            TextFormField(
                              controller: _nameController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Shop Name',
                                icon: Icons.store_outlined,
                                hint: 'Enter your shop name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter your shop name';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            TextFormField(
                              controller: _ownerNameController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Owner Name',
                                icon: Icons.person_outline,
                                hint: 'Enter the owner\'s name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter owner name';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Shop Email',
                                icon: Icons.email_outlined,
                                hint: 'Enter shop email address',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter your email';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // Location field with map icon
                            TextFormField(
                              controller: _locationController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Location',
                                icon: Icons.place_outlined,
                                hint: 'Enter shop location',
                                suffixIcon: Container(
                                  margin: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.error.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.map_rounded, color: AppColors.error, size: 22),
                                ),
                              ),
                              onTap: () {
                                selectedLocation = LatLng(5.42796133580664, 80.085749655962);
                                dev.log("location clicked" + selectedLocation.toString());
                              },
                            ),

                            const SizedBox(height: 28),

                            // Section 2: Business Details
                            _buildSectionTitle('Business Details', 'Tell customers about your shop', Icons.business_outlined),

                            TextFormField(
                              controller: _categoriesController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Categories',
                                icon: Icons.category_outlined,
                                hint: 'e.g. Electronics, Clothing',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter categories';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            TextFormField(
                              controller: _descriptionController,
                              maxLines: 3,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Description',
                                icon: Icons.description_outlined,
                                hint: 'Describe your shop...',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter description';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            TextFormField(
                              controller: _businessTypeController,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Business Type',
                                icon: Icons.work_outline,
                                hint: 'e.g. Retail, Wholesale',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter business type';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            // Opening / Closing time in a row
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _openingTimeController,
                                    decoration: AppDecorations.inputDecoration(
                                      label: 'Opening',
                                      icon: Icons.access_time_rounded,
                                      hint: '9:00 AM',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Required';
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextFormField(
                                    controller: _closingTimeController,
                                    decoration: AppDecorations.inputDecoration(
                                      label: 'Closing',
                                      icon: Icons.access_time_filled_rounded,
                                      hint: '9:00 PM',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) return 'Required';
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // Section 3: Account
                            _buildSectionTitle('Account Setup', 'Login credentials for your shop', Icons.shield_outlined),

                            TextFormField(
                              controller: _usernameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Username / Email',
                                icon: Icons.alternate_email,
                                hint: 'Enter your login email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) return 'Please enter a username';
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),

                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: AppDecorations.inputDecoration(
                                label: 'Password',
                                icon: Icons.lock_outline,
                                hint: 'Create a secure password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                                if (value == null || value.isEmpty) return 'Please enter a password';
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),

                            GradientButton(
                              text: 'Register Shop',
                              icon: Icons.store_rounded,
                              isLoading: _isLoading,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  registerShop();
                                }
                              },
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
                                      const Text('Not a shop? ',
                                        style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(context, '/customer_signup'),
                                        child: const Text('Sign up as customer',
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
