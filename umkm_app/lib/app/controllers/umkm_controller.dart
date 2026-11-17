import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/service.dart';

class UmkmController extends GetxController {
  final umkmList = <Umkm>[].obs;
  final isLoading = true.obs;
  final isSaving = false.obs;
  final _service = UmkmService();

  @override
  void onInit() {
    fetchUmkm();
    super.onInit();
  }

  Future<void> fetchUmkm() async {
    try {
      isLoading(true);
      umkmList.assignAll(await _service.getUmkmList());
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> save(Umkm item, {int? id}) async {
    try {
      isSaving(true);
      final res = id == null
          ? await _service.createUmkm(item.toMap())
          : await _service.updateUmkm(id, item.toMap());
      Get.snackbar('Berhasil', res['message'] ?? 'Data tersimpan');
      await fetchUmkm();
      return true;
    } catch (e) {
      Get.snackbar('Gagal', e.toString().replaceFirst('Exception: ', ''));
      return false;
    } finally {
      isSaving(false);
    }
  }

  Future<void> remove(int id) async {
    try {
      final res = await _service.deleteUmkm(id);
      Get.snackbar('Berhasil', res['message'] ?? 'Data dihapus');
      await fetchUmkm();
    } catch (e) {
      Get.snackbar('Gagal', e.toString());
    }
  }
}
