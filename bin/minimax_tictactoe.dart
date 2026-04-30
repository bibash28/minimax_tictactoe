import 'package:mason_logger/mason_logger.dart';
import 'package:minimax_tictactoe/src/models/benchmark_result.dart';
import 'package:minimax_tictactoe/src/runner/benchmark_runner.dart';
import 'package:minimax_tictactoe/src/runner/csv_exporter.dart';
import 'package:minimax_tictactoe/src/runner/test_cases.dart';

Future<void> main() async {
  final logger = Logger()
    ..info('')
    ..info('╔══════════════════════════════════════════════════════╗')
    ..info('║   Minimax vs Alpha-Beta Pruning — Benchmark Runner   ║')
    ..info('║   Tic-Tac-Toe Depth-Based Performance Study          ║')
    ..info('╚══════════════════════════════════════════════════════╝')
    ..info('');

  final runner = BenchmarkRunner();
  const exporter = CsvExporter();

  // ── Run benchmark ──────────────────────────────────────────────
  final progress = logger.progress(
    'Running ${TestCases.all.length * 3} benchmark cases (5 runs each)',
  );
  final results = runner.run(TestCases.all);
  progress.complete('Benchmark complete — ${results.length} results collected');

  // ── Print results table ────────────────────────────────────────
  logger
    ..info('')
    ..info('Results:')
    ..info('');
  _printHeader(logger);

  var sn = 1;
  for (final r in results) {
    _printRow(logger, r, sn++);
  }

  _printFooter(logger);

  // ── Move agreement summary ─────────────────────────────────────
  final allMatch = results.every((r) => r.movesMatch);
  logger
    ..info('')
    ..info('Move Agreement (Minimax vs Alpha-Beta):');

  if (allMatch) {
    logger.success(
      '  ✓ Both algorithms returned identical moves across all'
      ' ${results.length} runs',
    );
  } else {
    final mismatches = results.where((r) => !r.movesMatch).toList();
    for (final r in mismatches) {
      logger.err(
        '  ✗ ${r.testCase.id} depth ${r.depth} — '
        'Minimax: ${r.minimaxResult.bestMove}, '
        'AlphaBeta: ${r.alphaBetaResult.bestMove}',
      );
    }
  }

  // ── Export CSV ────────────────────────────────────────────────
  logger.info('');
  final exportProgress = logger.progress('Exporting results to CSV');
  await exporter.export(results, 'data/results.csv');
  exportProgress.complete('Results exported to data/results.csv');
  logger.info('');
}

/// Prints the table header.
void _printHeader(Logger logger) {
  logger
    ..info(
      '${'S.N.'.padRight(6)}'
      '${'ID'.padRight(6)}'
      '${'Stage'.padRight(14)}'
      '${'Depth'.padRight(8)}'
      '${'MM Nodes'.padRight(12)}'
      '${'AB Nodes'.padRight(12)}'
      '${'MM Time(μs)'.padRight(14)}'
      '${'AB Time(μs)'.padRight(14)}'
      '${'Pruning%'.padRight(10)}'
      'Match',
    )
    ..info('─' * 98);
}

/// Prints a single result row.
void _printRow(Logger logger, BenchmarkResult r, int sn) {
  final pruning = r.pruningEfficiency.toStringAsFixed(1);
  final match = r.movesMatch ? '✓' : '✗';
  logger.info(
    '${sn.toString().padRight(6)}'
    '${r.testCase.id.padRight(6)}'
    '${r.testCase.stage.label.padRight(14)}'
    '${r.depth.toString().padRight(8)}'
    '${r.minimaxResult.nodesExplored.toString().padRight(12)}'
    '${r.alphaBetaResult.nodesExplored.toString().padRight(12)}'
    '${r.minimaxResult.elapsedMicroseconds.toString().padRight(14)}'
    '${r.alphaBetaResult.elapsedMicroseconds.toString().padRight(14)}'
    '${'$pruning%'.padRight(10)}'
    '$match',
  );
}

/// Prints the table footer.
void _printFooter(Logger logger) {
  logger.info('─' * 98);
}
