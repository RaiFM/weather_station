import 'package:weather_station/domain/model/clima_model.dart';

abstract class IRepositoryClima{
  void salvarLocalizacao(ClimaModel climaModel);
  List<ClimaModel?> listarLugaresSalvos();
}