class SortingData {
  final Map<String, int> dataSensor;
  final Map<String, int> merah;
  final Map<String, int> hijau;

  SortingData({
    required this.dataSensor,
    required this.merah,
    required this.hijau,
  });

  Map<String, dynamic> toMap() {
    return {
      'data_sensor': dataSensor,
      'data_ukuran_hijau': hijau,
      'data_ukuran_merah': merah,
    };
  }
}

