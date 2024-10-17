import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/fragmentos/secciones/formulario_oferta_laboral.dart';
import '../../../../provider/panel_oferta_laboral_provider.dart';
import '../../../../utils/custom/custom_colors.dart';

class PanelOfertaLaboral extends StatelessWidget {
  const PanelOfertaLaboral({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OfertaLaboralProvider(context),
      child: const Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: SliderOfertaLaboral()
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CardMensajeGuia()
                      ),
                      Expanded(
                        flex: 5,
                          child: FormularioOfertaLaboral()
                      ),
                    ],
                  )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}

class CardMensajeGuia extends StatelessWidget {
  const CardMensajeGuia({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: AppColors.gris,
      child: const Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Text(
              'En esta sección podrás publicar ofertas laborales para tu empresa, carga una imagen con toda la información necesaria para que los interesados puedan postularse.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
      )
    );
  }
}


class SliderOfertaLaboral extends StatelessWidget {
  const SliderOfertaLaboral({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OfertaLaboralProvider>(context);

    return Card(
      elevation: 3,
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 4.0),
                borderRadius: BorderRadius.circular(15),
              ),
              child: provider.isSliderLoading
              ? const Center(
                child: CircularProgressIndicator(color: AppColors.azulClaro),
              )
              : provider.imageUrls.isEmpty
              ? const Center(
                child: Text(
                  'No hay imágenes disponibles',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              )
              : PageView.builder(
                controller: provider.pageController,
                itemCount: provider.imageUrls.length,
                itemBuilder: (context, index) {
                  final imageUrl = provider.imageUrls[index];

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
                onPageChanged: (index) {
                  provider.updateCurrentPage(index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}