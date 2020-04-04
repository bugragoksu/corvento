import 'package:eventapp/src/model/event.dart';
import 'package:eventapp/src/ui/screen/bookmarks_page.dart';
import 'package:eventapp/src/ui/screen/category_page.dart';
import 'package:eventapp/src/ui/screen/event_detail_page.dart';
import 'package:eventapp/src/ui/screen/events_by_category_page.dart';
import 'package:eventapp/src/ui/screen/featured_events_page.dart';
import 'package:eventapp/src/ui/screen/home_page.dart';
import 'package:eventapp/src/ui/screen/notification_page.dart';
import 'package:eventapp/src/ui/screen/upcoming_event_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/upcomingEvents':
        return MaterialPageRoute(builder: (_) => UpcomingEventsPage());
      case '/featuredEvents':
        return MaterialPageRoute(builder: (_) => FeaturedEventsPage());
      case '/eventDetailPage':
        Event e = settings.arguments as Event;
        return MaterialPageRoute(builder: (_) => EventDetailPage(event: e));
      case '/notificationPage':
        return MaterialPageRoute(builder: (_) => NotificationPage());
      case '/bookmarkPage':
        return MaterialPageRoute(builder: (_) => BookMarksPage());
      case '/categoryPage':
        return MaterialPageRoute(builder: (_) => CategoryPage());
      case '/eventsbycategoryPage':
        return MaterialPageRoute(builder: (_) => EventByCategoryPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child:
                  Icon(FontAwesomeIcons.sadTear, color: Colors.white, size: 64),
            ),
          ),
        );
    }
  }
}
