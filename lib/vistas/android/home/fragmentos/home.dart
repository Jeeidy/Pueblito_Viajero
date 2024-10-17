import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../provider/fragmento_home_provider.dart';
import '../../../../utils/custom/custom_colors.dart';
import '../../../widgets/boton_personalizable.dart';
import 'oferta_laboral.dart';

class HomeFragmento extends StatefulWidget {
  const HomeFragmento({super.key});

  @override
  State<HomeFragmento> createState() => _HomeFragmentoState();
}

class _HomeFragmentoState extends State<HomeFragmento> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  List fragmentos = [
    const HomeFragmento()
  ];

  @override
  void initState() {
    super.initState();

    // Espera un breve periodo de tiempo antes de iniciar el temporizador
    Future.delayed(Duration(milliseconds: 100), () {
      _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
        if (mounted && _pageController.hasClients) {
          if (_currentPage < 2) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }

          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Acá podrás encontrar los diferentes servicios que ofrece Pueblito Viajero',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'Miradores',
                        onPressed: () {
                          homeProvider.setPage(2);
                        },
                      ),
                      BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'Próximos eventos',
                        onPressed: () {
                          homeProvider.setPage(1);
                        },
                      ),
                      BotonComun(
                        color: AppColors.verdeDivertido,
                        text: 'Oferta laboral',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const OfertaLaboralFragmento()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/start_img.jpg', fit: BoxFit.cover),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 70, right: 70, bottom: 50, top: 40),
                  child: PageView(
                    controller: _pageController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              homeProvider.setPage(1);
                            },
                            child: Image.asset('assets/calendario.jpg', fit: BoxFit.cover)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const OfertaLaboralFragmento()),
                              );
                            },
                            child: Image.asset('assets/oferta.jpg', fit: BoxFit.cover)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: () {
                              homeProvider.setPage(2);
                            },
                            child: Image.asset('assets/miradores.jpg', fit: BoxFit.cover)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

