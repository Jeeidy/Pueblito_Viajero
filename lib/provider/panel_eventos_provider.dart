import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/modelos/evento_modelo.dart';
import 'package:pueblito_viajero/servicios/evento_servicio.dart';

import '../utils/funciones/funcion_galeria_modelo.dart';
import 'screen_iniciar_sesion_provider.dart';

class EventosProvider with ChangeNotifier {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  final FocusNode nombreFocusNode = FocusNode();
  final FocusNode precioFocusNode = FocusNode();
  final FocusNode horaFocusNode = FocusNode();
  final FocusNode descripcionFocusNode = FocusNode();

  final ImagePickerService _imagePickerService = ImagePickerService();
  final EventoService _eventoService = EventoService();
  EventoModel? _selectedEvent;
  EventoModel? get selectedEvent => _selectedEvent;


  bool isLoading = false;
  bool coincidenIds = false;

  DateTime? _selectedDay;
  DateTime? get selectedDay => _selectedDay;

  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;

  EventoModel evento = EventoModel(
    nombre: '',
    precio: '',
    hora: '',
    descripcion: '',
    fecha: null,
  );

  Map<DateTime, List<EventoModel>> eventos = {};

  void agregarValor(TextEditingController controller, String tipo) {
    String valor = controller.text;
    if (valor.isNotEmpty) {
      switch (tipo) {
        case 'nombre':
          evento.actualizarNombre(valor);
          break;
        case 'precio':
          evento.actualizarPrecio(valor);
          break;
        case 'hora':
          evento.actualizarHora(valor);
          break;
        case 'descripcion':
          evento.actualizarDescripcion(valor);
          break;
      }
      controller.clear();
    }
  }

  Future<void> cargarEventos(BuildContext context) async {
    final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);
    List<EventoModel> eventos = await _eventoService.obtenerEventos();
    for (var evento in eventos) {
      DateTime? fecha = evento.fecha;
      if (fecha != null) {
        if (this.eventos[fecha] == null) {
          this.eventos[fecha] = [];
        }
        this.eventos[fecha]!.add(evento);
      }
    }

    for (var entry in this.eventos.entries) {
      for (var evento in entry.value) {
        if (evento.userId == sesionProvider.usuario.id) {
          // Pintar de verde
        } else {
          // Pintar de amarillo
        }
      }
    }

    notifyListeners();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
    evento.actualizarFecha(selectedDay);
    notifyListeners();
  }

  void agregarEvento(EventoModel evento) {
    if (_selectedDay != null) {
      if (eventos[_selectedDay!] == null) {
        eventos[_selectedDay!] = [];
      }
      eventos[_selectedDay!]!.add(evento);
      notifyListeners();
    }
  }

  Future<void> eliminarEvento(String userId) async {
    try {
      await _eventoService.eliminarEvento(userId);
      eventos.forEach((key, value) {
        value.removeWhere((evento) => evento.userId == userId);
      });
      notifyListeners();
    } catch (e) {
      print('Error al eliminar evento: $e');
    }
  }

  List<EventoModel> getEventsForDay(DateTime day) {
    return eventos[day] ?? [];
  }

  Future<void> pickImageFromGallery() async {
    await _imagePickerService.pickImageFromGallery(evento);
    notifyListeners();
  }

  Future<void> actualizarEvento(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    try {
      final sesionProvider = Provider.of<IniciarSesionProvider>(context, listen: false);

      evento.actualizarNombre(nombreController.text);
      evento.actualizarPrecio(precioController.text);
      evento.actualizarHora(horaController.text);
      evento.actualizarDescripcion(descripcionController.text);
      evento.actualizarUserId(sesionProvider.usuario.id);
      evento.actualizarFecha(_selectedDay!);

      await _eventoService.actualizarEvento(sesionProvider.mirador.userId, evento);
      agregarEvento(evento);
      evento.image = null;
      limpiarCampos();
    } catch (e) {
      print('Error al actualizar evento: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void limpiarCampos() {
    nombreController.clear();
    precioController.clear();
    horaController.clear();
    descripcionController.clear();
  }

  void selectEvent(EventoModel event) {
    _selectedEvent = event;
    notifyListeners();
  }

  void clearSelectedEvent() {
    _selectedEvent = null;
    notifyListeners();
  }
}