import 'package:flutter/services.dart';

class ProfileModel {
  Uint8List? image;
  String? name;
  String? email;
  String? skill;
  List<Experience>? experience;

  ProfileModel({this.image, this.name, this.email, this.skill, this.experience});

  Uint8List convertDynamicListToUint8List(List<dynamic> dynamicList) {
    Uint8List uint8List = Uint8List(dynamicList.length);

    for (int i = 0; i < dynamicList.length; i++) {
      if (dynamicList[i] is int) {
        uint8List[i] = dynamicList[i];
      } else {
        throw ArgumentError('Element at index $i is not an integer');
      }
    }

    return uint8List;
  }

  ProfileModel.fromJson(Map<String, dynamic> json) {
    if (json['Image'] != null) {
      image = convertDynamicListToUint8List(json['Image']);
    }
    name = json['name'];
    email = json['email'];
    skill = json['skill'];
    if (json['experience'] != null) {
      experience = <Experience>[];
      json['experience'].forEach((v) {
        experience!.add(Experience.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Image'] = image;
    data['name'] = name;
    data['email'] = email;
    data['skill'] = skill;
    if (experience != null) {
      data['experience'] = experience!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Experience {
  String? startDate;
  String? endDate;
  String? companyName;
  String? designation;

  Experience({this.startDate, this.endDate, this.companyName, this.designation});

  Experience.fromJson(Map<String, dynamic> json) {
    startDate = json['startDate'];
    endDate = json['endDate'];
    companyName = json['companyName'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['companyName'] = companyName;
    data['designation'] = designation;
    return data;
  }
}
