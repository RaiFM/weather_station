import 'package:weather_station/model/clima_model.dart';

abstract class IRepositoryClima{
  void insertLastDay(ClimaModel climaModel);
  void deleteLastDay(String id);
  void salvarLocalizacao(ClimaModel climaModel);
  List<ClimaModel?> listarLugaresSalvos();
}