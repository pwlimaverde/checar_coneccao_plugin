import 'package:checar_coneccao_plugin/src/repositories/checar_coneccao_repository.dart';
import 'package:checar_coneccao_plugin/src/usecases/checar_coneccao_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

class ConnectivityDatasourceMock extends Mock
    implements Datasource<bool, NoParams> {}

void main() {
  late Datasource<bool, NoParams> datasource;
  late Repositorio<bool, NoParams> repositorio;
  late UseCase<bool, NoParams> checarConeccaoUseCase;

  setUp(() {
    datasource = ConnectivityDatasourceMock();
    repositorio = ChecarConeccaoRepositorio(datasource: datasource);
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com true', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(true));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um ErrorConeccao com Cod.01-2', () async {
    when(datasource).calls(#call).thenAnswer((_) => Future.value(false));
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
    when(datasource).calls(#call).thenThrow(Exception());
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
