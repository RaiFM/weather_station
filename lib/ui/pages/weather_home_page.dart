import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_station/domain/model/clima_model.dart' show ClimaModel;
import 'package:weather_station/ui/controller/clima_provider.dart';
import 'package:weather_station/ui/controller/location_controller.dart';
import 'package:weather_station/ui/pages/search_saves_page.dart';
import 'package:weather_station/ui/pages/settings_page.dart';
import 'package:weather_station/ui/widgets/sunriseset_forecast.dart';
import 'package:weather_station/ui/widgets/weekly_forecast.dart'
    show WeeklyForecastList;
import 'package:weather_station/ui/widgets/wind_forecast.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late Position location;

  Future<Position> getPosition() async {
    LocationController locationController = LocationController();
    Position posicao = await locationController.posicaoAtual();
    return posicao;
  }

  Future<void> getResults(ClimaProvider provider) async {
    location = await getPosition();
    await provider.getClimaLatLon(location.latitude, location.longitude);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ClimaProvider climaProvider =
          Provider.of<ClimaProvider>(context, listen: false);
      getResults(climaProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateRequisition = DateTime.now();
    return DefaultTextStyle(
      style: GoogleFonts.robotoFlex(
          color: const Color.fromARGB(255, 198, 198, 198),
          letterSpacing: 2,
          fontWeight: FontWeight.w100,
          textStyle: TextStyle(
              fontFamily: 'Roboto Flex',
              shadows: List.filled(
                  3,
                  const Shadow(
                      color: Colors.black54,
                      blurRadius: 1.5,
                      offset: Offset(2, 1))),
              fontFamilyFallback: const ['Ubuntu', 'Roboto Flex'])),
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 0, 0, 1),
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black12, BlendMode.lighten),
                image: AssetImage("assets/images/skycloudy.jpg")),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      icon: const Icon(Icons.data_exploration),
                                      title: const Text("Atualizado em"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          
                                          
                                          Text(
                                              "${dateRequisition.day} - ${dateRequisition.month} - ${dateRequisition.year}"),
                                          Text(
                                              "${dateRequisition.hour} : ${dateRequisition.minute}"),
                                          Text(
                                              "Timezone: ${dateRequisition.timeZoneName}"),
                                          const Text("Via API HGBrasil")
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            child: const Text("Fechar"))
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.info_outline,
                                color: Colors.white70, size: 25)),
                        IconButton(
                            icon: const Icon(Icons.search,
                                color: Colors.white70, size: 32),
                            tooltip: "Procurar e Salvos",
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SearchSavesPage()));
                            }),
                        IconButton(
                          icon: const Icon(Icons.settings,
                              color: Colors.white70, size: 25),
                          tooltip: "Configuração",
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SettingsPage()));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Consumer<ClimaProvider>(
                          builder: (context, provider, child) {
                            List<ClimaModel?> previsaoResults =
                                provider.allClimas;
                            if (previsaoResults.isEmpty) {
                              return const CircularProgressIndicator.adaptive();
                            }

                            return Column(
                              children: [
                                Text("${previsaoResults[0]?.nome}",
                                    style: GoogleFonts.robotoFlex(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w100,
                                        letterSpacing: 6)),
                                const SizedBox(height: 8),
                                Text("${previsaoResults[0]?.temperatura}°C",
                                    style: GoogleFonts.robotoFlex(
                                        fontSize: 95,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 2)),
                                const SizedBox(height: 8),
                                Text(
                                    "${previsaoResults[0]?.tempMin}°C - ${previsaoResults[0]?.tempMax}°C",
                                    style: GoogleFonts.ubuntuCondensed(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 2)),
                                const SizedBox(height: 8),
                                Text("${previsaoResults[0]?.descriptionClima}",
                                    style: GoogleFonts.ubuntuCondensed(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w100,
                                        letterSpacing: 2)),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 150,
                      child: Consumer<ClimaProvider>(
                          builder: (context, provider, child) {
                            List<ClimaModel?> previsaoResults =
                                provider.allClimas;

                            if (previsaoResults.isEmpty) {
                              return const Column(children: [
                                Text("Carregando os dados..."),
                                CircularProgressIndicator.adaptive()
                              ]);
                            }

                            return WeeklyForecastList(
                                previsaoReq: previsaoResults);
                          },
                          child: const Center(child: Divider(height: 32))),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(child: Consumer<ClimaProvider>(
                        builder: (context, provider, child) {
                      final currentResults = provider.allClimas;
                      if (currentResults.isEmpty) {
                        return const SizedBox();
                      }
                      final currentClima = currentResults[0];
                      if (currentClima == null) {
                        return const Text("Sem dados para o sol.");
                      }
                      final windWidget = WindForecast(
                          windCardinal: currentClima.cardinalVento,
                          windDirection: currentClima.direcaoVento,
                          windSpeed: currentClima.velocidadeVento);

                      final suntimeWidget = SunriseAndSetForecast(
                          sunriseHour: currentClima.nascerSol,
                          sunsetHour: currentClima.porSol);

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: windWidget),
                          Expanded(child: suntimeWidget)
                        ],
                      );
                    })),
                    SizedBox(
                      height: 100,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
