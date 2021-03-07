import 'package:checar_coneccao_plugin/src/utilitarios/erros_coneccao.dart';
import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ConnectivityDatasource implements Datasource<bool, NoParams> {
  final Connectivity connectivity;
  ConnectivityDatasource({required this.connectivity});

  Future<bool> get isOnline async {
    var result = await connectivity.checkConnectivity();
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile;
  }

  @override
  Future<bool> call({required NoParams parametros}) async {
    try {
      final result = await isOnline;
      if (!result) {
        throw ErrorConeccao(mensagem: "${parametros.mensagemErro}");
      }
      return result;
    } catch (e) {
      throw ErrorConeccao(mensagem: "${parametros.mensagemErro}");
    }
  }
}
