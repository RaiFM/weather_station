import 'package:flutter/foundation.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/domain/usecase/excluir_cidade_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_lat_lon_uc.dart';
import 'package:weather_station/domain/usecase/listar_locais_nome_uc.dart.dart';
import 'package:weather_station/domain/usecase/listar_locais_salvos_uc.dart';
import 'package:weather_station/domain/usecase/salvar_cidade_uc.dart';

class ClimaProvider extends ChangeNotifier {
  static ClimaProvider? _climaProvider;

  static ClimaProvider get getInstance {
    _climaProvider ??= ClimaProvider(
        excluirCidadeUc: ExcluirCidadeUc.getInstance,
        listarLocaisPorNomeUc: ListarLocaisPorNomeUc.getInstance,
        listarLocaisPorLatLonUc: ListarLocaisPorLatLonUc.getInstance,
        listarLocaisSalvosUc: ListarLocaisSalvosUc.getInstance,
        salvarCidadeUc: SalvarCidadeUc.getInstance);
    return _climaProvider!;
  }

  void notify() {
    notifyListeners();
  }

  ListarLocaisPorLatLonUc listarLocaisPorLatLonUc;
  ListarLocaisPorNomeUc listarLocaisPorNomeUc;
  ListarLocaisSalvosUc listarLocaisSalvosUc;
  ExcluirCidadeUc excluirCidadeUc;
  SalvarCidadeUc salvarCidadeUc;

  ClimaProvider(
      {required this.excluirCidadeUc,
      required this.listarLocaisPorLatLonUc,
      required this.listarLocaisPorNomeUc,
      required this.listarLocaisSalvosUc,
      required this.salvarCidadeUc});

  //Estados privados de Carregamento & Mensagens de Erro
  bool _isLoadingPrincipal = false; 
  bool _isLoadingSalvos = false; 
  String? _errorMessagePrincipal; 
  String? _errorMessageSalvos; 

  // Getters para acessar o estado privado do ViewModel pela View
  bool get isLoadingPrincipal => _isLoadingPrincipal;
  bool get isLoadingSalvos => _isLoadingSalvos;
  String? get errorMessagePrincipal => _errorMessagePrincipal;
  String? get errorMessageSalvos => _errorMessageSalvos;

  //Listas privadas observadas pelos get's
  List<ClimaModel?> _allClimaPrincipal = [];
  List<ClimaModel?> _allClimaSalvos = [];

  //Getters capturados pelos Consumer's e Selector's, pela UI
  List<ClimaModel?> get allClimas => _allClimaPrincipal;
  List<ClimaModel?> get allClimasSalvos => _allClimaSalvos;

  //Capturar clima por meio de lat, long
  Future<void> getClimaLatLon(double lat, double lon) async {
    _allClimaPrincipal = [];
    final result = await listarLocaisPorLatLonUc.buscarPorLatLon(lat, lon);
    _allClimaPrincipal = result;
    notify();
  }

  //Capturar clima por meio de nome
  Future<void> getClimaNome(String nome) async {
    _allClimaPrincipal = [];
    final result = await listarLocaisPorNomeUc.buscarPorNome(nome);
    _allClimaPrincipal = result;
    notify();
  }

  Future<void> getClimaSalvos() async {
    _allClimaSalvos = [];
    final result = await listarLocaisSalvosUc.buscar();
    _allClimaSalvos =  result;
    notify();
  }

  void deletarClima(String nome) {
    excluirCidadeUc.excluir(nome);
    notify();
  }

  void salvarCidade(ClimaModel climaModel) {
    salvarCidadeUc.salvar(climaModel);
    notify();
  }
}
