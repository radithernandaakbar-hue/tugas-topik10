import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import 'umkm_form_page.dart';

class UmkmView extends StatelessWidget {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(UmkmController());
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar UMKM')),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (c.umkmList.isEmpty) {
          return const Center(child: Text('Belum ada data UMKM'));
        }
        return RefreshIndicator(
          onRefresh: c.fetchUmkm,
          child: ListView.builder(
            itemCount: c.umkmList.length,
            itemBuilder: (context, i) {
              final item = c.umkmList[i];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(item.id?.toString() ?? '?'),
                  ),
                  title: Text(item.namaUmkm),
                  subtitle: Text(
                    '${item.kategori ?? '-'} • ${item.alamat ?? '-'}',
                  ),
                  onTap: () => Get.to(() => UmkmFormPage(umkm: item)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => Get.defaultDialog(
                      title: 'Hapus?',
                      middleText: 'Hapus ${item.namaUmkm}?',
                      textConfirm: 'Hapus',
                      textCancel: 'Batal',
                      onConfirm: () {
                        Get.back();
                        c.remove(item.id!);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => UmkmFormPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
