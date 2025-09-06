import 'package:flutter/material.dart';

import '../../domain/entities/movie_details_entity.dart';
import '../utils/details_strings.dart';

class MovieDetailsInfoWidget extends StatelessWidget {
  final MovieDetailsEntity movieDetails;

  const MovieDetailsInfoWidget({
    super.key,
    required this.movieDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  movieDetails.poster ?? '',
                  width: 120,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      DetailsStrings.posterNotFound,
                      width: 120,
                      height: 180,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieDetails.title ?? '',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (movieDetails.imdbRating != null) ...[
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${movieDetails.imdbRating}/10',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                    ],
                    if (movieDetails.imdbVotes != null) ...[
                      Text(
                        '${movieDetails.imdbVotes} ${DetailsStrings.imdbVotes}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                    ],
                    _buildInfoRow(DetailsStrings.year, movieDetails.year),
                    _buildInfoRow(DetailsStrings.runtime, movieDetails.runtime),
                    _buildInfoRow(DetailsStrings.rated, movieDetails.rated),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (movieDetails.plot != null) ...[
            Text(
              DetailsStrings.plot,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movieDetails.plot!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 24),
          ],

          _buildDetailSection(context, DetailsStrings.genre, movieDetails.genre),
          _buildDetailSection(context, DetailsStrings.director, movieDetails.director),
          _buildDetailSection(context, DetailsStrings.writer, movieDetails.writer),
          _buildDetailSection(context, DetailsStrings.actors, movieDetails.actors),
          _buildDetailSection(context, DetailsStrings.language, movieDetails.language),
          _buildDetailSection(context, DetailsStrings.country, movieDetails.country),
          _buildDetailSection(context, DetailsStrings.released, movieDetails.released),
          _buildDetailSection(context, DetailsStrings.awards, movieDetails.awards),
          _buildDetailSection(context, DetailsStrings.boxOffice, movieDetails.boxOffice),
          _buildDetailSection(context, DetailsStrings.production, movieDetails.production),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context, String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
