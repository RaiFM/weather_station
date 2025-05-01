import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:weather_station/domain/model/clima_model.dart' show ClimaModel;
import 'package:weather_station/ui/controller/clima_provider.dart';
import 'package:weather_station/ui/controller/location_controller.dart';
import 'package:weather_station/ui/controller/search_cidade_provider.dart';
import 'package:weather_station/ui/widgets/daily_forecast.dart';
import 'package:weather_station/ui/widgets/hourly_forecast.dart';

import 'package:weather_station/domain/usecase/listar_nome_cidades_uc.dart';
import 'package:weather_station/infra/repository/repository_cidade_api.dart';
import 'package:weather_station/infra/service/api_cidades_service.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final LocationController locationController = LocationController();
  String? estadoSelecionado;
  String? cidadeSelecionada;
  final TextEditingController cidadeController = TextEditingController();

  final Map<String, int> estados = {
    'AC': 12,
    'AL': 27,
    'AP': 16,
    'AM': 13,
    'BA': 29,
    'CE': 23,
    'DF': 53,
    'ES': 32,
    'GO': 52,
    'MA': 21,
    'MT': 51,
    'MS': 50,
    'MG': 31,
    'PA': 15,
    'PB': 25,
    'PR': 41,
    'PE': 26,
    'PI': 22,
    'RJ': 33,
    'RN': 24,
    'RS': 43,
    'RO': 11,
    'RR': 14,
    'SC': 42,
    'SP': 35,
    'SE': 28,
    'TO': 17
  };

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchCidadeProvider(
        listarNomeCidadesUc: ListarNomeCidadesUc(
          repositoryCidadeApi: RepositoryCidadeApi(
            apiCidadesService: ApiCidadesService().getInstance,
          ).getInstance,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/skycloudy.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Consumer<SearchCidadeProvider>(
                builder: (context, provider, _) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Atualizado em •",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                            Icon(Icons.info_outline,
                                color: Colors.white70, size: 18),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Selecione o estado:",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 14)),
                              const SizedBox(height: 10),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    dropdownColor: Colors.black87,
                                    value: estadoSelecionado,
                                    hint: const Text("UF",
                                        style:
                                            TextStyle(color: Colors.white70)),
                                    icon: const Icon(Icons.keyboard_arrow_down,
                                        color: Colors.white),
                                    onChanged: (String? newUf) async {
                                      setState(() {
                                        estadoSelecionado = newUf;
                                        cidadeController.clear();
                                      });
                                      if (newUf != null) {
                                        await provider
                                            .pesquisarNome(estados[newUf]!);
                                      }
                                    },
                                    items: estados.keys.map((String uf) {
                                      return DropdownMenuItem<String>(
                                        value: uf,
                                        child: Text(uf,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text("Digite a cidade:",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 14)),
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Autocomplete<String>(
                                  optionsBuilder: (TextEditingValue value) {
                                    if (value.text.isEmpty) {
                                      return const Iterable<String>.empty();
                                    }
                                    return provider.allClimas
                                        .where((c) =>
                                            c != null &&
                                            c!.toLowerCase().contains(
                                                value.text.toLowerCase()))
                                        .cast<String>();
                                  },
                                  fieldViewBuilder: (context, controller,
                                      focusNode, onEditingComplete) {
                                    return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      onEditingComplete: onEditingComplete,
                                      enabled: estadoSelecionado != null,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        hintText: "Cidade",
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        border: InputBorder.none,
                                      ),
                                    );
                                  },
                                  onSelected: (String selection) {
                                    setState(
                                        () => cidadeSelecionada = selection);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                cidadeSelecionada?.toUpperCase() ?? "CIDADE",
                                style: GoogleFonts.robotoFlex(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  letterSpacing: 3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text("20ºC",
                                  style: GoogleFonts.robotoFlex(
                                      fontSize: 84,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(height: 8),
                              Text("Máx: 26º  Mín: 15º",
                                  style: GoogleFonts.ubuntuCondensed(
                                      fontSize: 18, color: Colors.white70)),
                              Text("Ensolarado",
                                  style: GoogleFonts.ubuntuCondensed(
                                      fontSize: 18, color: Colors.white70)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          height: 110,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            children: const [
                              HourlyForecast(
                                  hour: "1 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "2 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "3 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "4 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "5 AM",
                                  temp: "13°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "6 AM",
                                  temp: "13°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "7 AM",
                                  temp: "13°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "8 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "9 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                              HourlyForecast(
                                  hour: "10 AM",
                                  temp: "14°",
                                  icon: Icons.nightlight,
                                  chance: "0%"),
                            ],
                          ),
                        ),
                        const Divider(
                            height: 40,
                            color: Color.fromARGB(60, 255, 255, 255)),
                        const DailyForecast(
                            day: "Hoje",
                            icon: Icons.sunny,
                            chance: "0%",
                            high: "22°",
                            low: "12°"),
                        const DailyForecast(
                            day: "Amanhã",
                            icon: Icons.cloud,
                            chance: "11%",
                            high: "21°",
                            low: "15°"),
                        const DailyForecast(
                            day: "Quarta",
                            icon: Icons.cloud,
                            chance: "0%",
                            high: "20°",
                            low: "12°"),
                        const DailyForecast(
                            day: "Quinta",
                            icon: Icons.cloud,
                            chance: "19%",
                            high: "18°",
                            low: "13°"),
                        const DailyForecast(
                            day: "Sexta",
                            icon: Icons.cloudy_snowing,
                            chance: "59%",
                            high: "16°",
                            low: "11°"),
                        const DailyForecast(
                            day: "Sábado",
                            icon: Icons.cloudy_snowing,
                            chance: "42%",
                            high: "16°",
                            low: "9°"),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
