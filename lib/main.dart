import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/domain/usecase/listar_locais_lat_lon_uc.dart';
import 'package:weather_station/infra/service/api_cidades_service.dart';
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
        ChangeNotifierProvider(
            create: (_) => ClimaProvider.getInstance),
        ChangeNotifierProvider(
            create: (_) => SearchCidadeProvider.getInstance)
      ],
      child: MaterialApp(
        locale: const Locale('es'),
        localizationsDelegates:const [
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
        home: const WeatherHomePage()
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  //const
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lista = ["Sorocaba,SP", "Itapevi,SP"];
  ApiCidadesService apiCidadesService = ApiCidadesService();

  ListarLocaisPorLatLonUc list = ListarLocaisPorLatLonUc.getInstance;

  var climaMock = ClimaModel(
    nome: "Itapevi,SP",
    diaSemana: "Qua",
    temperatura: 22,
    descriptionClima: "Céu limpo",
    data: "24/04/2025",
    tempMin: 18,
    tempMax: 26,
    icone: "sunny",
    precipitacao: 0,
    chanceChuva: 0, // se tiver esse campo no model
    umidade: 60,
    velocidadeVento: "4.2 km/h",
    direcaoVento: 120,
    cardinalVento: "SE",
    nascerSol: "06:15 am",
    porSol: "05:50 pm",
    faseLua: "cheia",
    fusoHorario: "-03:00",
  );
  ClimaProvider climaController = ClimaProvider.getInstance;

  void sla() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '',
            ),
            Text(
              'oi',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sla,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
