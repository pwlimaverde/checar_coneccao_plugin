import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

import '../utilitarios/erros_coneccao.dart';

class ChecarConeccaoUsecase extends UseCase<bool, NoParams> {
  final Repositorio<bool, NoParams> repositorio;

  ChecarConeccaoUsecase({required this.repositorio});

  @override
  Future<RetornoSucessoOuErro<bool>> call(
      {required NoParams parametros}) async {
    final resultado = await retornoRepositorio(
      repositorio: repositorio,
      erro: ErrorConeccao(
          mensagem: "Erro ao recuperar informação de conexão Cod.01-1"),
      parametros: NoParams(),
    );
    if (resultado is SucessoRetorno<bool>) {
      if (!resultado.resultado) {
        return ErroRetorno(
          erro: ErrorConeccao(
            mensagem: "Você está offline Cod.01-2",
          ),
        );
      }
    }
    return resultado;
  }
}
