# Formulario ingreso de Productos - DESIS

Este proyecto consiste en un sistema web ligero y eficiente para la gestión de productos, permitiendo su registro con validaciones robustas y almacenamiento en base de datos.

## 📋 Requisitos del Sistema

Para el correcto funcionamiento de este sistema, asegúrese de contar con el siguiente entorno:

- **PHP**: Versión **8.3.4** (Recomendado) o superior.
- **Base de Datos**: MariaDB Server versión **10.4.32**.
- **Servidor Web**: Apache (vía XAMPP) o servidor integrado de PHP.

## 🚀 Instalación y Configuración Paso a Paso

Sigue estos pasos para desplegar el proyecto en tu entorno local:

### 1. Despliegue de Archivos

O puedes clonar directamente el repositorio desde GitHub:

```bash
git clone https://github.com/efuentealbaCh/desis.git
```

Si lo descargas manualmente, copia la carpeta del proyecto `desis` dentro del directorio público de tu servidor web:

- **XAMPP**: `C:\xampp\htdocs\desis`

### 2. Configuración de Base de Datos

1.  Abre tu cliente de base de datos favorito (phpMyAdmin, DBeaver, HeidiSQL, etc.).
2.  Crea una nueva base de datos llamada `desis`.
3.  Importa el archivo **`desis.sql`** incluido en la raíz del proyecto. Este archivo contiene la estructura de tablas (`producto`, `bodega`, `sucursal`, etc.) y datos iniciales de prueba.

### 3. Conexión

Verifica el archivo `db_config.php`. Por defecto viene configurado para XAMPP estándar:

```php
$host = 'localhost';
$db_name = 'desis';
$username = 'root';
$password = ''; // Dejar vacío para XAMPP por defecto
```

Si tu configuración de base de datos es diferente, edita este archivo con tus credenciales.

## 💻 Uso del Sistema

### Iniciar el Servidor

Si usas XAMPP, asegúrate de que **Apache** y **MySQL** estén corriendo.

Alternativamente, puedes usar el servidor integrado de PHP abriendo una terminal en la carpeta del proyecto y ejecutando:

```bash
php -S localhost:8000
```

### Acceder al Formulario

Abre tu navegador web y ve a la siguiente dirección:

- Si usas XAMPP: `http://localhost/desis/product_form.html`
- Si usas `php -S`: `http://localhost:8000/product_form.html`

### Funcionalidades y Validaciones

El formulario cuenta con validaciones en tiempo real para asegurar la integridad de los datos:

- **Código**: Obligatorio, alfanumérico, longitud 5-15, único en la BD.
- **Nombre**: Obligatorio, longitud 2-50.
- **Bodega y Sucursal**: Selección obligatoria.
- **Moneda**: Selección obligatoria.
- **Precio**: Obligatorio, número positivo con hasta 2 decimales (ej. 19.99).
- **Materiales**: Se deben seleccionar al menos 2 opciones.
- **Descripción**: Obligatorio, longitud 10-1000 caracteres.

---

_Desarrollado para prueba técnica DESIS._
