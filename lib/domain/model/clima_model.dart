import 'dart:ffi';

class ClimaModel {
  String nome;
  String diaSemana;
  int temperatura;
  String descriptionClima;
  String data;
  int tempMin;
  int tempMax;
  String icone;
  int umidade;
  int precipitacao;
  String velocidadeVento;
  String direcaoVento;
  String cardinalVento;
  String nascerSol;
  String  porSol;
  String  faseLua;
  String  fusoHorario;


  ClimaModel({
    required this.nome,
    required this.diaSemana,
    required this.temperatura,
    required this.descriptionClima,
    required this.data,
    required this.tempMin,
    required this.tempMax,
    required this.icone,
    required this.precipitacao,
    required this.umidade,
    required this.velocidadeVento, 
    required this.direcaoVento, 
    required this.cardinalVento, 
    required this.nascerSol, 
    required this.porSol, 
    required this.faseLua, 
    required this.fusoHorario,
  } 
  );

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
      precipitacao: json['rain'] ?? 0, 
      umidade:  json['humidity'],
      velocidadeVento: json['wind_speedy'] ?? 0,
      direcaoVento: json['wind_direction'] ?? 0,
      cardinalVento: json['wind_cardinal'] ?? '',
      nascerSol: json['sunrise'] ?? '',
      porSol: json['sunset'] ?? '',
      faseLua: json['moon_phase'] ?? 'Sem descrição',
      fusoHorario: json['timezone'] ?? 0,

    );
  } 
  }
