/// Interface for prediction providers
abstract interface class PredictionProvider {
  /// Returns a randomly selected prediction
  Future<String> getRandomPrediction();
}
