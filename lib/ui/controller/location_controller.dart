import 'package:geolocator/geolocator.dart';

class LocationController {
  
  Future<Position> posicaoAtual() async {
    bool localizacaoAtiva;
    LocationPermission locationPermission;
    int retryCount = 0;
    const int maxRetries = 3;

    localizacaoAtiva = await Geolocator.isLocationServiceEnabled();

    while (!localizacaoAtiva) {
      // Solicitar ao usuário que ative o serviço de localização
      await Geolocator.openLocationSettings();
      localizacaoAtiva = await Geolocator.isLocationServiceEnabled();
      if (!localizacaoAtiva && retryCount < maxRetries) {
        retryCount++;
        await Future.delayed(const Duration(seconds: 5));
        continue;
      } else {
        break;
      }
    }

    if (!localizacaoAtiva) {
      return Future.error("Serviço de localização indisponivel");
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
