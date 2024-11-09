import 'package:city/features/home/data/models/city_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CityModel', () {
    // Test 1: Test constructor initialization
    test('should create CityModel from constructor', () {
      final cityModel = CityModel(
        createdAt: '2024-11-09T00:00:00Z',
        city: 'Victoria',
        avatar: 'avatar.png',
        temperature: '22.5',
        description: 'Clear sky',
        id: '1',
      );

      expect(cityModel.createdAt, '2024-11-09T00:00:00Z');
      expect(cityModel.city, 'Victoria');
      expect(cityModel.avatar, 'avatar.png');
      expect(cityModel.temperature, '22.5');
      expect(cityModel.description, 'Clear sky');
      expect(cityModel.id, '1');
    });

    // Test 2: Test fromJson method
    test('should create CityModel from JSON', () {
      final Map<String, dynamic> json = {
        'createdAt': '2024-11-09T00:00:00Z',
        'city': 'Victoria',
        'avatar': 'avatar.png',
        'temperature': '22.5',
        'description': 'Clear sky',
        'id': '1',
      };

      final cityModel = CityModel.fromJson(json);

      expect(cityModel.createdAt, '2024-11-09T00:00:00Z');
      expect(cityModel.city, 'Victoria');
      expect(cityModel.avatar, 'avatar.png');
      expect(cityModel.temperature, '22.5');
      expect(cityModel.description, 'Clear sky');
      expect(cityModel.id, '1');
    });

    // Test 3: Test toJson method
    test('should return correct JSON from CityModel', () {
      final cityModel = CityModel(
        createdAt: '2024-11-09T00:00:00Z',
        city: 'Victoria',
        avatar: 'avatar.png',
        temperature: '22.5',
        description: 'Clear sky',
        id: '1',
      );

      final Map<String, dynamic> json = cityModel.toJson();

      expect(json['createdAt'], '2024-11-09T00:00:00Z');
      expect(json['city'], 'Victoria');
      expect(json['avatar'], 'avatar.png');
      expect(json['temperature'], '22.5');
      expect(json['description'], 'Clear sky');
      expect(json['id'], '1');
    });
  });
}
