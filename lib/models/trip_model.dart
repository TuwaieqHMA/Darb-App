import 'package:flutter/material.dart';

class Trip {
  Trip({
    required this.driverName,
    required this.district,
    required this.date,
    required this.timeFrom,
    required this.timeTo,
    required this.noOfPassengers,
    required this.tripType,
  });

  late final String driverName;
  late final String district;
  late final DateTime date;
  late final TimeOfDay timeFrom;
  late final TimeOfDay timeTo;
  late final int noOfPassengers;
  late final String tripType;

  Trip.fromJson(Map<String, dynamic> json)
      : driverName = json['driverName'],
        district = json['district'],
        date = DateTime.parse(json['date']),
        timeFrom = _parseTimeOfDay(json['timeFrom']),
        timeTo = _parseTimeOfDay(json['timeTo']),
        noOfPassengers = json['noOfPassengers'],
        tripType = json['tripType'];

  Map<String, dynamic> toJson() {
    return {
      'driverName': driverName,
      'district': district,
      'date': date.toIso8601String(),
      'timeFrom': '${timeFrom.hour}:${timeFrom.minute}',
      'timeTo': '${timeTo.hour}:${timeTo.minute}',
      'noOfPassengers': noOfPassengers,
      'tripType': tripType,
    };
  }

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }
}

// JSON FORMAT
// {
//       "driverName": "Mohammed",
//       "district": "Alrusaifa",
//       "date": "2024-09-08",
//       "timeFrom": "09:00",
//       "timeTo": "12:00",
//       "noOfPassengers": 40,
//       "tripType": "Departure"
// }