import 'package:checar_coneccao_plugin/src/datasources/connectivity_datasource.dart';
import 'package:checar_coneccao_plugin/src/utilitarios/erros_coneccao.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ChecarConeccaoMock extends Mock implements Connectivity {}

void main() {
  late Connectivity data;
  late Datasource<bool, NoParams> datasource;

  setUp(() {
    data = ChecarConeccaoMock();
    datasource = ConnectivityDatasource(connectivity: data);
  });

  test('Deve retornar um sucesso com true conecção wifi', () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(Future.value(ConnectivityResult.wifi)));
    final result = await datasource(
        parametros: NoParams(mensagemErro: "Erro ao Checar a Conecção"));
    print("teste result - $result");
    expect(result, equals(true));
  });

  test('Deve retornar um sucesso com true conecção moble', () async {
    when(data).calls(#checkConnectivity).thenAnswer(
        (_) => Future.value(Future.value(ConnectivityResult.mobile)));
    final result = await datasource(
        parametros: NoParams(mensagemErro: "Erro ao Checar a Conecção"));
    print("teste result - $result");
    expect(result, equals(true));
  });

  test(
      'Deve retornar um ErroRetorno com Você está offline Cod.02-1 conecção none',
      () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(Future.value(ConnectivityResult.none)));
    expect(
        () async => await datasource(
              parametros: NoParams(mensagemErro: "Você está offline"),
            ),
        throwsA(isA<ErrorConeccao>()));
  });

  test('Deve retornar um ErroRetorno com Você está offline Cod.02-1 Exeption',
      () async {
    when(data).calls(#checkConnectivity).thenThrow(Exception());
    expect(
        () async => await datasource(
              parametros: NoParams(mensagemErro: "Você está offline"),
            ),
        throwsA(isA<ErrorConeccao>()));
  });
}
