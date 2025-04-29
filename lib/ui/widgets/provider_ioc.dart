
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:weather_station/ui/controller/clima_provider.dart';

class ProviderIoc extends StatefulWidget {
  Widget obj;
  ProviderIoc({required this.obj});

  static ClimaProvider _getObj(Widget obj){
    ClimaProvider provider = Provider.of<ClimaProvider>(context, listen: false);

}}

class ProviderIoc extends StatefulWidget {
  const ProviderIoc({super.key});

  @override
  State<ProviderIoc> createState() => _ProviderIocState();
}

class _ProviderIocState extends State<ProviderIoc> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}