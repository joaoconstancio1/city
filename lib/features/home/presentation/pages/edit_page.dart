import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.city});

  final CityEntity city;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _cityController;
  late TextEditingController _temperatureController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController(text: widget.city.city);
    _temperatureController =
        TextEditingController(text: widget.city.temperature);
    _descriptionController =
        TextEditingController(text: widget.city.description);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Page'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'City Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _temperatureController,
              decoration: const InputDecoration(
                labelText: 'Temperature',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 3,
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
