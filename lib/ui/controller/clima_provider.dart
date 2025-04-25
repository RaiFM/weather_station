import 'package:flutter/foundation.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_lat_lon_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_nome_uc.dart.dart';
import 'package:weather_station/domain/usecase/listar_locais_salvos_uc.dart';
import 'package:weather_station/domain/usecase/salvar_cidade_uc.dart';

class ClimaProvider extends ChangeNotifier {
  void notify() {
    notifyListeners();
  }

  ListarLocaisPorLatLonUc listarLocaisPorLatLonUc;
  ListarLocaisPorNomeUc listarLocaisPorNomeUc;
  ListarLocaisSalvosUc listarLocaisSalvosUc;

  ExcluirCidadeUc excluirCidadeUc;
  SalvarCidadeUc salvarCidadeUc;

  ClimaProvider(
      {required this.listarLocaisPorLatLonUc,
      required this.listarLocaisPorNomeUc,
      required this.listarLocaisSalvosUc,
      required this.excluirCidadeUc,
      required this.salvarCidadeUc});

  List<ClimaModel?> _allClimaPrincipal = [];
  List<ClimaModel?> _allClimaSalvos = [];

  List<ClimaModel?> get allClimas => _allClimaPrincipal;
  List<ClimaModel?> get allClimasSalvos => _allClimaSalvos;

  Future<List<ClimaModel?>> getClimaLatLon(double lat, double lon) async {
    _allClimaPrincipal = [];
    return _allClimaPrincipal =
        await listarLocaisPorLatLonUc.getInstance.buscarPorLatLon(lat, lon);
  }

  Future<List<ClimaModel?>> getClimaNome(String nome) async {
    _allClimaPrincipal = [];
    return _allClimaPrincipal =
        await listarLocaisPorNomeUc.getInstance.buscarPorNome(nome);
  }

  Future<List<ClimaModel?>> getClimaSalvos() async {
    _allClimaSalvos = [];
    return _allClimaSalvos = await listarLocaisSalvosUc.getInstance.buscar();
  }

  void deletarClima(ClimaModel climaModel) {
    excluirCidadeUc.getInstance.excluir(climaModel);
  }

  void salvarCidade(ClimaModel climaModel) {
    salvarCidadeUc.getInstance.salvar(climaModel);
  }
}
