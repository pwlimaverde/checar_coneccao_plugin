import 'package:checar_coneccao_plugin/src/usecases/checar_coneccao_usecase.dart';
import 'package:checar_coneccao_plugin/src/utilitarios/erros_coneccao.dart';
import 'package:checar_coneccao_plugin/src/utilitarios/tempo_execucao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

class RepositorioMock extends Mock implements Repositorio<bool, NoParams> {}

void main() {
  late Repositorio<bool, NoParams> repositorio;
  late UseCase<bool, NoParams> checarConeccaoUseCase;
  late TempoExecucao tempo;

  setUp(() {
    tempo = TempoExecucao();
    repositorio = RepositorioMock();
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com true', () async {
    tempo.iniciar();
    when(repositorio)
        .calls(#call)
        .thenAnswer((_) => Future.value(SucessoRetorno<bool>(resultado: true)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um ErrorConeccao com Cod.01-2', () async {
    when(repositorio).calls(#call).thenAnswer(
        (_) => Future.value(SucessoRetorno<bool>(resultado: false)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test('Deve retornar um Erro com ErrorConeccao com teste erro datasource',
      () async {
    when(repositorio).calls(#call).thenAnswer((_) => Future.value(
        ErroRetorno<bool>(
            erro: ErrorConeccao(mensagem: "teste erro datasource"))));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErrorConeccao com Erro ao recuperar informação de conexão Cod.01-1',
      () async {
    when(repositorio).calls(#call).thenThrow(Exception());
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    tempo.terminar();
    print("Tempo de execução: ${tempo.calcularExecucao()}ms");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
