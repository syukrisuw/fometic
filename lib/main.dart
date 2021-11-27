import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fometic/services/file_services.dart';
import 'package:fometic/services/http_services.dart';
import 'package:get/get.dart';
import 'package:fometic/controllers/app_controller.dart';
import 'package:fometic/utils/themes/app_theme.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:fometic/routes/app_routes.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_page_route_list.dart';

import 'bindings/main_binding.dart';

final logger = SimpleLogger();

void main() async {
  logger.setLevel(
    Level.INFO,
    // Includes  caller info, but this is expensive.
    includeCallerInfo: true,
  );
  WidgetsFlutterBinding.ensureInitialized();

  //sample  type of Get.put
  Get.putAsync<HttpServices>(() async => HttpServices(),
      tag: "HttpServices", permanent: true);
  Get.putAsync<FileServices>(() async => FileServices(),
      tag: "FileServices", permanent: true);
  Get.lazyPut<AppController>(() => AppController(),
      tag: "AppController", fenix: true);

  runApp(const SetaraApp());
}

class SetaraApp extends StatelessWidget with WidgetsBindingObserver {
  const SetaraApp({Key? key}) : super(key: key);
  static const TAG = "SetaraApp";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    logger.info("[{$TAG}.didChangeAppLifecycleState]");
    if (state == AppLifecycleState.inactive) {
      logger.info("[{$TAG}.didChangeAppLifecycleState] state=inactive");
    } else if (state == AppLifecycleState.resumed) {
      logger.info("[{$TAG}.didChangeAppLifecycleState] state=resumed");
    }
    super.didChangeAppLifecycleState(state);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //set to main route in AppPages with name AppRoutes.MAIN (main_page.dart)
    return GetMaterialApp(
        title: "Fometic Application",
        initialRoute: AppRoutes.MAIN,
        getPages: AppPageRouteList.list,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        textDirection: TextDirection.ltr,
        initialBinding: MainBinding(),
        localizationsDelegates: const [
          //ExplorerLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US'), Locale('id', 'ID')],
        locale: const Locale('id', 'ID'));
  }
}

