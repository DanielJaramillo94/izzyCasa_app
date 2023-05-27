import 'package:get_it/get_it.dart';
import 'package:izzy_casa_app/utils/custom_http_client.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<CustomHttpClient>(CustomHttpClient());
}
