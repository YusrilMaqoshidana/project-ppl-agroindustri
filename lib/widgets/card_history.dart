import 'package:flutter/material.dart';

class CardHistoryWidget extends StatefulWidget {
  const CardHistoryWidget(
      {super.key,
      required this.persentaseMerah,
      required this.persentaseHijau,
      required this.jumlahBiji,
      required this.totalJumlahBiji,
      required this.ukuranMerah,
      required this.ukuranHijau,
      required this.totalBeratMerah,
      required this.totalBeratHijau,
      required this.totalHasilSortir});
  final int persentaseMerah;
  final int persentaseHijau;
  final Map<String, dynamic> jumlahBiji;
  final int totalJumlahBiji;
  final Map<String, dynamic> ukuranHijau;
  final Map<String, dynamic> ukuranMerah;
  final int totalBeratMerah;
  final int totalBeratHijau;
  final int totalHasilSortir;

  @override
  State<CardHistoryWidget> createState() => _CardHistoryWidgetState();
}

class _CardHistoryWidgetState extends State<CardHistoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 2), // Menambahkan border
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Persentase Merah",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.persentaseMerah} %",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Persentase Hijau",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.persentaseHijau} %",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Jumlah Biji Merah",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.jumlahBiji['merah']} Biji",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Jumlah Biji hijau",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.jumlahBiji['hijau']} Biji",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Divider(
            thickness: 2.0,
            endIndent: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Jumlah Biji",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "${widget.totalJumlahBiji} Biji",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Merah",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Kecil",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranMerah['kecil']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Sedang",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranMerah['sedang']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Besar",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranMerah['besar']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Divider(
            thickness: 2.0,
            endIndent: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Berat Ukuran Biji Merah",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "${widget.totalBeratMerah} Kg",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Hijau",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Kecil",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranHijau['kecil']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Sedang",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranHijau['sedang']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Berat Ukuran Besar",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
              Text(
                "${widget.ukuranHijau['besar']} Kg",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              )
            ],
          ),
          const Divider(
            thickness: 2.0,
            endIndent: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Berat Ukuran Biji Hijau",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(
                "${widget.totalBeratHijau} Kg",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Berat Hasil Sortir",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              Text(
                "${widget.totalHasilSortir} Kg",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              )
            ],
          ),
        ],
      ),
    );
  }
}
