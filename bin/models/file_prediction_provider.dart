import 'dart:io';
import 'dart:math';

import 'prediction_provider.dart';
import '../services/logger.dart';

/// A provider that reads predictions from a file and caches them in memory
class FilePredictionProvider implements PredictionProvider {
  /// The list of cached prediction replies read from file
  final List<String> _cachedReplies = [];

  /// Path to the predictions file
  final String _filePath;

  /// Random number generator for selecting predictions
  final Random _random;

  /// Timestamp of the last file modification
  DateTime? _lastModified;

  /// Creates a new [FilePredictionProvider] instance
  ///
  /// [filePath] is the path to the text file containing predictions (one per line)
  /// [random] allows dependency injection for testing
  FilePredictionProvider(this._filePath, {Random? random})
      : _random = random ?? Random() {
    // Initialize the cache when created
    _loadPredictions();
  }

  /// Loads predictions from file into memory cache
  void _loadPredictions() {
    final file = File(_filePath);
    if (!file.existsSync()) {
      Logger.instance.log('PredictionsFileNotFound', {'filePath': _filePath});
      throw FileSystemException('Predictions file not found', _filePath);
    }

    // Update last modified timestamp
    _lastModified = file.lastModifiedSync();

    _cachedReplies.clear();
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      if (line.trim().isNotEmpty) {
        _cachedReplies.add(line.trim());
      }
    }

    Logger.instance.log('PredictionsLoaded', {
      'filePath': _filePath,
      'count': _cachedReplies.length,
      'lastModified': _lastModified?.toIso8601String()
    });

    if (_cachedReplies.isEmpty) {
      Logger.instance.log('PredictionsFileEmpty', {'filePath': _filePath});
      throw StateError('No predictions found in file: $_filePath');
    }
  }

  /// Checks if the file has been modified since the last read
  bool _isFileModified() {
    if (_lastModified == null) return true;

    final file = File(_filePath);
    if (!file.existsSync()) return false;

    final currentModified = file.lastModifiedSync();
    return currentModified.isAfter(_lastModified!);
  }

  /// Reloads predictions from the file if it has been modified
  void _checkAndReloadIfNeeded() {
    if (_isFileModified()) {
      Logger.instance.log('PredictionsFileReload', {'filePath': _filePath});
      _loadPredictions();
    }
  }

  /// Returns a randomly selected prediction from the cached replies
  @override
  Future<String> getRandomPrediction() async {
    // Check if file was modified and reload if needed
    _checkAndReloadIfNeeded();

    if (_cachedReplies.isEmpty) {
      Logger.instance.log('NoPredictionRepliesAvailable', {'filePath': _filePath});
      throw StateError('No prediction replies available');
    }
    final prediction = _cachedReplies[_random.nextInt(_cachedReplies.length)];
    Logger.instance.log('PredictionReturned', {'filePath': _filePath, 'prediction': prediction});
    return prediction;
  }
}
