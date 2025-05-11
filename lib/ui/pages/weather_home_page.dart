import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_station/domain/model/clima_model.dart' show ClimaModel;
import 'package:weather_station/ui/controller/clima_provider.dart';
import 'package:weather_station/ui/controller/location_controller.dart';
import 'package:weather_station/ui/widgets/hourly_forecast.dart'
    show HourlyForecast, HourlyForecastList;

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late List<ClimaModel?> previsaoResults;
  late Position location;

  Future<Position> getPosition() async {
    LocationController locationController = LocationController();
    return await locationController.posicaoAtual();
  }
  
  void getResults() async {
    ClimaProvider cp = ClimaProvider.getInstance;
    location = await getPosition();
    previsaoResults = await cp.getClimaLatLon(location.latitude, location.longitude);
  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: GoogleFonts.robotoFlex(
          color: const Color.fromARGB(255, 198, 198, 198),
          letterSpacing: 2,
          fontWeight: FontWeight.w100,
          textStyle: TextStyle(
              locale: Localizations.localeOf(context),
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
                children: [
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Atualizado em •",
                          style: TextStyle(fontSize: 8, color: Colors.white70)),
                      Icon(Icons.info_outline, color: Colors.white70, size: 12),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text("${previsaoResults[0]?.nome}",
                              style: GoogleFonts.robotoFlex(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w100,
                                  letterSpacing: 6)),
                          const SizedBox(height: 8),
                          Text("${previsaoResults[0]?.temperatura}",
                              style: GoogleFonts.robotoFlex(
                                  fontSize: 95,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2)),
                          const SizedBox(height: 8),
                          Text("${previsaoResults[0]?.tempMin}°C - ${previsaoResults[0]?.tempMax}°C",
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 100,
                    child: HourlyForecastList(previsaoReq: previsaoResults)
                    ),
                    const Center(child: Divider(height: 32)),
                  ]),
                  
            ),
          ),
        ),
      ),
    );
  }
}
