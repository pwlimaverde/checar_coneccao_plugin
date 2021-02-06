class TempoExecucao {
  int inicio = 0;
  int fim = 0;
  void iniciar() {
    inicio = DateTime.now().millisecond;
  }

  void terminar() {
    fim = DateTime.now().millisecond;
  }

  int calcularExecucao() {
    return fim - inicio;
  }
}
