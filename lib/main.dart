import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/ui/controller/clima_provider.dart';
import 'package:weather_station/ui/controller/search_cidade_provider.dart';
import 'package:weather_station/ui/pages/weather_home_page.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClimaProvider.getInstance),
        ChangeNotifierProvider(create: (_) => SearchCidadeProvider.getInstance)
      ],
      child: MaterialApp(
          scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          locale: const Locale('es'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', 'BR'),
            Locale('en'),
            Locale('es'),
            Locale('fr'),
            Locale('ar'),
            Locale('ja', 'JP'),
            Locale('zh'),
          ],
          debugShowCheckedModeBanner: false,
          title: 'Flutter Weather Station',
          theme: ThemeData(
            textTheme: GoogleFonts.robotoFlexTextTheme(),
            fontFamilyFallback: const ['Ubuntu', 'Roboto Mono'],
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const WeatherHomePage()),
    );
  }
}