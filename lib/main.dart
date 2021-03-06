import 'package:eventapp/src/config/router.dart';
import 'package:eventapp/src/util/firebase_notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/category_viewmodel.dart';
import 'package:eventapp/src/viewmodel/featured_event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/user_viewmodel.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    FirebaseNotificationManager _firebaseMessaging =
        FirebaseNotificationManager();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventViewModel>.value(
          value: EventViewModel(),
        ),
        ChangeNotifierProvider<FeaturedEventViewModel>.value(
          value: FeaturedEventViewModel(),
        ),
        ChangeNotifierProvider<CategoryViewModel>.value(
          value: CategoryViewModel(),
        ),
        ChangeNotifierProvider<UserViewModel>.value(
          value: UserViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Corvento',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Gilroy')),
        onGenerateRoute: Router.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
