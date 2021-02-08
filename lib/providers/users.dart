import 'package:final_year_project/models/data_api.dart';
import 'package:final_year_project/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  String authToken;
  String id;
  String naam;
  String number;

  List<User> _newUser = [];
  List<Technician> _techs = [];
  List<Technician> _sortedtechs = [];
  List<Jobs> _jobs = [];

  Users(this.authToken, this.id, this._newUser);
  List<User> get user {
    return [..._newUser];
  }

  List<Technician> get technicians {
    return [..._techs];
  }
  List<Jobs> get alljobs{
    return[..._jobs];
  }

  List<Technician> get sortedtechnicians {
    return [..._sortedtechs];
  }

  String get userName {
    return _newUser[0].fullName;
  }

  String get phoneNumber {
    return _newUser[0].phoneNumber;
  }

//&orderBy="creatorId"&equalTo="$id"
  Future<void> fetchAndSetUsers() async {
    //  final filterString = '';
    var url =
        'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/users.json?auth=$authToken';
    try {
      print(authToken.toString());
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // url = 'https://shop-app-88117.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      // final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      final List<User> loadedusers = [];
      naam = extractedData['fullName'];
      number = extractedData['Number'];
      extractedData.forEach(
        (userId, userData) {
          if (userId == id) {
            loadedusers.add(
              User(
                id: userId,
                fullName: userData['fullName'],
                phoneNumber: userData['phoneNumber'],
              ),
            );
          }
        },
      );

      //loadedusers.forEach((element) {print(element.fullName);});
      _newUser = loadedusers;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetTechs() async {
    //  final filterString = '';
    var url =
        'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/technicians.json?auth=$authToken';
    try {
      //  print(authToken.toString());
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      // url = 'https://shop-app-88117.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      // final favoriteResponse = await http.get(url);
      //final favoriteData = json.decode(favoriteResponse.body);
      final List<Technician> loadedtechs = [];
      extractedData.forEach(
        (userId, userData) {
          // print(extractedData.toString());
          loadedtechs.add(Technician(
            id: userId,
            address: userData['address'],
            fcm: userData['fcm'],
            fullName: userData['fullName'],
            latitude: userData['latitude'],
            longitude: userData['longitude'],
            phoneNumber: userData['phoneNumber'],
            techtype: userData['techtype'],
            arating: userData['arating'],
            trating: userData['trating'],
            jobs: userData['jobs'],
          ));
        },
      );

      //loadedusers.forEach((element) {print(element.fullName);});
      _techs = loadedtechs;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> fetchAndSetJobs() async {
    // final filterString ='orderBy="creatorId"&equalTo="$id"';
    var url =
        'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/jobs.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Jobs> loadedJobs = [];
      final List<Jobs> userJobs = [];
      extractedData.forEach(
        (jobId, jobData) {
          loadedJobs.add(
            Jobs(
              creatorid: jobData['creatorId'],
              jobId: jobId,
              description: jobData['description'],
              address: jobData['address'],
              phoneNumber: jobData['phoneNumber'],
              fullName: jobData['fullName'],
              techId: jobData['techId'],
              type: jobData['type'],
              techName: jobData['techName'],
              techNumber: jobData['techNumber'],
              jobstat: jobData['jobstat'],
              rating: jobData['rating'],
            ),
          );
        },
      );
      for (int i = 0; i<loadedJobs.length;i++)
      {
        if (loadedJobs[i].creatorid == id)
        {
          userJobs.add(loadedJobs[i]);
        }
      }
      _jobs = userJobs;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> sortTechs({double lat, double long, String type}) async {
    final Distance distance = new Distance();
    _sortedtechs.clear();
    for (int i = 0; i < _techs.length; i++) {
      if (_techs[i].techtype == type) {
        final double km = distance.as(
            LengthUnit.Kilometer,
            new LatLng(lat, long),
            new LatLng(_techs[i].latitude, _techs[i].longitude));
        _techs[i].distance = km;
        _sortedtechs.add(_techs[i]);
        //  _sortedtechs.in
      } else {
      }
      
      // for (int j= 0 ; j<_sortedtechs.length; j++)
      // {
      //   for (int k = j ; k<_sortedtechs.length;)
      // }
    }
    _sortedtechs.sort((a,b) => a.distance.compareTo(b.distance));
    //  _sortedtechs == null ? null :
  }

  // Future<void> sendJob(UserModel user) async {
  //   const url =
  //       'https://testingcore.appsmenia.com/api/Notifications/SendPushNotificationIbad';

  //   try {
  //     final chk = jsonEncode(user.toJson());
  //     var _heders = {"Content-Type": "application/json"};
  //     final response = await http.post(url, headers: _heders, body: chk);
  //     print(response.toString());
  //     var check = json.decode(response.body);
  //     if (check["status"] == true) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  Future<void> addUserData(String authToken, String userId, String fullName,
      String phoneNumber) async {
    var dialog = false;
    final url =
        'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/users/$id.json?auth=$authToken';
    try {
      final response = await http.put(
        url,
        body: jsonEncode({
          'fullName': fullName,
          'phoneNumber': phoneNumber,
        }),
        // body: jsonEncode({
        //   'fullName' : fullName ,
        //   'phoneNumber' : phoneNumber ,
        //  } ),
      );
      User use = new User(
        id: jsonDecode(response.body)['name'],
        fullName: fullName,
        phoneNumber: phoneNumber,
      );
      _newUser.add(use);
      dialog = true;
      // print(use.id);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
    return dialog;
  }

 

  Future<void> addUJobData({
    String authToken,
    String userId,
    String techId,
    String techName,
    String techNumber,
    String fullName,
    String type,
    String phoneNumber,
    String address,
    String description,
    double lat,
    double long,
  }) async {
    final url =
        'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/jobs.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: jsonEncode({
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'address': address,
          'description': description,
          'latitude': lat,
          'longitude': long,
          'techName': techName,
          'techNumber': techNumber,
          'type': type,
          'creatorId': userId,
          'techId': techId,
          'status': false,
          'jobstat': 'WAITING',
          'rating':false,
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
  Future<void> updateRating(String ide,int rating) async
  {
    int arating;
    int trating;
    int jobs;
    List<Technician> _ratingtechs = _techs;
    for (int i = 0; i<_ratingtechs.length; i++)
    {
      if (_ratingtechs[i].id == ide)
      {
        arating = _ratingtechs[i].arating;
        trating= _ratingtechs[i].trating;
        jobs=_ratingtechs[i].jobs;
      }
    }
    trating += rating;
    jobs++ ;
    
    double avg = (trating/jobs) ;
    arating = avg.round();
   
   final url = 'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/technicians/$ide.json?auth=$authToken';
   try {
      final response = await http.patch(
        url,
        body: jsonEncode({
          'arating': arating,
          'trating': trating,
          'jobs':jobs,
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
  Future<void> updatevar(String ide) async
  {
    
   final url = 'https://fyp-app-d6f4f-default-rtdb.firebaseio.com/jobs/$ide.json?auth=$authToken';
   try {
      final response = await http.patch(
        url,
        body: jsonEncode({
          'rating':true,
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }
}


