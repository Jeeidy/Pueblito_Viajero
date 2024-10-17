import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/panel_mirador_provider.dart';
import '../../../../utils/custom/custom_colors.dart';

class EditarWidget extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onCheck;
  final int id;

  const EditarWidget({
    super.key,
    required this.onEdit,
    required this.onCheck,
    required this.id
  });

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    return Card(
      elevation: 2,
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(Icons.edit_outlined)),
              Divider(thickness: 1, color: Colors.grey[300]),
              GestureDetector(
                onTap: onCheck,
                child:  id == 1
                ? Icon(Icons.check_outlined, color: miradorProvider.contactoCheck ? AppColors.verdeDivertido :  null)
                : id == 2 ? Icon(Icons.check_outlined, color: miradorProvider.serviciosCheck ? AppColors.verdeDivertido :  null)
                : Icon(Icons.check_outlined, color: miradorProvider.horarioCheck ? AppColors.verdeDivertido :  null)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditarWidgetHorizontal extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onCheck;

  const EditarWidgetHorizontal({super.key, required this.onEdit, required this.onCheck});

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    return Card(
      elevation: 2,
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Row(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(Icons.edit_outlined)
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Divider(thickness: 1, color: Colors.grey[300]),
              ),
              GestureDetector(
                onTap: onCheck,
                child: Icon(Icons.check_outlined, color: miradorProvider.nombreDescripcionCheck ? AppColors.verdeDivertido :  null)
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditarWidgetEliminar extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onCheck;
  final String type;
  final int id;

  const EditarWidgetEliminar({
    super.key,
    required this.onEdit,
    required this.onDelete,
    required this.onCheck,
    required this.id,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final miradorProvider = Provider.of<PanelMiradorProvider>(context);

    return Card(
      elevation: 2,
      color: Colors.grey[400],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: onEdit,
                child: const Icon(Icons.edit_outlined)
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              GestureDetector(
                onTap: onCheck,
                child: id == 1
                ? Icon(Icons.check_outlined, color: miradorProvider.imagenCheck ? AppColors.verdeDivertido :  null)
                : Icon(
                  Icons.check_outlined,
                  color:
                  type == 'imagen' ? miradorProvider.imagenesCheck ? AppColors.verdeDivertido : null :
                  type == 'mapa' ? miradorProvider.mapaCheck ? AppColors.verdeDivertido : null : null
                )
              ),
              Divider(thickness: 1, color: Colors.grey[300]),
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete_outline_outlined)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
