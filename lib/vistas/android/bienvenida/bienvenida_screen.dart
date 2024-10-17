import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/vistas/android/home/home_screen.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/panel_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/custom/custom_colors.dart';

class BienvenidaPage extends StatefulWidget {
  const BienvenidaPage({super.key});

  @override
  _BienvenidaPageState createState() => _BienvenidaPageState();
}

class _BienvenidaPageState extends State<BienvenidaPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final inicioSesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      String? userId = prefs.getString('userId');
      if (userId != null && userId.isNotEmpty) {
        await inicioSesionProvider.fetchUserDataFromFirestore(userId);
      } else {
        print('User ID is null or empty');
      }
    }

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => kIsWeb ? const PantallaWebPanel() : const PantallaHome()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final inicioSesionProvider = Provider.of<IniciarSesionProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kIsWeb ? Colors.grey[300] : AppColors.verdeDivertido,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                          blurStyle: BlurStyle.outer,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BIENVENIDO',
                          style: GoogleFonts.inter(
                            fontSize: 52,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                            height: 1.03,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          inicioSesionProvider.usuario.name.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3,
                            height: 1.03,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.height * (kIsWeb ? 0.13 : 0.38) / 3) + 20,
              left: (MediaQuery.of(context).size.width - 190) / 2,
              child: Image.asset('assets/logo.png', height: 230),
            )
          ],
        ),
      ),
    );
  }
}
