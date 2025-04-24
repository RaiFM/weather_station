import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_lat_lon_uc.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';
import 'package:weather_station/infra/service/api_cidades_service.dart';
import 'package:weather_station/infra/service/api_service.dart';
import 'package:weather_station/infra/service/clima_service.dart';
import 'package:weather_station/ui/controller/location_controller.dart';
import 'firebase_options.dart';

 void  main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp()
);

}

class MyApp extends StatelessWidget {
  
  
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Teste App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const
   MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lista = ["Sorocaba,SP", "Itapevi,SP"];
  ApiCidadesService apiCidadesService =  ApiCidadesService();

    ListarLocaisPorLatLonUc list = ListarLocaisPorLatLonUc(iRepositoryApi: RepositoryApi(apiService: ApiService().getInstance).getInstance).getInstance;
  
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
  ClimaController climaController = ClimaController();
    
  void sla() async{
 
 
  }

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
              'You have pushed the button this many times:',
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
