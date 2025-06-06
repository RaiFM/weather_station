import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:weather_station/ui/pages/weather_home_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 2),
                          const Text("DESENVOLVIDO POR:"),
                          const SizedBox(height: 5),
                          const Text("2AMS"),
                          const SizedBox(height: 15),
                          const Text("API> HG WEATHER BRASIL"),
                          const SizedBox(height: 15),
                          const Text("Licença Creative Commons (CC) 2025"),
                          const SizedBox(height: 30),
                          const Divider(),
                          const SizedBox(height: 30),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherHomePage(),
                                ),
                              );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    const WidgetStatePropertyAll(Colors.black),
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                padding: const WidgetStatePropertyAll(
                                    EdgeInsets.all(16)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            child: const Text(
                              "Voltar para o clima",
                            ),
                          ),
                        ])))));
  }
}
