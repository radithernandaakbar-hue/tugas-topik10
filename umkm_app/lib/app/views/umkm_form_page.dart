import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';

class UmkmFormPage extends StatelessWidget {
  final Umkm? umkm;
  UmkmFormPage({super.key, this.umkm});

  final c = Get.find<UmkmController>();
  late final namaC = TextEditingController(text: umkm?.namaUmkm);
  late final pemilikC = TextEditingController(text: umkm?.pemilik);
  late final alamatC = TextEditingController(text: umkm?.alamat);
  late final kategoriC = TextEditingController(text: umkm?.kategori);
  late final kontakC = TextEditingController(text: umkm?.kontak);

  Widget _field(TextEditingController ctrl, String label) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(umkm == null ? 'Tambah UMKM' : 'Edit UMKM')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _field(namaC, 'Nama UMKM'),
            _field(pemilikC, 'Pemilik'),
            _field(alamatC, 'Alamat'),
            _field(kategoriC, 'Kategori'),
            _field(kontakC, 'Kontak'),
            const SizedBox(height: 8),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: c.isSaving.value
                      ? null
                      : () async {
                          final ok = await c.save(
                            Umkm(
                              namaUmkm: namaC.text,
                              pemilik: pemilikC.text,
                              alamat: alamatC.text,
                              kategori: kategoriC.text,
                              kontak: kontakC.text,
                            ),
                            id: umkm?.id,
                          );
                          if (ok) Get.back();
                        },
                  child: c.isSaving.value
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Simpan'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
