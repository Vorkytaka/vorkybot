import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';

/// Initialize SQLite for different platforms, especially for Linux in Docker
void initializeSqlite() {
  // For Linux (like in Docker containers)
  if (Platform.isLinux) {
    // Try common locations for libsqlite3.so on Linux
    open.overrideFor(OperatingSystem.linux, () {
      // Try common library paths
      for (final path in [
        'libsqlite3.so', // Current directory
        '/usr/lib/libsqlite3.so', // Standard location
        '/usr/local/lib/libsqlite3.so', // Alternate location
        '/lib/x86_64-linux-gnu/libsqlite3.so.0', // Debian/Ubuntu specific path
      ]) {
        try {
          return DynamicLibrary.open(path);
        } catch (_) {
          // Ignore and try next path
        }
      }
      
      // If we get here, we couldn't find the library
      throw Exception('Failed to load SQLite library. Make sure it is installed.');
    });
  }
}
