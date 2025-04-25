import 'package:flutter/material.dart';
import 'package:weather_station/domain/usecase/listar_nome_cidades_uc.dart';

class SearchCidadeProvider extends ChangeNotifier {
    void notify() {
    notifyListeners();
  }

  SearchCidadeProvider({ required this.listarNomeCidadesUc
  });

  ListarNomeCidadesUc listarNomeCidadesUc;

  List<String?> _allCidades = [];

  List<String?> get allClimas => _allCidades;

  Future<List<String?>> pesquisarNome(int uf) async {
    return _allCidades = await listarNomeCidadesUc.getInstance.listar(uf);
  } 

}