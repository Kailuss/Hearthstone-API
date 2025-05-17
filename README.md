# Proyecto PDMD03 <br>App de Cartas de Hearthstone

Este proyecto es una aplicación móvil desarrollada con Flutter como parte de la asignatura **PDMD03** del segundo curso del ciclo formativo **Desarrollo de Aplicaciones Multiplataforma (DAM)**.

La app permite consultar cartas del juego **Hearthstone** utilizando la API oficial de Blizzard, mostrando la información de forma visual e interactiva.

## Funcionalidades

- **Conexión con la API de Blizzard** para obtener datos actualizados de cartas de Hearthstone.
- **Pantalla principal** con:
  - Un **slider** para filtrar o seleccionar el tipo/clase de cartas.
  - Un **swiper** para desplazarse horizontalmente entre las cartas disponibles.
- **Pantalla de detalle**:
  - Información completa de la carta seleccionada (nombre, descripción, clase, rareza, etc.).
  - Un **slider adicional** que muestra otras cartas del mismo set.

## Tecnologías utilizadas

- **Flutter** (Dart)
- **API de Blizzard** (Hearthstone API)
- Paquetes Flutter utilizados:
  - `http` para solicitudes REST
  - `card_swiper` para deslizar cartas
  - `carousel_slider` para sliders de cartas
  - `provider` para gestión del estado

## Instalación y ejecución

1. Clona el repositorio:
	```bash
	git clone https://github.com/usuario/proyecto-hearthstone-pdmd03.git
	```

2. Accede al directorio del proyecto:
    
    ```bash
    cd proyecto-hearthstone-pdmd03
    ```
    
3. Instala las dependencias:
    
    ```bash
    flutter pub get
    ```
    
4. Añade tus credenciales de la API de Blizzard.
    
5. Ejecuta la aplicación:
    
    ```bash
    flutter run
    ```
    

## Autenticación API de Blizzard

Para poder acceder a la API, es necesario obtener una `client_id` y `client_secret` en el portal de desarrolladores de Blizzard:

- [Blizzard Developer Portal](https://develop.battle.net/)

La autenticación se hace mediante OAuth 2.0 para obtener un token que se utiliza en las llamadas a la API.

## Aprendizajes

- Consumo de APIs REST en Flutter.
- Gestión de interfaces interactivas y dinámicas.
- Uso de widgets avanzados como `Swiper` y `Slider`.
- Separación de lógica de presentación y de negocio.
    

## Autor

- Alfonso Otón Liñán
- 2º DAM - PDMD03   
- Curso 2024/2025
