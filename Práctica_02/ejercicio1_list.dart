void main() {
  List<int> lista1 = [1, 2, 4];
  List<int> lista2 = [1, 3, 4];

  List<int> resultado = [...lista1, ...lista2];

  resultado.sort();

  print('Lista 1: $lista1');
  print('Lista 2: $lista2');
  print('Resultado: $resultado');
}
