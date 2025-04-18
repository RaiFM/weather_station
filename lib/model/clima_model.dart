
class ClimaModel {
  String nome;
  String diaSemana;
  int temperatura;
  String descriptionClima;
  String data;
  int tempMin;
  int tempMax;
  String icone;


  ClimaModel(
      {required this.nome,
      required this.diaSemana,
      required this.temperatura,
      required this.descriptionClima,
      required this.data,
      required this.tempMin,
      required this.tempMax,
      required this.icone,
  
      });

    factory ClimaModel.fromJson(Map<String, dynamic> json) {
    return ClimaModel(
      nome: json['nome'],
      data: json['date'],
      temperatura: json['temperatura'],
      descriptionClima: json['descriptionClima'],
      diaSemana: json['diaSemana'],
      tempMax: json['tempMax'],
      tempMin: json['mintempMin'],
      icone: json['icone']
    );
  }

}
