<?php

namespace App\Controllers\Api;

use App\Models\UmkmModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class UmkmController extends ResourceController
{
    private function input(): array
    {
        if (str_contains($this->request->getHeaderLine('Content-Type'), 'application/json')) {
            return $this->request->getJSON(true) ?? [];
        }
        $post = $this->request->getPost();
        return $post ?: ($this->request->getRawInput() ?: []);
    }

    private function rules(?int $id = null): array
    {
        $unique = $id ? "is_unique[umkm.nama_umkm,id,$id]" : 'is_unique[umkm.nama_umkm]';
        return [
            'nama_umkm' => "required|min_length[3]|$unique",
            'kategori'  => 'permit_empty|string',
            'pemilik'   => 'permit_empty|string',
            'alamat'    => 'permit_empty|string',
            'kontak'    => 'permit_empty|string',
        ];
    }

    // GET api/umkm
    public function index(): ResponseInterface
    {
        $umkm = (new UmkmModel())->findAll();
        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diambil',
            'data'    => $umkm,
        ], 200);
    }

    // GET api/umkm/{id}
    public function show($id = null): ResponseInterface
    {
        $data = (new UmkmModel())->find($id);
        if (!$data) {
            return $this->respond(['success' => false, 'message' => 'Data UMKM tidak ditemukan'], 404);
        }
        return $this->respond(['success' => true, 'message' => 'Data UMKM ditemukan', 'data' => $data], 200);
    }

    // POST api/umkm
    public function create(): ResponseInterface
    {
        $data = $this->input();
        $validation = \Config\Services::validation();

        if (!$validation->setRules($this->rules())->run($data)) {
            return $this->respond([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $validation->getErrors(),
            ], 400);
        }

        $model = new UmkmModel();
        $insertedId = $model->insert($data);

        if ($insertedId === false) {
            return $this->respond([
                'success' => false,
                'message' => 'Gagal menambahkan data UMKM',
                'errors'  => $model->errors(),
            ], 500);
        }

        return $this->respondCreated([
            'success' => true,
            'message' => 'Data UMKM berhasil ditambahkan',
            'data'    => $model->find($insertedId),
        ]);
    }

    // PUT api/umkm/{id}
    public function update($id = null): ResponseInterface
    {
        $model = new UmkmModel();
        if (!$model->find($id)) {
            return $this->respond(['success' => false, 'message' => 'Data UMKM tidak ditemukan'], 404);
        }

        $data = $this->input();
        $validation = \Config\Services::validation();
        if (!$validation->setRules($this->rules((int) $id))->run($data)) {
            return $this->respond([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $validation->getErrors(),
            ], 400);
        }

        $model->update($id, $data);

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diubah',
            'data'    => $model->find($id),
        ], 200);
    }

    // DELETE api/umkm/{id}
    public function delete($id = null): ResponseInterface
    {
        $model = new UmkmModel();
        $data = $model->find($id);
        if (!$data) {
            return $this->respond(['success' => false, 'message' => 'Data UMKM tidak ditemukan'], 404);
        }

        $model->delete($id);
        return $this->respond(['success' => true, 'message' => 'Data UMKM berhasil dihapus', 'data' => $data], 200);
    }
}
