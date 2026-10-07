void main() {
  List<int> nums1 = [1, 2, 2, 1];
  List<int> nums2 = [2, 2];

  Map<int, int> frecuencia = {};

  for (int numero in nums1) {
    frecuencia[numero] = (frecuencia[numero] ?? 0) + 1;
  }

  List<int> resultado = [];

  for (int numero in nums2) {
    if ((frecuencia[numero] ?? 0) > 0) {
      resultado.add(numero);
      frecuencia[numero] = frecuencia[numero]! - 1;
    }
  }

  print('nums1: $nums1');
  print('nums2: $nums2');
  print('Intersección: $resultado');
}
