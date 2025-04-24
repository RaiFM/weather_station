import 'package:geolocator/geolocator.dart';

class ClimaController {

  Future<Position> posicaoAtual() async {
    bool localizacaoAtiva;
    LocationPermission locationPermission;

    localizacaoAtiva = await Geolocator.isLocationServiceEnabled();
    if (!localizacaoAtiva) {
      return Future.error('Serviço de localização desativado');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Serviço de localização indisponivel");
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }


}
