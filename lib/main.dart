import 'package:eventapp/src/config/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/category_viewmodel.dart';
import 'package:eventapp/src/viewmodel/featured_event_viewmodel.dart';

void main() async {
  //setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EventViewModel>(
          create: (context) => EventViewModel(),
        ),
        ChangeNotifierProvider<FeaturedEventViewModel>(
          create: (context) => FeaturedEventViewModel(),
        ),
        ChangeNotifierProvider<CategoryViewModel>(
          create: (context) => CategoryViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Evento',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply()),
        onGenerateRoute: Router.generateRoute,
        initialRoute: "/",
      ),
    );
  }
}
