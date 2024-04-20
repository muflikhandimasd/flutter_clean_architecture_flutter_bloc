cd server/
composer install /
cp .env.example .env /
php artisan key:generate /
php artisan migrate:fresh --seed /
php artisan serve --port=9221 --host 0.0.0.0 /
cd ../
flutter run --release