import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../modelos/evento_modelo.dart';
import '../../../../provider/screen_iniciar_sesion_provider.dart';
import '../../../../provider/panel_eventos_provider.dart';
import '../../../../utils/custom/custom_colors.dart';

class CalendarioInteractivo extends StatelessWidget {
  const CalendarioInteractivo({super.key});

  @override
  Widget build(BuildContext context) {
    final eventosProvider = Provider.of<EventosProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);

    String capitalize(String input) {
      if (input.isEmpty) return input;
      return input[0].toUpperCase() + input.substring(1);
    }

    return SizedBox(
      child: Card(
        elevation: 3,
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: TableCalendar(
              locale: 'es_ES',
              availableCalendarFormats: const {
                CalendarFormat.month: 'Mes',
              },
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: eventosProvider.focusedDay,
              headerStyle: HeaderStyle(
                titleTextFormatter: (date, locale) => capitalize(DateFormat.yMMMM(locale).format(date)),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) => capitalize(DateFormat.E(locale).format(date)),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(eventosProvider.selectedDay, day);
              },
              eventLoader: (day) {
                return eventosProvider.getEventsForDay(day);
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: AppColors.amarilloSupernova,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                eventosProvider.onDaySelected(selectedDay, focusedDay);
                List<EventoModel> events = eventosProvider.getEventsForDay(selectedDay);
                if (events.isNotEmpty) {
                  eventosProvider.selectEvent(events.first);
                } else {
                  eventosProvider.clearSelectedEvent();
                }
              },
              onPageChanged: (focusedDay) {
                eventosProvider.onDaySelected(eventosProvider.selectedDay ?? focusedDay, focusedDay);
              },
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  List<EventoModel> eventos = eventosProvider.getEventsForDay(day);
                  if (eventos.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  bool isUserEvent = eventos.any((evento) => evento.userId == sesionProvider.usuario.id);
                  eventosProvider.coincidenIds = isUserEvent;
                  return Container(
                    decoration: BoxDecoration(
                      color: isUserEvent ? Colors.green : Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    width: 16,
                    height: 16,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}