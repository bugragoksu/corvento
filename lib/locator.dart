import 'package:eventapp/src/services/api/firebase_api.dart';
import 'package:eventapp/src/services/repository/event_repository.dart';
import 'package:eventapp/src/viewmodel/event_viewmodel.dart';
import 'package:eventapp/src/viewmodel/featured_event_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FirebaseAPI);
  locator.registerLazySingleton(() => EventRepository);
  locator.registerFactory(() => EventViewModel);
  locator.registerFactory(() => FeaturedEventViewModel);
}
