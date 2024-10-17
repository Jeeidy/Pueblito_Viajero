import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../../provider/fragmento_home_provider.dart';

class OfertaLaboralFragmento extends StatelessWidget {
  const OfertaLaboralFragmento({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'OFERTAS LABORALES',
                  style: GoogleFonts.inter(
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: OfertaLaboralSlider(),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Text(
                    'Estas son las ofertas laborales disponibles hasta el momento. Si te interesa alguna, por favor, guarda la información y contáctate.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OfertaLaboralSlider extends StatelessWidget {
  const OfertaLaboralSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return FutureBuilder<List<String>>(
      future: homeProvider.obtenerTodasLasOfertasLaborales(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar ofertas laborales'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay ofertas laborales disponibles'));
        } else {
          final imageUrls = snapshot.data!;
          return CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final imageUrl = imageUrls[index];
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1500),
              autoPlayInterval: const Duration(seconds: 5),
              viewportFraction: 0.75,
            ),
          );
        }
      },
    );
  }
}