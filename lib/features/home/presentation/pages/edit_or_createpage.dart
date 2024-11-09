import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';

class EditOrCreatePage extends StatefulWidget {
  const EditOrCreatePage({super.key, this.city});

  final CityEntity? city;

  @override
  State<EditOrCreatePage> createState() => _EditOrCreatePageState();
}

class _EditOrCreatePageState extends State<EditOrCreatePage> {
  late TextEditingController _cityController;
  late TextEditingController _temperatureController;
  late TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.city?.city);
    _temperatureController =
        TextEditingController(text: widget.city?.temperature);
    _descriptionController =
        TextEditingController(text: widget.city?.description);
  }

  @override
  void dispose() {
    _cityController.dispose();
    _temperatureController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homePageCubit = Modular.get<HomePageCubit>();
    final isEditing = widget.city != null;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          isEditing ? 'Edit' : 'Create',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: _cityController,
                label: 'City Name',
                icon: Icons.location_city,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _temperatureController,
                label: 'Temperature',
                icon: Icons.thermostat,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description,
                maxLines: 3,
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (isEditing) {
                      await homePageCubit.updateCity(
                        id: widget.city?.id,
                        cityName: _cityController.text,
                        temperature: _temperatureController.text,
                        description: _descriptionController.text,
                      );
                    } else {
                      await homePageCubit.createCity(
                        cityName: _cityController.text,
                        temperature: _temperatureController.text,
                        description: _descriptionController.text,
                      );
                    }
                    Modular.to.pop(true);
                  }
                },
                icon: Icon(isEditing ? Icons.save : Icons.add, size: 20),
                label: Text(
                  isEditing ? 'Save Changes' : 'Create City',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  textStyle: const TextStyle(fontSize: 18),
                  shadowColor: Colors.blueAccent.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}
