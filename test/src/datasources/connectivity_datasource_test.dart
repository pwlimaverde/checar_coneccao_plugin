import 'package:checar_coneccao_plugin/src/datasources/connectivity_datasource.dart';
import 'package:checar_coneccao_plugin/src/repositories/checar_coneccao_repository.dart';
import 'package:checar_coneccao_plugin/src/usecases/checar_coneccao_usecase.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';
import 'package:retorno_sucesso_ou_erro_package/src/repositorio.dart';

class ChecarConeccaoMock extends Mock implements Connectivity {}

void main() {
  late Connectivity data;
  late Datasource<bool, NoParams> datasource;
  late Repositorio<bool, NoParams> repositorio;
  late UseCase<bool, NoParams> checarConeccaoUseCase;

  setUp(() {
    data = ChecarConeccaoMock();
    datasource = ConnectivityDatasource(connectivity: data);
    repositorio = ChecarConeccaoRepositorio(datasource: datasource);
    checarConeccaoUseCase = ChecarConeccaoUsecase(repositorio: repositorio);
  });

  test('Deve retornar um sucesso com true conecção wifi', () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(Future.value(ConnectivityResult.wifi)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com true conecção moble', () async {
    when(data).calls(#checkConnectivity).thenAnswer(
        (_) => Future.value(Future.value(ConnectivityResult.mobile)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um ErrorConeccao com Cod.01-2', () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(Future.value(ConnectivityResult.none)));
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test(
      'Deve retornar um ErrorConeccao com Erro ao recuperar informação de conexão Cod.02-1',
      () async {
    when(data).calls(#checkConnectivity).thenThrow(Exception());
    final result = await checarConeccaoUseCase(parametros: NoParams());
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
