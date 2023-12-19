# Reservamos API Test

API realizada con Ruby On Rails para obtener la temperatura minima y máxima de un listado de ciudades obtenidas de la busqueda del API de Reservamos

## Pre requisitos

Para ejecutar el proyecto en un ambiente local es necesario contar con Ruby y Rails instalado.

## Instalación y ejecución

Para poder ejecutar el proyecto es necesario realizar los siguientes pasos:

1 - Clonar el repositorio del proyecto.

2 - Ejecutar el siguiente comando para instalar las gemas necesarias del proyecto:

```sh
make get-gems
```

3 - Ejecutar el siguiente comando para crear el archivo .env con base al .env.example:

```sh
make generate-env-file 
```
Una vez generado el .env, se deberan copiar los valores de cada variables.

4 - Copiar el archivo `master.key` dentro de la carpeta **config**

5 - Iniciar el proyecto con el siguiente comando:

```sh
make start-server
```

6 - Una vez que inicie el proyecto se podrá ejecutar el siguiente endpoints http://127.0.0.1:3000/api/v1/health y se deberá esperar una respuesta como la siguiente:

```json
{
    "api_version": "V1",
    "enviroment": "development",
    "message": "I'm ok"
}
```


Carlos Salgado