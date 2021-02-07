import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../utilitarios/erros_coneccao.dart';

class ChecarConeccaoRepositorio extends Repositorio<bool, NoParams> {
  final Datasource<bool, NoParams> datasource;

  ChecarConeccaoRepositorio({required this.datasource});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    final resultado = await retornoDatasource(
      datasource: datasource,
      erro: ErrorConeccao(
        mensagem: "Erro ao recuperar informação de conexão Cod.02-1",
      ),
      parametros: NoParams(),
    );
    return resultado;
  }
}
