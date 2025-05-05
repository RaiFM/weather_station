import 'package:flutter/foundation.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_lat_lon_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_nome_uc.dart.dart';
import 'package:weather_station/domain/usecase/listar_locais_salvos_uc.dart';
import 'package:weather_station/domain/usecase/salvar_cidade_uc.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';
import 'package:weather_station/infra/service/api_service.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class ClimaProvider extends ChangeNotifier {

  void notify() {
    notifyListeners();
  }

  ListarLocaisPorLatLonUc listarLocaisPorLatLonUc = ListarLocaisPorLatLonUc(iRepositoryApi: RepositoryApi(apiService: ApiService()));
  ListarLocaisPorNomeUc listarLocaisPorNomeUc = ListarLocaisPorNomeUc(iRepositoryApi: RepositoryApi(apiService: ApiService()));
  ListarLocaisSalvosUc listarLocaisSalvosUc = ListarLocaisSalvosUc(iRepositoryClima: RepositoryClimaFirebase(climaService: ClimaService(iRepositoryApi: RepositoryApi(apiService: ApiService()))));

  ExcluirCidadeUc? excluirCidadeUc;
  SalvarCidadeUc? salvarCidadeUc;

  ClimaProvider([this.excluirCidadeUc, this.salvarCidadeUc]);

  List<ClimaModel?> _allClimaPrincipal = [];
  List<ClimaModel?> _allClimaSalvos = [];

  List<ClimaModel?> get allClimas => _allClimaPrincipal;
  List<ClimaModel?> get allClimasSalvos => _allClimaSalvos;

  Future<List<ClimaModel?>> getClimaLatLon(double lat, double lon) async {
  _allClimaPrincipal = [];
  _allClimaPrincipal = await listarLocaisPorLatLonUc.getInstance.buscarPorLatLon(lat, lon);
  notify();
  return _allClimaPrincipal;
}

Future<List<ClimaModel?>> getClimaNome(String nome) async {
  _allClimaPrincipal = [];
  _allClimaPrincipal = await listarLocaisPorNomeUc.getInstance.buscarPorNome(nome);
  notify();
  return _allClimaPrincipal;
}

Future<List<ClimaModel?>> getClimaSalvos() async {
  _allClimaSalvos = [];
  _allClimaSalvos = await listarLocaisSalvosUc.getInstance.buscar();
  notify();
  return _allClimaSalvos;
}

void deletarClima(ClimaModel climaModel) {
  excluirCidadeUc!.getInstance.excluir(climaModel);
  notify();
}

void salvarCidade(ClimaModel climaModel) {
  salvarCidadeUc!.getInstance.salvar(climaModel);
  notify();
}

}
