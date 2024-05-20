
### Installing and Running Laravel

#### Prerequisites
Before installing Laravel, ensure that you have the following prerequisites installed on your system:
- PHP (>= 7.4)
- Composer
- Node.js (with npm)
- Git
- MySQL or any other database server supported by Laravel

#### Step 1: Install Laravel Installer (optional)
If you haven't installed the Laravel Installer globally, you can do so using Composer. This step is optional but recommended for convenience.

```bash
composer global require laravel/installer
```

#### Step 2: Create a New Laravel Project
Once you have Laravel Installer installed (or if you choose not to use it), you can create a new Laravel project using the `laravel new` command.

```bash
laravel new your-project-name
```

Replace `your-project-name` with the desired name for your Laravel project.

#### Step 3: Set Up Environment Configuration
Navigate to your project directory and copy the `.env.example` file to create a `.env` file.

```bash
cd your-project-name
cp .env.example .env
```

Open the `.env` file and configure your database connection details.

#### Step 4: Install PHP Dependencies
Use Composer to install the PHP dependencies for your Laravel project.

```bash
composer install
```

#### Step 5: Generate Application Key
Generate a unique application key for your Laravel application using the `artisan key:generate` command.

```bash
php artisan key:generate
```

#### Step 6: Migrate Database
Run the database migrations to create necessary tables in your configured database.

```bash
php artisan migrate
```

#### Step 7: Install NPM Dependencies (Optional)
If your Laravel project requires frontend assets or uses Laravel Mix, you need to install NPM dependencies.

```bash
npm install
```

#### Step 8: Run Laravel Development Server
You can start the Laravel development server using the `artisan serve` command.

```bash
php artisan serve
```

By default, the server will run on `http://localhost:8000`. You can access your Laravel application by navigating to this URL in your web browser.

### Additional Resources
- [Laravel Documentation](https://laravel.com/docs)
- [Laracasts](https://laracasts.com/) - Video tutorials for Laravel development
- [Laravel News](https://laravel-news.com/) - Latest news and updates about Laravel
<br />
Congratulations! You have successfully installed and set up a Laravel project on your system. Happy coding!
### DOCUMENTATIONS COLLECTION

Documentations : https://docs.google.com/document/d/1mmAndsYMbv9UEG6jcFu-ocTzomigdjCp/edit
<br>
API Postman Documentations : https://documenter.getpostman.com/view/29838182/2sA3JQ3etG
