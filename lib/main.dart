import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:pueblito_viajero/provider/fragmento_home_provider.dart';
import 'package:pueblito_viajero/provider/fragmento_miradores_provider.dart';
import 'package:pueblito_viajero/provider/fragmento_perfil_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/utils/navegacion_librerias/webview_mobile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pueblito_viajero/provider/panel_eventos_provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/provider/panel_inicio_provider.dart';
import 'package:pueblito_viajero/provider/panel_mirador_provider.dart';
import 'package:pueblito_viajero/provider/panel_oferta_laboral_provider.dart';
import 'package:pueblito_viajero/provider/panel_perfil_provider.dart';
import 'package:pueblito_viajero/provider/screen_registro_provider.dart';
import 'package:pueblito_viajero/provider/screen_servicios_provider.dart';
import 'package:pueblito_viajero/provider/screen_start_provider.dart';
import 'package:pueblito_viajero/vistas/android/bienvenida/bienvenida_screen.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/cargar_imagen_screen.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/crear_cuenta_1_screen.dart';
import 'package:pueblito_viajero/vistas/android/crear_cuenta/crear_cuenta_2_screen.dart';
import 'package:pueblito_viajero/vistas/android/home/home_screen.dart';
import 'package:pueblito_viajero/vistas/android/informacion/informacion_screen.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/iniciar_sesion_contrasenia_escreen.dart';
import 'package:pueblito_viajero/vistas/android/iniciar_sesion/iniciar_sesion_screen.dart';
import 'package:pueblito_viajero/vistas/android/servicios/servicios_screen.dart';
import 'package:pueblito_viajero/vistas/android/splash/pantalla_splash.dart';
import 'package:pueblito_viajero/vistas/android/start/start_screen.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/panel_screen.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/sesion_registro_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'servicios/opciones_firebase.dart';

Future<void> main() async {
  await initializeDateFormatting('es_ES', null);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    WebViewPlatform.instance = getWebViewPlatform();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      FlutterStatusbarcolor.setStatusBarColor(AppColors.blanco);
      FlutterStatusbarcolor.setNavigationBarColor(Colors.transparent);
      SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [SystemUiOverlay.top]
      );
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StartProvider>(
          create: (_) => StartProvider(),
        ),
        ChangeNotifierProvider<RegistroProvider>(
          create: (_) => RegistroProvider(),
        ),
        ChangeNotifierProvider<IniciarSesionProvider>(
          create: (_) => IniciarSesionProvider(),
        ),
        ChangeNotifierProvider<ServiciosProvider>(
          create: (_) => ServiciosProvider(),
        ),
        ChangeNotifierProvider<PanelProvider>(
          create: (_) => PanelProvider(),
        ),
        ChangeNotifierProvider<EventosProvider>(
          create: (_) => EventosProvider(),
        ),
        ChangeNotifierProvider<PanelMiradorProvider>(
          create: (_) => PanelMiradorProvider(),
        ),
        ChangeNotifierProvider<OfertaLaboralProvider>(
          create: (_) => OfertaLaboralProvider(context),
        ),
        ChangeNotifierProvider<PerfilProvider>(
          create: (_) => PerfilProvider(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider<MiradoresFragmentoProvider>(
          create: (_) => MiradoresFragmentoProvider(),
        ),
        ChangeNotifierProvider<FragmentoPerfilProvider>(
          create: (_) => FragmentoPerfilProvider(),
        ),
      ],
      child: const AplicacionInicial(),
    );
  }
}

class AplicacionInicial extends StatelessWidget {
  const AplicacionInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _comprobarEstadoDeLogin(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
                color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido
            )
          );
        } else {
          final data = snapshot.data as Map<String, dynamic>;
          final isLoggedIn = data['isLoggedIn'] as bool;

          String rutaInicial;
          if (kIsWeb) {
            rutaInicial = isLoggedIn ? '/bienvenida' : '/web_sesion_registro';
          } else {
            rutaInicial = isLoggedIn ? '/bienvenida' : '/splash';
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: rutaInicial,
            routes: <String, WidgetBuilder>{
              '/splash': (context) => const PantallaSplash(),
              '/start': (context) => const PantallaInicio(),
              '/informacion': (context) => const PantallaInformacion(),
              '/servicios': (context) => const PantallaServicios(),
              '/iniciar_sesion': (context) => const PantallaIniciarSesion(),
              '/iniciar_contrasenia': (context) => const PantallaSesionContrasenia(),
              '/crear_cuenta': (context) => const PantallaCrearCuenta_1(),
              '/crear_cuenta_2': (context) => const PantallaCrearCuenta_2(),
              '/cargar_imagen': (context) => const PantallaCargarImagen(),
              '/bienvenida': (context) => const BienvenidaPage(),
              '/home': (context) => const PantallaHome(),

              '/web_sesion_registro': (context) => const PantallaWebSesionRegistro(),
              '/panel_administrativo': (context) => const PantallaWebPanel(),
            },
          );
        }
      },
    );
  }

  Future<Map<String, dynamic>> _comprobarEstadoDeLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    return {
      'isLoggedIn': isLoggedIn,
    };
  }
}
