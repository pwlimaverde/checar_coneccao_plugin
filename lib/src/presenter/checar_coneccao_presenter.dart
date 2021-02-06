import 'package:connectivity/connectivity.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../usecases/checar_coneccao_usecase.dart';
import '../repositories/checar_coneccao_repository.dart';
import '../datasources/connectivity_datasource.dart';

class ChecarConeccaoPresenter {
  Future<RetornoSucessoOuErro<bool>> consultaConectividade() async {
    RetornoSucessoOuErro<bool> resultado = await ChecarConeccaoUsecase(
      repositorio: ChecarConeccaoRepositorio(
        datasource: ConnectivityDatasource(
          connectivity: Connectivity(),
        ),
      ),
    )(parametros: NoParams());
    return resultado;
  }
}
