class ClimaModel {
  String nome;
  String diaSemana;
  int temperatura;
  String descriptionClima;
  String data;
  int tempMin;
  int tempMax;
  String icone;

  ClimaModel({
    required this.nome,
    required this.diaSemana,
    required this.temperatura,
    required this.descriptionClima,
    required this.data,
    required this.tempMin,
    required this.tempMax,
    required this.icone,
  });

  factory ClimaModel.fromJson(Map<String, dynamic> json) {
    // Verificando se os dados do JSON têm o formato correto
    return ClimaModel(
      nome: json['city_name'] ?? 'Cidade não disponível',  
      data: json['date'] ?? 'Data não disponível',        
      temperatura: json['temp'] ?? 0,
      descriptionClima: json['description'] ?? 'Sem descrição',  
      diaSemana: json['weekday'] ?? 'Dia não disponível',  
      tempMax: json['max'] ?? 0,  
      tempMin: json['min'] ?? 0,  
      icone: json['img_id'] ?? '',  
    );
  } 
  }
