import 'package:weather_station/interfaces/i_repository_clima.dart';
import 'package:weather_station/model/clima_model.dart';

class RepositoryClimaFirebase implements IRepositoryClima {
  @override
  void deleteLastDay(String id) {
  
  }

  @override
  void insertLastDay(ClimaModel climaModel) {

  }

  @override
  List<ClimaModel?> listarLugaresSalvos() {
   
    throw UnimplementedError();
  }

  @override
  void salvarLocalizacao(ClimaModel climaModel) {
  }


}