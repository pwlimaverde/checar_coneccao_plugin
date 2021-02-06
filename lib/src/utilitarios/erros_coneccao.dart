import 'package:retorno_sucesso_ou_erro_package/retorno_sucesso_ou_erro_package.dart';

class ErrorConeccao implements AppErro {
  final String mensagem;
  ErrorConeccao({required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}
