import 'package:get_it/get_it.dart';
import 'package:local_data_app/service/shared_preferences_service.dart';

import 'model/user_model.dart';
import 'service/file_storage_service.dart';
import 'service/locale_storage_service.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerSingleton<LocaleStorageService>(FileStorageService());
}