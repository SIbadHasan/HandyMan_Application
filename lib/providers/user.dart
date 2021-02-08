import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User with ChangeNotifier {
  String fullName;
  String phoneNumber;
  String id;

  User({
    this.fullName,
    this.phoneNumber,
    this.id,
  });
}

class Jobs with ChangeNotifier {
  final String fullName;
  final String phoneNumber;
  final String creatorid;
  final String description;
  final String address;
  final String techId;
  final String techName;
  final String techNumber;
  final String type;
  final String jobstat;
  final bool rating;
  final String jobId;

  Jobs({
    this.fullName,
    this.jobId,
    this.phoneNumber,
    this.creatorid,
    this.jobstat,
    this.address,
    this.description,
    this.techId,
    this.techName,
    this.techNumber,
    this.type,
    this.rating,
  });
}

class Technician with ChangeNotifier {
  final String id;
  final String fullName;
  final String address;
  final double latitude;
  final double longitude;
  final String phoneNumber;
  final String techtype;
  final String fcm;
  double distance ;
  int arating;
  int trating;
  int jobs;

  Technician({
    this.id,
    this.address,
    this.fullName,
    this.latitude,
    this.longitude,
    this.phoneNumber,
    this.techtype,
    this.fcm,
    this.arating,
    this.trating,
    this.jobs,
  });
}
