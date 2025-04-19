import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/service/api_service.dart';
import 'firebase_options.dart';

 void  main() async {
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
  final ApiService api = ApiService();


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> lista = ["Sorocaba,SP", "Itapevi,SP"];  

  void _incrementCounter() {
    setState(() {
    print(widget.api.getInstance.pegarClimaSemanalNome("Carapicuíba,SP"));
    
    });
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
