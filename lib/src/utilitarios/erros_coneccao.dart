import 'package:return_success_or_error/return_success_or_error.dart';

class ErrorConeccao implements AppError {
  final String mensagem;
  ErrorConeccao({required this.mensagem});

  @override
  String toString() {
    return "ErrorConeccao - $mensagem";
  }
}
