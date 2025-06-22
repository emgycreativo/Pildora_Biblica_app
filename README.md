# Pildora_Biblica_app

Repositorio del proyecto Píldora Bíblica

## Uso de `intl` para fechas

Este proyecto utiliza el paquete [`intl`](https://pub.dev/packages/intl) para
formatear fechas en español. Antes de ejecutar la aplicación es necesario
inicializar los datos de localización. Esto ya se realiza en `lib/main.dart`
mediante la función `initializeDateFormatting('es_ES', null)`. Asegúrate de
ejecutar `flutter pub get` para obtener las dependencias.
