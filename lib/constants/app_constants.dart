import 'package:flutter_dotenv/flutter_dotenv.dart';

const tmdbHost = 'https://www.themoviedb.org';
const imageUrl = 'https://image.tmdb.org/t/p/w500';
const apiHost = 'https://api.themoviedb.org/3';
final apiKey = dotenv.env['API_KEY'] ?? '';
