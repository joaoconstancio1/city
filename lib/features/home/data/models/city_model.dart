import 'package:city/features/home/domain/entities/city_entity.dart';

class CityModel extends CityEntity {
  CityModel(
      {super.createdAt,
      super.city,
      super.avatar,
      super.temperature,
      super.description,
      super.id});

  CityModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    city = json['city'];
    avatar = json['avatar'];
    temperature = json['temperature'];
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['city'] = city;
    data['avatar'] = avatar;
    data['temperature'] = temperature;
    data['description'] = description;
    data['id'] = id;
    return data;
  }
}
