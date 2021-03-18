import 'package:return_success_or_error/return_success_or_error.dart';

class ErroConexao implements AppError {
  String message;

  ErroConexao({required this.message});

  @override
  String toString() {
    return message;
  }
}
