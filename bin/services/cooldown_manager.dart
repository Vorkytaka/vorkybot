/// Class to manage user cooldown periods for predictions
class CooldownManager {
  /// Map to store the last prediction time for each user
  final Map<int, DateTime> _lastPredictionTimes = {};
  
  /// The cooldown duration
  final Duration cooldownDuration;
  
  /// Creates a new [CooldownManager] with the specified cooldown duration
  CooldownManager({required this.cooldownDuration});
  
  /// Records a user's prediction time
  void recordPrediction(int userId) {
    _lastPredictionTimes[userId] = DateTime.now();
  }
  
  /// Checks if a user is on cooldown
  /// 
  /// Returns null if the user is not on cooldown,
  /// otherwise returns the remaining time as a Duration
  Duration? getRemainingCooldown(int userId) {
    final now = DateTime.now();
    
    if (_lastPredictionTimes.containsKey(userId)) {
      final lastTime = _lastPredictionTimes[userId]!;
      final nextAvailableTime = lastTime.add(cooldownDuration);
      final timeRemaining = nextAvailableTime.difference(now);
      
      if (timeRemaining.isNegative == false) {
        return timeRemaining;
      }
    }
    
    return null; // Not on cooldown
  }
}
