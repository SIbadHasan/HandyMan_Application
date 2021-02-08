import 'package:after_layout/after_layout.dart';
import 'package:final_year_project/maps/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import './location_helper.dart';
import './maps_screen.dart';

class CurrentLocation extends StatefulWidget {
  final Function onSelectPlace;

  

  CurrentLocation(this.onSelectPlace);

  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> with AfterLayoutMixin<CurrentLocation> {
  String _previewImageUrl;

  void _showPreview(double lat , double lng){
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try 
    {
      final locData = await Location().getLocation();
    _showPreview(locData.latitude, locData.longitude);
    widget.onSelectPlace(locData.latitude, locData.longitude);
    }
    catch (error)
    {
      return;
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width * 0.95,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  height: 270,
                  width: MediaQuery.of(context).size.width * 0.95,
                ),
        ),
      ],
    );
  }
   @override
  void afterFirstLayout(BuildContext context) {
    _getCurrentUserLocation();
  }
}
