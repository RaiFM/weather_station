import 'package:weather_station/domain/model/clima_model.dart';

abstract class IRepositoryClima{
  void salvarCidade(ClimaModel climaModel);
  Future<List<ClimaModel?>> listarLugaresSalvos();
  void excluirCidade(String nome);
}