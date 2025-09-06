import 'package:flutter_test/flutter_test.dart';
import 'package:frame_found_app/modules/details/data/services/remote/movie_details_service_impl.dart';

void main() {
  late MovieDetailsServiceImpl service;

  setUp(() {
    service = MovieDetailsServiceImpl();
  });

  group('MovieDetailsServiceImpl', () {
    group('getMovieDetails', () {
      test('should be properly instantiated', () {
        expect(service, isA<MovieDetailsServiceImpl>());
      });
    });
  });
}
