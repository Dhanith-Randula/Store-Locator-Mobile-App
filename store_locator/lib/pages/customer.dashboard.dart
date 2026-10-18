import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config.dart';
import '../theme/app_theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter_slidable/flutter_slidable.dart';

class CustomerDashboardPage extends StatefulWidget {
  CustomerDashboardPage({Key? key}) : super(key: key);

  @override
  _CustomerDashboardPageState createState() => _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends State<CustomerDashboardPage> {
  final List markers = [];
  final TextEditingController _nameController = TextEditingController();
  bool _isSearching = false;
  bool _hasSearched = false;
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _nameController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  void search() async {
    if (_nameController.text.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    try {
      var url = Uri.parse(getItemToCustomer);
      url = url.replace(queryParameters: {
        "name": _nameController.text,
      });
      dev.log("url ${url.toString()}");

      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body);
      dev.log(jsonResponse.toString());

      var place = jsonResponse['success'];
      var locs = place;

      dev.log("\n\n place ${locs.toString()}");

      List newMarkers = [];

      for (var location in place) {
        var latitude = location['location'];
        var longitude = location['location'];
        dev.log("\n\nlatitude ${latitude.toString()}");

        newMarkers.add(latitude);
      }
      dev.log("\n\n new markers  >> ${newMarkers.toString()}");

      setState(() {
        markers.clear();
        markers.addAll(newMarkers);
        _hasSearched = true;
      });
    } catch (e) {
      dev.log('Search error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Search failed. Please try again.'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map fills the entire screen
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(7.8731, 80.7718),
              zoom: 8,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            markers: Set<Marker>.from(markers.map((e) => Marker(
              markerId: MarkerId(e.toString()),
              position: LatLng(e[0], e[1]),
            ))),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),

          // Top gradient overlay for status bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).padding.top + 20,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primaryDark.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Search bar overlay
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            left: 16,
            right: 16,
            child: Column(
              children: [
                // Search card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(
                        Icons.search_rounded,
                        color: _isSearching ? AppColors.accent : AppColors.primaryLight,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Search for items or stores...',
                            hintStyle: TextStyle(
                              color: AppColors.textHint,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                          ),
                          onSubmitted: (_) => search(),
                        ),
                      ),
                      if (_nameController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            _nameController.clear();
                            setState(() {
                              markers.clear();
                              _hasSearched = false;
                            });
                          },
                          icon: const Icon(Icons.close_rounded, color: AppColors.textHint, size: 20),
                        ),
                      Container(
                        height: 36,
                        width: 36,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _isSearching
                            ? const Padding(
                                padding: EdgeInsets.all(8),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: search,
                                icon: const Icon(Icons.search, color: Colors.white, size: 18),
                              ),
                      ),
                    ],
                  ),
                ),

                // Results indicator
                if (_hasSearched && markers.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.place, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          '${markers.length} location${markers.length > 1 ? 's' : ''} found',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (_hasSearched && markers.isEmpty) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.info_outline, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'No locations found',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),

          // My Location button
          Positioned(
            bottom: 24,
            right: 16,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      _mapController?.animateCamera(
                        CameraUpdate.newLatLngZoom(const LatLng(7.8731, 80.7718), 8),
                      );
                    },
                    icon: const Icon(Icons.my_location, color: AppColors.primaryLight),
                  ),
                ),
              ],
            ),
          ),

          // Logout button
          Positioned(
            bottom: 24,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
                icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                tooltip: 'Logout',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
