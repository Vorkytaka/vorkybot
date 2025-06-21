import 'dart:convert';

/// A simple logger class that formats logs with events and parameters.
/// 
/// This logger prints events to the console in a formatted way. Each log entry 
/// includes a timestamp, the event name, and optional parameters.
class Logger {
  /// Static instance for global access throughout the application
  static final Logger instance = Logger();
  /// Logs an event with optional parameters to the console.
  /// 
  /// [eventName] is a string identifying the event.
  /// [parameters] is an optional map of additional data related to the event.
  /// 
  /// Example usage:
  /// ```dart
  /// final logger = Logger();
  /// logger.log('UserLogin', {'userId': '12345', 'source': 'web'});
  /// ```
  void log(String eventName, [Map<String, dynamic>? parameters]) {
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer();
    
    // Add timestamp and event name
    buffer.write('[$timestamp] EVENT: $eventName');
    
    // Add parameters if provided
    if (parameters != null && parameters.isNotEmpty) {
      // Format the parameters using JsonEncoder for pretty printing
      final encoder = const JsonEncoder.withIndent('  ');
      final prettyParams = encoder.convert(parameters);
      
      // Format the output with parameters on new lines
      buffer.write('\nPARAMS:\n$prettyParams');
    }
    
    // Print the formatted log
    print(buffer.toString());
  }
}
