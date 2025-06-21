import 'dart:math';

import 'prediction_provider.dart';

/// A model class for managing predictions in memory
class InMemoryPredictionProvider implements PredictionProvider {
  /// The list of available prediction replies
  final List<String> _replies;

  /// Random number generator for selecting predictions
  final Random _random;

  /// Creates a new [InMemoryPredictionProvider] instance
  ///
  /// [random] allows dependency injection for testing
  InMemoryPredictionProvider(this._replies, {Random? random})
      : _random = random ?? Random();

  /// Returns a randomly selected prediction from the available replies
  @override
  Future<String> getRandomPrediction() async {
    if (_replies.isEmpty) {
      throw StateError('No prediction replies available');
    }
    return _replies[_random.nextInt(_replies.length)];
  }
}
