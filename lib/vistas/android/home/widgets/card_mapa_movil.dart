import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

import '../../../../utils/custom/custom_colors.dart';

class CardGoogleMaps extends StatelessWidget {
  final String src;
  final String name;
  final double width;
  final double height;

  const CardGoogleMaps({
    required this.src,
    this.width = 400,
    this.height = 300,
    super.key,
    required this.name,
  });

  LatLng _extractLatLng(String src) {
    final uri = Uri.parse(src);
    final queryParams = uri.queryParameters;
    final pb = queryParams['pb'];
    if (pb != null) {
      final parts = pb.split('!');
      double? lat;
      double? lng;
      for (var part in parts) {
        if (part.startsWith('3d')) {
          lat = double.tryParse(part.substring(2));
        } else if (part.startsWith('2d')) {
          lng = double.tryParse(part.substring(2));
        }
      }
      if (lat != null && lng != null) {
        return LatLng(lat, lng);
      }
    }
    throw Exception('Invalid map URL');
  }

  @override
  Widget build(BuildContext context) {
    final LatLng position = _extractLatLng(src);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            color: AppColors.verdeDivertido,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Text(
                  'Mapa',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 2.3,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            width: width,
            height: height,
            child: Card(
              elevation: 3,
              color: Colors.grey[300],
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: position,
                      initialZoom: 13.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: const ['a', 'b', 'c'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: position,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.green,
                                  size: 40.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


