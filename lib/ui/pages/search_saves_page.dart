import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_salvos_uc.dart';
import 'package:weather_station/domain/usecase/listar_nome_cidades_uc.dart';

class SearchSavesPage extends StatefulWidget {
  const SearchSavesPage({super.key});

  @override
  State<SearchSavesPage> createState() => _SearchSavesPageState();
}

class _SearchSavesPageState extends State<SearchSavesPage>{
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  DropdownButton(
                  hint: Text("UF"),
                  value:_ufString,
                  items: _dropDownItems.keys.map((keys){
                    return DropdownMenuItem(value: keys,child: Text(keys));
                  }).toList(),
                  onChanged: (value){
                    _ufString = value.toString();
                  }),
                  SearchAnchor.bar(
                    barHintText: "Pesquise o clima de uma cidade",
                    suggestionsBuilder: (BuildContext context, SearchController searchController) async {
                    final String input = searchController.value.text;
                    int ufInput = 0;
                    
                    if(_ufString != "UF"){ 
                      ufInput = _dropDownItems[_ufString]!;
                    }
                    List<String> cidades = [];
                    try{
                    cidades = await _listarCidadesUcFunction(ufInput);}
                    catch(e){
                      return [const ListTile(title:Text("Erro ao procurar cidades :/"))];
                    }
                    if(cidades.isEmpty){
                        return [
                          const ListTile(autofocus: true, title: Text("Nenhuma UF Selecionada."))
                        ];
                      }
        
                    final filtered = cidades.where((cidade)=>cidade.contains(input)).toList();
                    return filtered.map((cidade){
                      return ListTile(
                        title:Text(cidade),
                        onTap: (){
                          searchController.closeView(cidade);
                          searchController.clear();
                        },
                      );
                    });
                  }),
                  const Divider(),
                  Flexible(
                    child: FutureBuilder(
                      future: _listarSalvosUcItems(),
                      builder: (context,snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting)
                        {
                          const Center(child: CircularProgressIndicator(),);
                        }
                        else if(snapshot.hasError){
                          const Center(child: Text("Erro encontrando os locais salvos."));
                        } else if (snapshot.data!.isEmpty || !snapshot.hasData){
                          const Center(child: Text("Nenhuma cidade salva."));
                        }
                        final listaSalvos = snapshot.data;
                        return ListView.builder(
                          itemCount: listaSalvos!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                          return ListTile(
                            onLongPress: () {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: const Text("Tem certeza que deseja excluir este local salvo?"),
                                  content: const Text("Confirmar esta ação excluirá a cidade da sua lista de salvos e você precisará adicioná-la de novo."),
                                  actions: [
                                    TextButton(onPressed: (){
                                      _excluirUc.excluir(listaSalvos[index]!.nome);                                  
                                    }, child: const Text("Excluir")),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: const Text("Cancelar")),
                                  ],
                                );
                              });
                            },
                            leading: const Icon(Icons.location_city),
                            title: Text(listaSalvos![index]!.nome),
                            horizontalTitleGap: 2,
                            subtitle: Text("${listaSalvos[index]!.temperatura}ºC \n ${listaSalvos[index]!.tempMax}ºC - ${listaSalvos[index]!.tempMin}ºC  |  ${listaSalvos[index]!.precipitacao}% de chuva"),
                          );
                        });
                      }
                    ),
                  )
                ],
              )))),
      ));
  }
}