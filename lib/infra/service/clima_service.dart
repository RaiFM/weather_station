import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/external/firestore_db.dart';

class ClimaService {
      static ClimaService? _climaService;
      ClimaService get getInstance{
        _climaService ??= ClimaService();
        return _climaService!;
      }        

    final db = FirestoreDB.getInstance;

                                                                                                                                                    void salvarCidade(String nomeCidade) async {
  final cidadeMap = <String, String>{
    "nomeCidade": nomeCidade,
  };

 try {
    print("Cidade salva com sucesso");
    await db.collection("climaAPP").add(cidadeMap); 
  } catch (e) {
    print("Erro ao adicionar cidade: $e");
  }


}
                                                                      
}