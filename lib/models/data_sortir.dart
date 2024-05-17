class SortingData {
  final Map<String, int> dataSensor;
  final Map<String, int> merah;
  final Map<String, int> hijau;
  final int totalDataSensor;
  final Map<String, int> totalDataUkuran;
  final int totalDataSortir;
  final int bulan;
  final int tahun;

  SortingData({
    required this.dataSensor,
    required this.merah,
    required this.hijau,
    required this.totalDataSensor,
    required this.totalDataUkuran,
    required this.totalDataSortir,
    required this.bulan,
    required this.tahun,
  });

  Map<String, dynamic> toMap() {
    return {
      'data_sensor': dataSensor,
      'data_ukuran_merah': merah,
      'data_ukuran_hijau': hijau,
      'total_data_sensor': totalDataSensor,
      'total_data_ukuran': totalDataUkuran,
      'total_data_sortir': totalDataSortir,
      'bulan': bulan,
      'tahun': tahun
    };
  }
}
