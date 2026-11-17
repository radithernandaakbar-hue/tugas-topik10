import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class UmkmService {
  // Linux desktop / Chrome: localhost | Emulator Android: 10.0.2.2 | HP asli: IP LAN laptop
  static const String baseUrl = 'http://localhost:8080/api/';

  final _headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  Map<String, dynamic> _handle(http.Response r) {
    final body = jsonDecode(r.body);
    if (r.statusCode >= 200 && r.statusCode < 300) return body;
    final errors = body['errors'];
    throw Exception(
      errors != null
          ? (errors as Map).values.join(', ')
          : (body['message'] ?? 'Error ${r.statusCode}'),
    );
  }

  Future<List<Umkm>> getUmkmList() async {
    final res = await http.get(Uri.parse('${baseUrl}umkm'));
    final body = _handle(res);
    return (body['data'] as List).map((e) => Umkm.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> createUmkm(Map<String, String> data) async =>
      _handle(
        await http.post(
          Uri.parse('${baseUrl}umkm'),
          headers: _headers,
          body: data,
        ),
      );

  Future<Map<String, dynamic>> updateUmkm(
    int id,
    Map<String, String> data,
  ) async => _handle(
    await http.put(
      Uri.parse('${baseUrl}umkm/$id'),
      headers: _headers,
      body: data,
    ),
  );

  Future<Map<String, dynamic>> deleteUmkm(int id) async =>
      _handle(await http.delete(Uri.parse('${baseUrl}umkm/$id')));
}
