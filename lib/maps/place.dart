import 'dart:io';

import 'package:flutter/foundation.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

 const PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}


