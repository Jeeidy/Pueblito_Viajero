import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/eventos.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/favoritos.dart';
import 'package:pueblito_viajero/vistas/android/home/fragmentos/miradores.dart';
import '../../../provider/fragmento_home_provider.dart';
import '../../../utils/custom/custom_colors.dart';
import 'fragmentos/home.dart';
import 'fragmentos/perfil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  List fragmentos = [
    const HomeFragmento(), const EventosFragmento(), const MiradoresFragmento(tipo: ''), const FavoritosFragmento(), const PerfilFragmento()
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 6), (Timer timer) {
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
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: AppColors.amarilloSupernova,
                      size: 35,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 12,
              child: fragmentos[homeProvider.screens],
            )
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: homeProvider.bottomNavigationKey,
          backgroundColor: Colors.white,
          onTap: (index) {
            homeProvider.cambiarFragmento(index);
          },
          items: const [
            Icon(Icons.home_outlined, size: 30, color: AppColors.amarilloSupernova),
            Icon(Icons.calendar_month_outlined, size: 30, color: AppColors.amarilloSupernova),
            Icon(Icons.house_siding_outlined, size: 30, color: AppColors.amarilloSupernova),
            Icon(Icons.favorite_border_outlined, size: 30, color: AppColors.amarilloSupernova),
            Icon(Icons.person_2_outlined, size: 30, color: AppColors.amarilloSupernova),
          ],
        ),
      ),
    );
  }
}
