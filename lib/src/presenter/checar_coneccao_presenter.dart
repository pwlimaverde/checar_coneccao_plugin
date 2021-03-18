import 'package:checar_coneccao_plugin/src/core/erros.dart';
import 'package:connectivity/connectivity.dart';
import 'package:return_success_or_error/return_success_or_error.dart';

import '../datasources/connectivity_datasource.dart';

class ChecarConeccaoPresenter {
  final Connectivity? connectivity;
  final bool mostrarTempoExecucao;

  ChecarConeccaoPresenter({
    this.connectivity,
    required this.mostrarTempoExecucao,
  });

  Future<ReturnSuccessOrError<bool>> consultaConectividade() async {
    final resultado = await ReturnResultPresenter<bool>(
      showRuntimeMilliseconds: mostrarTempoExecucao,
      nameFeature: "Checar Conecção",
      datasource: ConnectivityDatasource(
        connectivity: connectivity ?? Connectivity(),
      ),
    )(
      parameters: NoParams(
        error: ErroConexao(
          message: "Você está offline",
        ),
      ),
    );

    return resultado;
  }
}
