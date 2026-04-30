import 'dart:io';

import 'package:minimax_tictactoe/src/models/benchmark_result.dart';

/// Exports benchmark results to a CSV file.
///
/// The CSV file can be opened in Excel or Google Sheets
/// to generate charts and tables for the research paper.
class CsvExporter {
  /// Creates a [CsvExporter].
  const CsvExporter();

  /// The CSV header row.
  static const String _header =
      'SN,ID,Stage,Depth,MM_Nodes,AB_Nodes,MM_Time_us,AB_Time_us,'
      'Pruning_Efficiency_%,Moves_Match,MM_BestMove,AB_BestMove';

  /// Exports [results] to a CSV file at [outputPath].
  ///
  /// Creates the file and any parent directories if they don't exist.
  Future<void> export(
    List<BenchmarkResult> results,
    String outputPath,
  ) async {
    final file = File(outputPath);
    await file.parent.create(recursive: true);

    final buffer = StringBuffer()..writeln(_header);

    var sn = 1;
    for (final r in results) {
      buffer.writeln(_toRow(r, sn++));
    }

    await file.writeAsString(buffer.toString());
  }

  /// Converts a single [BenchmarkResult] to a CSV row.
  String _toRow(BenchmarkResult r, int sn) {
    return '$sn,'
        '${r.testCase.id},'
        '${r.testCase.stage.label},'
        '${r.depth},'
        '${r.minimaxResult.nodesExplored},'
        '${r.alphaBetaResult.nodesExplored},'
        '${r.minimaxResult.elapsedMicroseconds},'
        '${r.alphaBetaResult.elapsedMicroseconds},'
        '${r.pruningEfficiency.toStringAsFixed(2)},'
        '${r.movesMatch},'
        '${r.minimaxResult.bestMove},'
        '${r.alphaBetaResult.bestMove}';
  }
}
