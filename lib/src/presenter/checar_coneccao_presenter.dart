import 'package:checar_coneccao_plugin/src/utilitarios/tempo_execucao.dart';
import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../usecases/checar_coneccao_usecase.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../datasources/connectivity_datasource.dart';

class ChecarConeccaoPresenter {
  final Connectivity? connectivity;
  final bool? mostrarTempoExecucao;

  ChecarConeccaoPresenter({this.connectivity, this.mostrarTempoExecucao});

  Future<RetornoSucessoOuErro<bool>> consultaConectividade() async {
    TempoExecucao tempo = TempoExecucao();
    tempo.iniciar();
    RetornoSucessoOuErro<bool> resultado = await ChecarConeccaoUsecase(
      repositorio: ChecarConeccaoRepositorio(
        datasource: ConnectivityDatasource(
          connectivity: connectivity ?? Connectivity(),
        ),
      ),
    )(parametros: NoParams());
    if (mostrarTempoExecucao ?? false) {
      tempo.terminar();
      print(
          "Tempo de Execução do ChecarConeccaoPresenter: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }
}
