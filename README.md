
# DoctorYA

DoctorYA es una solución diseñada para gestionar una clínica, incluyendo funcionalidades como administración de pacientes, médicos, citas, historias clínicas, medicamentos, exámenes, y más. Este proyecto ha sido desarrollado como parte de la materia de Bases de Datos 2 en la Universidad Autónoma de Manizales.

## Estructura del Proyecto

```
/DoctorYA/
├── /database/    # Scripts SQL para la base de datos (tablas, funciones, triggers, secuencias, etc.)
├── /backend/     # API y lógica del servidor
├── /doc/         # Documentación adicional del proyecto
└── README.md     # Este archivo
```

## Requisitos Previos

Asegúrate de tener instalados los siguientes programas:

- **Node.js** (v20 o superior)
- **PostgreSQL** (v14 o superior)
- **MongoDB** (para la funcionalidad de auditoría)
- **Git** (opcional, para clonar el repositorio)

## Instalación

Sigue estos pasos para configurar y ejecutar el proyecto localmente:

### 1. Clonar el Repositorio

Clona el proyecto desde GitHub u otro repositorio utilizando el comando:

```bash
git clone https://github.com/tu-usuario/doctorYA.git
cd doctorYA
```

### 2. Instalar Dependencias del Backend

Accede a la carpeta del backend e instala las dependencias necesarias:

```bash
cd backend
npm install
```

### 3. Configurar Variables de Entorno

En la carpeta `backend`, crea un archivo `.env` basado en el archivo de ejemplo `.env.example` que ya está incluido. Este archivo debe contener la configuración necesaria, como credenciales de la base de datos, puerto de la aplicación, y claves API.

Ejemplo de `.env`:
```env
DB_HOST=localhost
DB_PORT=5432
DB_USER=tu_usuario
DB_PASSWORD=tu_contraseña
DB_NAME=doctorYA
MONGO_URI=mongodb://localhost:27017/auditoria
```

### 4. Configurar la Base de Datos

#### a. Crear la Base de Datos en PostgreSQL
Crea una base de datos llamada `doctorYA` (o el nombre que hayas configurado en el archivo `.env`):

```sql
CREATE DATABASE doctorYA;
```

#### b. Ejecutar Scripts SQL
Accede a la carpeta `database` y ejecuta los scripts en el orden adecuado para configurar las tablas, funciones, triggers, y más. Puedes usar la herramienta `psql` o un cliente como **pgAdmin**:

```bash
psql -U tu_usuario -d doctorYA -f database/models/scripts.sql
psql -U tu_usuario -d doctorYA -f database/functions/scripts.sql
psql -U tu_usuario -d doctorYA -f database/sequences/scripts.sql
psql -U tu_usuario -d doctorYA -f database/triggers/scripts.sql

```

### 5. Iniciar el Servidor del Backend

Inicia el servidor con el siguiente comando desde la carpeta `backend`:

```bash
npm run start:dev
```

### 6. Documentación de la API

DoctorYA utiliza Swagger para documentar la API. Una vez que el servidor esté corriendo, puedes acceder a la documentación completa en el siguiente enlace:

[Documentación Swagger](http://localhost:3000/docs)

### 7. Probar el Proyecto

Asegúrate de que el servidor esté corriendo y prueba las funcionalidades accediendo a las rutas de la API. Puedes usar herramientas como **Postman** o **Thunder Client** para probar las rutas.

## Documentación

- Toda la documentación del proyecto se encuentra en la carpeta `/doc/`.
- Incluye detalles sobre las entidades, relaciones, procedimientos almacenados, funciones, y la integración con MongoDB para auditorías.

## Créditos

Desarrollado por:  
- **Camilo Muñoz Valencia y Santiago Duque**  
Proyecto realizado para la materia de Bases de Datos 2 - Universidad Autónoma de Manizales (2024).  
