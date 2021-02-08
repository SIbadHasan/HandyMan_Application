import 'package:final_year_project/screens/bookings.dart';
import 'package:final_year_project/screens/job-mechanical.dart';
import 'package:final_year_project/screens/profile.dart';
import 'package:final_year_project/screens/rating_screen.dart';
import 'package:final_year_project/screens/search.dart';
import 'package:final_year_project/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/users.dart';
import './screens/splash_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Users>(
          create: null,
          update: (ctx, auth, currentuser) => Users(
            auth.token,
            auth.userId,
            currentuser == null ? [] : currentuser.user,
          ),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'HomeTechs',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? TaskScreen()
              : FutureBuilder(
                  future: auth.autoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            EditProfile.routeName: (ctx) => EditProfile(),
            BookingsScreen.routeName: (ctx) => BookingsScreen(),
           // Mechanical.routeName: (ctx) => Mechanical(),
           // Search.routeName: (ctx) => Search(),
            //RatingCard.routeName: (ctx) => RatingCard(),
            //TaskScreen.routeName: (ctx) => TaskScreen(),
          },
        ),
      ),
    );
  }
}
