import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../datasources/connectivity_datasource.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../usecases/checar_coneccao_usecase.dart';

class ChecarConeccaoPresenter {
  final Connectivity? connectivity;
  final bool mostrarTempoExecucao;

  ChecarConeccaoPresenter({
    this.connectivity,
    required this.mostrarTempoExecucao,
  });

  Future<RetornoSucessoOuErro<bool>> consultaConectividade() async {
    TempoExecucao tempo = TempoExecucao();
    if (mostrarTempoExecucao) {
      tempo.iniciar();
    }
    RetornoSucessoOuErro<bool> resultado = await ChecarConeccaoUsecase(
      repositorio: ChecarConeccaoRepositorio(
        datasource: ConnectivityDatasource(
          connectivity: connectivity ?? Connectivity(),
        ),
      ),
    )(parametros: NoParams());
    if (mostrarTempoExecucao) {
      tempo.terminar();
      print(
          "Tempo de Execução do ChecarConeccaoPresenter: ${tempo.calcularExecucao()}ms");
    }
    return resultado;
  }
}
