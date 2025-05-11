import 'package:flutter/material.dart';
import 'package:weather_station/domain/usecase/listar_nome_cidades_uc.dart';

class SearchCidadeProvider extends ChangeNotifier {
    
    static SearchCidadeProvider? _searchCidadeProvider;

    static SearchCidadeProvider get getInstance{
      _searchCidadeProvider ??= SearchCidadeProvider(listarNomeCidadesUc: ListarNomeCidadesUc.getInstance);
      return _searchCidadeProvider!;
    }

    void notify() {
    notifyListeners();
  }

  SearchCidadeProvider({ required this.listarNomeCidadesUc
  });

  ListarNomeCidadesUc listarNomeCidadesUc;

  List<String?> _allCidades = [];

  List<String?> get allClimas => _allCidades;

  Future<List<String?>> pesquisarNome(int uf) async {
    _allCidades = [];
    _allCidades = await listarNomeCidadesUc.listar(uf);
    notify();
    return _allCidades ;
  } 

}