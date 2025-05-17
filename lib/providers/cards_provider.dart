import 'dart:convert';
import 'package:dnd_app/models/hs_card.dart';
import 'package:dnd_app/models/cards_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Proveedor de datos para manejar las cartas de Hearthstone usando la API de Blizzard.
/// Utiliza ChangeNotifier para notificar cambios a los widgets.
class CardsProvider extends ChangeNotifier {
  // Configuración de la API
  final String _baseUrl = 'eu.api.blizzard.com'; // Dominio base de la API
  final String _endPoint = '/hearthstone/cards'; // Endpoint para obtener cartas
  final String _clientId = '72c03c8a1ab8484280b26e6d4b767532'; // Client ID de OAuth (NO EXPUESTO EN PRODUCCIÓN)
  final String _clientSecret = 'Bt8PfKheObDG1l7W7b9DjRkaNK2yEIED'; // Client Secret de OAuth (DEBE SER PROTEGIDO)

  // Listas de cartas en memoria
  List<HSCard> onDisplayCards = []; // Cartas mostradas en la página principal
  List<HSCard> onSetCards = []; // Cartas filtradas por set/expansión

  // Manejo del token OAuth 2.0
  String? _accessToken; // Token de acceso actual
  DateTime? _tokenExpiry; // Fecha de expiración del token

  /// Constructor: Inicializa la obtención de cartas al crear el provider.
  CardsProvider() {
    getCards(); // Carga inicial de cartas
  }

  /// Obtiene un token de acceso OAuth 2.0 desde Battle.net.
  /// - Si ya hay un token válido, lo reutiliza.
  /// - Si no, solicita uno nuevo.
  Future<String> _getAccessToken() async {
    // Verifica si el token actual sigue siendo válido
    if (_accessToken != null && _tokenExpiry != null && _tokenExpiry!.isAfter(DateTime.now())) {
      return _accessToken!; // Retorna el token existente
    }

    try {
      final tokenUrl = Uri.https('oauth.battle.net', '/token'); // URL para autenticación
      final response = await http.post(
        tokenUrl,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'client_credentials',
          'client_id': _clientId,
          'client_secret': _clientSecret,
        },
      );

      if (response.statusCode == 200) {
        final tokenData = json.decode(response.body);
        _accessToken = tokenData['access_token']; // Almacena el nuevo token
        // Calcula la expiración (por defecto 24 horas)
        int expiresIn = tokenData['expires_in'] ?? 86400;
        _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
        return _accessToken!;
      } else {
        throw Exception('Error al obtener token: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en OAuth: $e');
    }
  }

  /// Obtiene una lista de cartas desde la API (paginación por defecto: página 2, 30 cartas).
  Future<void> getCards() async {
    try {
      final token = await _getAccessToken(); // Obtiene token

      // Construye la URL con parámetros
      var url = Uri.https(_baseUrl, _endPoint, {
        'locale': 'es_ES', // Idioma español
        'page': '2', // Página solicitada
        'pageSize': '30', // Cartas por página
      });

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Token en el header
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          // Procesa la respuesta y actualiza las cartas
          final cardsResponse = CardsResponse.fromJson(response.body);
          onDisplayCards = cardsResponse.cards;
          notifyListeners(); // Notifica a los widgets suscritos
        } catch (e) {
          throw Exception('Error al parsear datos: $e');
        }
      } else {
        throw Exception('Error HTTP: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en getCards(): $e');
    }
  }

  /// Obtiene cartas filtradas por un set/expansión específico.
  Future<void> getSetCards(int setID) async {
    onSetCards = []; // Limpia la lista antes de cargar
    notifyListeners(); // Notifica el cambio (lista vacía)

    try {
      final token = await _getAccessToken();

      var url = Uri.https(_baseUrl, _endPoint, {
        'locale': 'es_ES',
        'page': '1',
        'pageSize': '10',
        'set': setID.toString(), // Filtra por ID del set
      });

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        try {
          final cardsResponse = CardsResponse.fromJson(response.body);
          onSetCards = cardsResponse.cards;
        } catch (e) {
          onSetCards = []; // Fallback en caso de error
          throw Exception('Error al parsear datos: $e');
        }
      } else {
        onSetCards = []; // Fallback si la API falla
      }
    } catch (e) {
      onSetCards = []; // Fallback en caso de excepción
      throw Exception('Error en getSetCards(): $e');
    }
    notifyListeners(); // Notifica que las cartas están listas
  }
}
