import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pueblito_viajero/provider/screen_iniciar_sesion_provider.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';
import 'package:pueblito_viajero/vistas/web/panel_screen/widgets/textfield_mirador.dart';
import 'package:pueblito_viajero/vistas/web/sesion_registro/fragmentos/inicio_sesion_fragmento.dart';
import 'package:pueblito_viajero/vistas/widgets/boton_personalizable.dart';

import '../../../../../provider/panel_perfil_provider.dart';
import '../../../../android/crear_cuenta/widgets/textfield_personalizable.dart';

class FormularioPerfil extends StatelessWidget {
  const FormularioPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    final perfilProvider = Provider.of<PerfilProvider>(context);
    final sesionProvider = Provider.of<IniciarSesionProvider>(context);
    var height = MediaQuery.of(context).size.height;

    Widget buildSectionTitle(String title) {
      return Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }

    Widget buildSectionText(String text) {
      return Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      );
    }

    Widget buildSectionSubtitle(String subtitle) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          subtitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }


    return Card(
      elevation: 3,
      color: Colors.grey[300],
      child: perfilProvider.selectedOption >= 1 && perfilProvider.selectedOption <= 5
      ? Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child:
              perfilProvider.selectedOption == 1 ?
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldNombreMirador(
                          hintText: sesionProvider.usuario.name,
                          controller: perfilProvider.nameController,
                          focusNode: perfilProvider.nameFocusNode,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 10),
                        TextFieldNombreMirador(
                          hintText:
                          sesionProvider.usuario.phone.isEmpty
                          ? 'Teléfono de contacto'
                          : sesionProvider.usuario.phone.toString(),
                          controller: perfilProvider.telefonoController,
                          focusNode: perfilProvider.telefonoFocusNode,
                          keyboardType: TextInputType.text,
                        )
                      ],
                    )
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          perfilProvider.isLoading
                          ? const Center(child: CircularProgressIndicator(color: AppColors.azulClaro))
                          : BotonComun(
                            color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                            text: 'Actualizar',
                            onPressed: (){
                              perfilProvider.actualizarUsuario(
                                context,
                                perfilProvider.nameController.text,
                                perfilProvider.telefonoController.text
                              );
                            }
                          ),
                          BotonComun(
                            color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                            text: 'Cancelar',
                            onPressed: (){
                              perfilProvider.updateSelectedOption(0);
                            }
                          )
                        ],
                      ),
                    )
                  )
                ],
              )
              : perfilProvider.selectedOption == 2 ?
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Correo:',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFieldNombreMirador(
                                hintText: 'Correo electrónico',
                                controller: sesionProvider.emailController,
                                focusNode: sesionProvider.emailFocusNode,
                                keyboardType: TextInputType.text,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                sesionProvider.isLoading_2
                                ? const CircularProgressIndicator(
                                  color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,)
                                : BotonComun(
                                  color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                                  text: 'Enviar link de restablecimiento',
                                  onPressed: () {
                                    sesionProvider.sendPasswordResetEmail(context);
                                  }
                                ),
                                BotonComun(
                                  color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                                  text: 'Cancelar',
                                  onPressed: (){
                                    perfilProvider.updateSelectedOption(0);
                                    sesionProvider.cambiarMarcaForgetPasswordFalse();
                                  }
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ],
              )
              : perfilProvider.selectedOption == 3 ?
              Column(
                children: [
                   Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Política de Privacidad',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Fecha de entrada en vigor: 13 de septiembre de 2024',
                                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(height: 16),
                              buildSectionTitle('1. Introducción'),
                              buildSectionText(
                                'Bienvenido a Pueblito Viajero. Nos comprometemos a proteger la privacidad y seguridad de nuestros usuarios. Esta Política de Privacidad describe cómo recopilamos, usamos, y protegemos tu información personal cuando utilizas nuestra aplicación que proporciona información sobre miradores cercanos y los servicios asociados.',
                              ),
                              buildSectionTitle('2. Información que Recopilamos'),
                              buildSectionSubtitle('2.1. Información que tú nos proporcionas'),
                              buildSectionText(
                                '- Información de la cuenta: Cuando te registras en nuestra aplicación, podemos solicitarte información como nombre, dirección de correo electrónico y otros detalles de contacto.\n'
                                    '- Comentarios y sugerencias: Si nos envías sugerencias, preguntas o comentarios, también recopilaremos esa información para mejorar nuestro servicio.',
                              ),
                              buildSectionSubtitle('2.2. Información que recopilamos automáticamente'),
                              buildSectionText(
                                '- Datos de geolocalización: Para mostrar miradores cercanos y servicios relacionados (como restaurantes o estacionamientos), solicitamos acceso a tu ubicación en tiempo real. Esta información se usa exclusivamente para ofrecerte una experiencia más precisa.\n'
                                    '- Información del dispositivo: Podemos recopilar información sobre tu dispositivo, como el modelo, sistema operativo, dirección IP y otra información técnica para mejorar el rendimiento de la aplicación.\n'
                                    '- Cookies y tecnologías de seguimiento: Utilizamos cookies y tecnologías similares para mejorar la funcionalidad de la aplicación.',
                              ),
                              buildSectionTitle('3. Uso de la Información'),
                              buildSectionText(
                                'Utilizamos la información que recopilamos para:\n'
                                    '- Mostrarte miradores y servicios cercanos en función de tu ubicación.\n'
                                    '- Mejorar la precisión de nuestras recomendaciones.\n'
                                    '- Ofrecer un servicio más personalizado y relevante.\n'
                                    '- Comunicarnos contigo sobre actualizaciones de la aplicación o notificaciones importantes.',
                              ),
                              // Puedes seguir añadiendo más secciones del acuerdo aquí
                            ],
                          ),
                        ),
                      ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BotonComun(
                          color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                          text: 'Regresar',
                          onPressed: (){
                            perfilProvider.updateSelectedOption(0);
                          }
                        )
                      ],
                    )
                  )
                ],
              )
              : perfilProvider.selectedOption == 4 ?
              Column(
                children: [
                   Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Normas Comunitarias',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Fecha de entrada en vigor: 13 de septiembre de 2024',
                              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                            ),
                            const SizedBox(height: 16),
                            buildSectionTitle('1. Introducción'),
                            buildSectionText(
                              'En Pueblito Viajero, nos esforzamos por crear una comunidad respetuosa y segura para todos nuestros usuarios. Estas Normas Comunitarias establecen las reglas básicas que deben seguirse al utilizar nuestra plataforma.',
                            ),
                            buildSectionTitle('2. Comportamiento Respetuoso'),
                            buildSectionText(
                              'Queremos que todos se sientan bienvenidos y respetados. Por lo tanto, los usuarios deben abstenerse de:\n'
                                  '- Publicar contenido ofensivo, amenazante o discriminatorio.\n'
                                  '- Realizar ataques personales o acoso a otros usuarios.\n'
                                  '- Difundir información falsa o malintencionada.',
                            ),
                            buildSectionTitle('3. Contenido Apropiado'),
                            buildSectionText(
                              'Los usuarios deben asegurarse de que todo el contenido compartido en la plataforma sea apropiado para todos los públicos. Esto incluye:\n'
                                  '- No publicar imágenes o videos con violencia gráfica o contenido explícito.\n'
                                  '- Evitar la difusión de contenido que incite al odio o violencia.\n'
                                  '- Publicar contenido relevante que respete el propósito de la comunidad (por ejemplo, sobre miradores o servicios relacionados).',
                            ),
                            buildSectionTitle('4. Privacidad y Seguridad'),
                            buildSectionText(
                              'Para proteger la privacidad y seguridad de todos, los usuarios no deben:\n'
                                  '- Compartir información personal de otros sin su consentimiento.\n'
                                  '- Intentar acceder a las cuentas o información privada de otros usuarios.\n'
                                  '- Difundir enlaces maliciosos o software dañino.',
                            ),
                            buildSectionTitle('5. Consecuencias de las Infracciones'),
                            buildSectionText(
                              'Las infracciones a estas Normas Comunitarias pueden llevar a:\n'
                                  '- Advertencias temporales o permanentes.\n'
                                  '- Suspensión o eliminación de la cuenta.\n'
                                  '- Eliminación de contenido inapropiado.\n\n'
                                  'Nos reservamos el derecho de tomar las acciones necesarias para mantener un ambiente seguro y respetuoso para todos.',
                            ),
                            buildSectionTitle('6. Contacto y Denuncias'),
                            buildSectionText(
                              'Si encuentras contenido o comportamiento que infrinja estas Normas Comunitarias, puedes denunciarlo directamente en la aplicación o contactarnos a través de [Correo electrónico de soporte].',
                            ),
                            buildSectionTitle('7. Cambios en las Normas'),
                            buildSectionText(
                              'Nos reservamos el derecho de modificar estas Normas Comunitarias en cualquier momento. Te notificaremos de cualquier cambio a través de la aplicación. El uso continuado de la plataforma después de dichos cambios constituye la aceptación de las nuevas Normas.',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BotonComun(
                          color: kIsWeb ? AppColors.azulClaro : AppColors.verdeDivertido,
                          text: 'Regresar',
                          onPressed: (){
                            perfilProvider.updateSelectedOption(0);
                          }
                        )
                      ],
                    )
                  )
                ],
              )
              : const SizedBox(height: 0),
            ),
          ],
        ),
      )
      : const Center(child: SizedBox(height: 0)),
    );
  }


}
