# Tugas Topik 10: REST API CI4 + Flutter

- umkm-backend: REST API CodeIgniter 4 (SQLite)
- umkm_app: aplikasi Flutter

## Menjalankan backend

    cd umkm-backend
    composer install
    cp env .env
    php spark migrate
    php spark serve --host 0.0.0.0 --port 8080

Di .env aktifkan: database.default.database = db_umkm.sqlite dan database.default.DBDriver = SQLite3

## Menjalankan Flutter

    cd umkm_app
    flutter pub get
    flutter run -d linux
