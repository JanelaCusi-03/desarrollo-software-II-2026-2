void main() {
  List<int> frutas = [4, 2, 5];
  List<int> cestas = [3, 5, 4];

  int sinColocar = 0;

  for (int fruta in frutas) {
    bool colocada = false;

    for (int i = 0; i < cestas.length; i++) {
      if (cestas[i] >= fruta) {
        cestas[i] = -1;
        colocada = true;
        break;
      }
    }

    if (!colocada) {
      sinColocar++;
    }
  }

  print('Frutas: $frutas');
  print('Cestas: [3, 5, 4]');
  print('Tipos de fruta sin colocar: $sinColocar');
}
