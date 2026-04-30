import 'dart:io';

import 'package:minimax_tictactoe/src/models/benchmark_result.dart';
import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/search_result.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';
import 'package:minimax_tictactoe/src/runner/csv_exporter.dart';
import 'package:test/test.dart';

void main() {
  late CsvExporter exporter;
  late String testOutputPath;

  setUp(() {
    exporter = const CsvExporter();
    testOutputPath = 'test/output/test_results.csv';
  });

  tearDown(() async {
    final file = File(testOutputPath);
    // Using async file existence check in tearDown is acceptable
    // in tests where we need to verify and clean up test output files.
    // ignore: avoid_slow_async_io
    if (await file.exists()) {
      await file.delete();
    }
  });

  group('CsvExporter', () {
    test('creates file at output path', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      // Using async file existence check is necessary here to verify
      // that the exporter actually created the file on disk.
      // ignore: avoid_slow_async_io
      expect(await File(testOutputPath).exists(), isTrue);
    });

    test('file contains header row', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      final content = await File(testOutputPath).readAsString();
      expect(
        content,
        contains(
          'SN,ID,Stage,Depth,MM_Nodes,AB_Nodes,MM_Time_us,AB_Time_us,'
          'Pruning_Efficiency_%,Moves_Match,MM_BestMove,AB_BestMove',
        ),
      );
    });

    test('file contains one row per result', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      final lines = await File(
        testOutputPath,
      ).readAsLines().then((l) => l.where((line) => line.isNotEmpty).toList());
      // header + 2 results
      expect(lines.length, equals(3));
    });

    test('row contains correct data', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      final content = await File(testOutputPath).readAsString();
      expect(content, contains('E01'));
      expect(content, contains('Early'));
      expect(content, contains('100'));
      expect(content, contains('40'));
    });

    test('pruning efficiency is formatted to 2 decimal places', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      final content = await File(testOutputPath).readAsString();
      expect(content, contains('60.00'));
    });

    test('row contains serial number', () async {
      final results = _mockResults();
      await exporter.export(results, testOutputPath);
      final content = await File(testOutputPath).readAsString();
      expect(content, contains('1,E01'));
      expect(content, contains('2,E01'));
    });
  });
}

List<BenchmarkResult> _mockResults() {
  final testCase = TestCase(
    id: 'E01',
    board: Board.empty(),
    player: Player.x,
    stage: GameStage.early,
  );

  const mm = SearchResult(
    bestMove: 4,
    nodesExplored: 100,
    elapsedMicroseconds: 200,
  );

  const ab = SearchResult(
    bestMove: 4,
    nodesExplored: 40,
    elapsedMicroseconds: 80,
  );

  return [
    BenchmarkResult(
      testCase: testCase,
      depth: 1,
      minimaxResult: mm,
      alphaBetaResult: ab,
    ),
    BenchmarkResult(
      testCase: testCase,
      depth: 2,
      minimaxResult: mm,
      alphaBetaResult: ab,
    ),
  ];
}
