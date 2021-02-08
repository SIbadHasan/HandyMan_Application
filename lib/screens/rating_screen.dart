import 'dart:async';

import 'package:final_year_project/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../providers/users.dart';

class RatingCard extends StatefulWidget {
  String techid;
  String jobId;
  
  static const routeName = '/rating';
  // String userId;
  // String _token;
  RatingCard(this.techid,this.jobId);
  // const RatingCard({
  //   Key key,
  //   this.userId,
  //   this._token
  // }) : super(key: key);

  @override
  _RatingCardState createState() => _RatingCardState(this.techid,this.jobId);
  //_RatingCardState createState() => _RatingCardState(this.userId, this._token);
}

class _RatingCardState extends State<RatingCard> {
  // String userId;
  // String _token;
  String techid;
  String jobId;
  int ratings;
   _RatingCardState(this.techid,this.jobId);
  final GlobalKey<FormState> _formKey = GlobalKey();
  String fullname;
  String phoneNumber;
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  var _isLoading = false;
  var _isinit = true;

  // void initState() {
  //   super.initState();
  //   print("Init called");
  //   print(this._token);
  //   print(this.userId);
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

// void initState()
// {
//   print("Init called");
//   print(this._token);
//   print(this.userId);
// }

  // Future<void> _submit() async {
  //   if (!_formKey.currentState.validate()) {
  //     // Invalid!
  //     return;
  //   }
  //   _formKey.currentState.save();
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     Provider.of<User>(context).addUserData(authData, userId, fullName, phoneNumber)
  //   } catch (error) {
  //     // const errorMessage =
  //     //     'Could not authenticate you. Please try again later.';
  //     _showErrorDialog(error.toString());
  //   }

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  // @override
  // void initState() {

  //   Future.delayed(Duration.zero).then(
  //     (_) {
  //       setState(() {
  //          _isLoading = true;
  //       });
  //       Provider.of<Users>(context).fetchAndSetProducts().then((_) {
  //         setState(() {
  //           _isLoading = false ;
  //         });
  //       });
  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //final authData = Provider.of<Auth>(context, listen: false);
    final user = Provider.of<Users>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        color: Colors.blue[900],
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height) * 0.2,
              decoration: BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('images/splash1.png'),
                    fit: BoxFit.contain),
              ),
            ),
            SizedBox(height: 30),
            Flexible(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 8.0,
                child: Container(
                  height: 260,
                  constraints: BoxConstraints(minHeight: 260),
                  width: deviceSize.width * 0.75,
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                         Text("RATING"),
                          RatingBar.builder(
                            initialRating: 3,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Colors.red,
                                  );
                                case 1:
                                  return Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Colors.redAccent,
                                  );
                                case 2:
                                  return Icon(
                                    Icons.sentiment_neutral,
                                    color: Colors.amber,
                                  );
                                case 3:
                                  return Icon(
                                    Icons.sentiment_satisfied,
                                    color: Colors.lightGreen,
                                  );
                                case 4:
                                  return Icon(
                                    Icons.sentiment_very_satisfied,
                                    color: Colors.green,
                                  );
                              }
                            },
                            onRatingUpdate: (rating) {
                              ratings = rating.round();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (_isLoading)
                            CircularProgressIndicator()
                          else
                            RaisedButton(
                              child: Text('Submit'),
                              onPressed: () async {
                                 user.updateRating(techid, ratings);
                                user.updatevar(jobId);
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text('User Information'),
                                          content: Text('Data Added!'),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text('Okay'),
                                              onPressed: () {
                                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>TaskScreen()));
                                              },
                                            )
                                          ],
                                        ));
                                //  Navigator.of(context).pop();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              color: Theme.of(context).primaryColor,
                              textColor: Theme.of(context)
                                  .primaryTextTheme
                                  .button
                                  .color,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
