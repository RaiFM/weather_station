import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';
import 'package:weather_station/infra/service/api_service.dart';
import 'package:weather_station/infra/service/clima_service.dart';
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
  IRepositoryClima repositoryClima = RepositoryClimaFirebase(climaService: ClimaService(iRepositoryApi: RepositoryApi(apiService: ApiService().getInstance)));
  



  void _incrementCounter() async {
    List<ClimaModel?> teste = [];
     teste = await repositoryClima.listarLugaresSalvos();
  print('🌆 Nome: ${teste[0]!.nome}');
print('📅 Data: ${teste[0]!.data}');
print('🌡️ Temperatura: ${teste[0]!.temperatura}°C');
print('🌤️ Descrição do Clima: ${teste[0]!.descriptionClima}');
print('🗓️ Dia da Semana: ${teste[0]!.diaSemana}');
print('⬆️ Temperatura Máxima: ${teste[0]!.tempMax}°C');
print('⬇️ Temperatura Mínima: ${teste[0]!.tempMin}°C');
print('🖼️ Ícone: ${teste[0]!.icone}');
print('💧 Precipitação: ${teste[0]!.precipitacao} mm');
print('💦 Umidade: ${teste[0]!.umidade}%');
print('🌬️ Velocidade do Vento: ${teste[0]!.velocidadeVento}');
print('🧭 Direção do Vento: ${teste[0]!.direcaoVento}°');
print('🗺️ Vento Cardinal: ${teste[0]!.cardinalVento}');
print('🌅 Nascer do Sol: ${teste[0]!.nascerSol}');
print('🌇 Pôr do Sol: ${teste[0]!.porSol}');
print('🌙 Fase da Lua: ${teste[0]!.faseLua}');
print('🕓 Fuso Horário: ${teste[0]!.fusoHorario}');




    }
  void sla() async{
    Position? position = await Geolocator.getLastKnownPosition();
    print(position);
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
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
