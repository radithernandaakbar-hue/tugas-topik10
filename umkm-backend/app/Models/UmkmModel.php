<?php

namespace App\Models;

use CodeIgniter\Model;

class UmkmModel extends Model
{
    protected $table            = 'umkm';
    protected $primaryKey       = 'id';
    protected $useAutoIncrement = true;
    protected $returnType       = 'array';
    protected $allowedFields    = ['nama_umkm', 'pemilik', 'alamat', 'kategori', 'kontak'];
    protected $useTimestamps    = true;
}
