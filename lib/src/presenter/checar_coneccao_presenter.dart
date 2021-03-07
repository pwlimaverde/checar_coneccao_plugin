import 'package:checar_coneccao_plugin/src/datasources/connectivity_datasource.dart';
import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ChecarConeccaoPresenter {
  final Connectivity? connectivity;
  final bool mostrarTempoExecucao;

  ChecarConeccaoPresenter({
    this.connectivity,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<bool>> consultaConectividade() async {
    final resultado = await RetornoResultadoPresenter<bool>(
      mostrarTempoExecucao: mostrarTempoExecucao,
      nomeFeature: "Checar Conecção",
      datasource: ConnectivityDatasource(
        connectivity: connectivity ?? Connectivity(),
      ),
    ).retornoBool(parametros: NoParams(mensagemErro: "Você está offline"));

    return resultado;
  }
}
