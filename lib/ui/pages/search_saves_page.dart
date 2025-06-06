import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_salvos_uc.dart';
import 'package:weather_station/domain/usecase/listar_nome_cidades_uc.dart';
import 'package:weather_station/ui/pages/weather_home_page.dart';

class SearchSavesPage extends StatefulWidget {
  const SearchSavesPage({super.key});

  @override
  State<SearchSavesPage> createState() => _SearchSavesPageState();
}

class _SearchSavesPageState extends State<SearchSavesPage> {
  String _ufString = "UF";
  final _dropDownItems = ListarNomeCidadesUc.getInstance.ufsNumber;
  final _listarCidadesUcFunction = ListarNomeCidadesUc.getInstance.listar;
  final _listarSalvosUcItems = ListarLocaisSalvosUc.getInstance.buscar;
  final _excluirUc = ExcluirCidadeUc.getInstance;

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
      child: Scaffold(
        body: SafeArea(
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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  DropdownButton(
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      dropdownColor: const Color.fromARGB(137, 180, 180, 180),
                      isDense: true,
                      alignment: Alignment.centerLeft,
                      hint: Text(_ufString),
                      value: _ufString,
                      items: _dropDownItems.keys.map((keys) {
                        return DropdownMenuItem(value: keys, child: Text(keys));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _ufString = value.toString();
                        });
                      }),
                  const SizedBox(height: 28),
                  SearchAnchor.bar(
                    barPadding: const WidgetStatePropertyAll(
                        EdgeInsetsDirectional.all(8)),
                    barHintText: "Pesquise o clima de uma cidade",
                    onTap: () {
                      if (_ufString == "UF") {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Atenção"),
                                content:
                                    Text("Selecione uma UF para pesquisar"),
                              );
                            });
                      }
                    },
                    suggestionsBuilder: (BuildContext context,
                        SearchController searchController) async {
                      final String input = searchController.value.text;
                      int ufInput = 0;

                      if (_ufString != "UF") {
                        ufInput = _dropDownItems[_ufString]!;
                      }
                      List<String> cidades = [];
                      try {
                        cidades = await _listarCidadesUcFunction(ufInput);
                      } catch (e) {
                        return [
                          const ListTile(
                              title: Text("Erro ao procurar cidades :/"))
                        ];
                      }
                      if (cidades.isEmpty) {
                        return [
                          const ListTile(
                            autofocus: true,
                            title: Text("Selecione uma UF para pesquisar"),
                          ),
                        ];
                      }

                      final filtered = cidades
                          .where((cidade) => cidade.contains(input))
                          .toList();
                      return filtered.map((cidade) {
                        return ListTile(
                          title: Text(cidade),
                          onTap: () {
                            searchController.closeView(cidade);
                            searchController.clear();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WeatherHomePage(
                                  cidade: cidade,
                                ),
                              ),
                            );
                          },
                        );
                      });
                    },
                  ),
                        const SizedBox(height: 10),
                  const Divider(),
                  Flexible(
                    child: FutureBuilder(
                        future: _listarSalvosUcItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    "Erro encontrando os locais salvos: ${snapshot.error}"));
                          } else if (!snapshot.hasData) {
                            return const Center(
                                child: Text(
                                    "NÃO FOI POSSÍVEL RETORNAR NENHUMA CIDADES!",
                                    style: TextStyle(color: Colors.white)));
                          }
                          final listaSalvos = snapshot.data;
                          if (listaSalvos!.isEmpty)
                            return const Center(
                                child: Text("VOCÊ NÃO POSSUI CIDADES SALVAS!",
                                    style: TextStyle(color: Colors.white)));
                          return ListView.builder(
                              itemCount: listaSalvos.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var listTile = ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,                           
                                      MaterialPageRoute(
                                        builder: (context) => WeatherHomePage(
                                          cidade:  listaSalvos[index]!.nome,
                                        ),
                                      ),
                                    );
                                  },
                                  onLongPress: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Tem certeza que deseja excluir este local salvo?"),
                                          content: const Text(
                                              "Confirmar esta ação excluirá a cidade da sua lista de salvos e você precisará adicioná-la de novo."),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                _excluirUc.excluir(
                                                    listaSalvos[index]!.nome);
                                                Navigator.pop(context);
                                                // Fecha o dialog depois de excluir
                                                setState(() {
                                                  listaSalvos.removeAt(index);
                                                });
                                              },
                                              child: const Text("Excluir"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancelar"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  leading: const Padding(
                                    padding: EdgeInsets.only(
                                        right: 8.0), // margem à esquerda
                                    child: Icon(
                                      Icons.location_city,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  title: Text(
                                    listaSalvos[index]!.nome,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    "${listaSalvos[index]!.precipitacao.toStringAsFixed(0)}% de chuva |  "
                                    "${listaSalvos[index]!.tempMin.toStringAsFixed(1)}ºC - "
                                    "${listaSalvos[index]!.tempMax.toStringAsFixed(1)}ºC",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: Text(
                                    "${listaSalvos[index]!.temperatura.toStringAsFixed(1)}ºC",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                  horizontalTitleGap: 2,
                                );
                                return listTile;
                              });
                        }),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            )),
                      ),
                      child: const Text("Voltar")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
