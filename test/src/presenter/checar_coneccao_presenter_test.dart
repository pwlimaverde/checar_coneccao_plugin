import 'package:checar_coneccao_plugin/src/presenter/checar_coneccao_presenter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ChecarConeccao extends Mock implements Connectivity {}

void main() {
  late Connectivity data;

  setUp(() {
    data = ChecarConeccao();
  });

  test('Deve retornar um sucesso com true Coneção wifi', () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(ConnectivityResult.wifi));
    final result = await ChecarConeccaoPresenter(
      connectivity: data,
      mostrarTempoExecucao: true,
    ).consultaConectividade();
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test('Deve retornar um sucesso com true Coneção mobile', () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(ConnectivityResult.mobile));
    final result = await ChecarConeccaoPresenter(
      connectivity: data,
      mostrarTempoExecucao: true,
    ).consultaConectividade();
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<SucessoRetorno<bool>>());
  });

  test(
      'Deve retornar um ErroRetorno com Você está offline Cod.02-1 Coneção none',
      () async {
    when(data)
        .calls(#checkConnectivity)
        .thenAnswer((_) => Future.value(ConnectivityResult.none));
    final result = await ChecarConeccaoPresenter(
      connectivity: data,
      mostrarTempoExecucao: true,
    ).consultaConectividade();
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });

  test('Deve retornar um ErroRetorno com Você está offline Cod.02-1 Exeption',
      () async {
    when(data).calls(#checkConnectivity).thenThrow(Exception());
    final result = await ChecarConeccaoPresenter(
            connectivity: data, mostrarTempoExecucao: true)
        .consultaConectividade();
    print("teste result - ${result.fold(
      sucesso: (value) => value.resultado,
      erro: (value) => value.erro,
    )}");
    expect(result, isA<ErroRetorno<bool>>());
  });
}
