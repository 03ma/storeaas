import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:store/Screens/BottomNavigationBar.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white70,
    statusBarColor: Colors.white70,
  ));
  await Hive.initFlutter();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE')
        ],
        locale: const Locale('ar', 'AE'),
        debugShowCheckedModeBanner: false,
        title: "مكتب النزار",
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        home: SafeArea(
            left: false,
            right: false,
            bottom: false,
            child: BottomNavigationBarScreen()));
  }
}
