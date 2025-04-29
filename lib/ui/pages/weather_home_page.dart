import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_station/domain/model/clima_model.dart' show ClimaModel;
import 'package:weather_station/ui/controller/clima_provider.dart';
import 'package:weather_station/ui/controller/location_controller.dart';
import 'package:weather_station/ui/widgets/daily_forecast.dart' show DailyForecast;
import 'package:weather_station/ui/widgets/hourly_forecast.dart' show HourlyForecast;

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final ClimaController climaController =  ClimaController();
  final ClimaProvider weaProvider = ClimaProvider(listarLocaisPorLatLonUc: listarLocaisPorLatLonUc, listarLocaisPorNomeUc: listarLocaisPorNomeUc, listarLocaisSalvosUc: listarLocaisSalvosUc, excluirCidadeUc: excluirCidadeUc, salvarCidadeUc: salvarCidadeUc)
  @override
  void dispose() {
      weaProvider.dispose();
    super.dispose();
  }
  Future<List<ClimaModel>> getClima () async {
    Position posicao = await climaController.posicaoAtual();
    await widget.weaProvider.getClimaLatLon(posicao.latitude, posicao.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final weaProvider = widget.weaProvider;
    return DefaultTextStyle(
      style: GoogleFonts.robotoFlex(
        color:const Color.fromARGB(255, 198, 198, 198),
        letterSpacing: 2,
        fontWeight: FontWeight.w100,
        textStyle: TextStyle(
          locale: Localizations.localeOf(context),
          fontFamily: 'Roboto Flex',
          shadows: List.filled(3, const Shadow(color: Colors.black54, blurRadius: 1.5, offset: Offset(2,1))),
          fontFamilyFallback: const ['Ubuntu', 'Roboto Flex']
        )
      ),
      child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(0, 0, 0, 1),
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black12, BlendMode.lighten),
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
                        Text("Atualizado em •", style: TextStyle(fontSize: 8, color: Colors.white70)),
                        Icon(Icons.info_outline, color: Colors.white70, size: 12),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text("CIDADE", style:GoogleFonts.robotoFlex(fontSize: 50, fontWeight: FontWeight.w100, letterSpacing: 6)),
                            const SizedBox(height: 8),
                            Text("20ºC", style: GoogleFonts.robotoFlex(fontSize: 95, fontWeight: FontWeight.w700, letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text("{{maximo e minimo}}", style: GoogleFonts.ubuntuCondensed(fontSize: 24, fontWeight: FontWeight.w500, letterSpacing: 2)),
                            const SizedBox(height: 8),
                            Text("{{clima_slug}}", style: GoogleFonts.ubuntuCondensed(fontSize: 24, fontWeight: FontWeight.w100, letterSpacing: 2)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        semanticChildCount: 24,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        children: const [
                          HourlyForecast(hour: "1 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "2 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "3 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "4 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "5 AM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "6 AM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "7 AM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "8 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "9 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "10 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "11 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "12 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "13 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "14 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "15 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "16 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "17 PM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "18 PM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "19 PM", temp: "13°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "20 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "21 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "22 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "23 PM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                          HourlyForecast(hour: "00 AM", temp: "14°", icon: Icons.nightlight, chance: "0%"),
                        ],
                      ),
                    ),
                    const Center(child: Divider(height: 32)),
                    const DailyForecast(day: "Today", icon: Icons.wb_sunny, chance: "0%", high: "22°", low: "12°"),
                    const DailyForecast(day: "Tuesday", icon: Icons.cloud, chance: "11%", high: "21°", low: "15°"),
                    const DailyForecast(day: "Wednesday", icon: Icons.cloud, chance: "0%", high: "20°", low: "12°"),
                    const DailyForecast(day: "Thursday", icon: Icons.cloud, chance: "19%", high: "18°", low: "13°"),
                    const DailyForecast(day: "Friday", icon: Icons.cloudy_snowing, chance: "59%", high: "16°", low: "11°"),
                    const DailyForecast(day: "Saturday", icon: Icons.cloudy_snowing, chance: "42%", high: "16°", low: "9°"),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
