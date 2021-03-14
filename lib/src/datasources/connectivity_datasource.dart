import 'package:checar_coneccao_plugin/src/utilitarios/erros_coneccao.dart';
import 'package:connectivity/connectivity.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

class ConnectivityDatasource implements Datasource<bool, NoParams> {
  final Connectivity connectivity;
  ConnectivityDatasource({required this.connectivity});

  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<bool> call({required NoParams parameters}) async {
    try {
      final result = await isOnline;
      if (!result) {
        throw ErrorConeccao(mensagem: "${parameters.messageError}");
      }
      return result;
    } catch (e) {
      throw ErrorConeccao(mensagem: "${parameters.messageError}");
    }
  }
}
