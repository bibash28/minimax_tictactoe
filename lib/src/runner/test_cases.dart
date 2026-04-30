import 'package:minimax_tictactoe/src/models/board.dart';
import 'package:minimax_tictactoe/src/models/test_case.dart';

/// All 25 predefined test cases for the benchmark.
///
/// Organized into three categories:
/// - Early game (E01–E05): 2 cells filled
/// - Mid game (M01–M08): 4–5 cells filled
/// - Late game (L01–L08): 6–7 cells filled
class TestCases {
  // ── Early game boards ────────────────────────────────────────
  // 2 cells filled — large search tree, minimal pruning expected

  /// E01
  /// X | _ | _
  /// ---------
  /// _ | O | _
  /// ---------
  /// _ | _ | _
  static final e01 = TestCase(
    id: 'E01',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E02
  /// _ | X | _
  /// ---------
  /// _ | _ | O
  /// ---------
  /// _ | _ | _
  static final e02 = TestCase(
    id: 'E02',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      null,
      null,
    ]),
  );

  /// E03
  /// _ | _ | X
  /// ---------
  /// _ | O | _
  /// ---------
  /// _ | _ | _
  static final e03 = TestCase(
    id: 'E03',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      null,
      Player.x,
      null,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E04
  /// O | _ | _
  /// ---------
  /// _ | X | _
  /// ---------
  /// _ | _ | _
  static final e04 = TestCase(
    id: 'E04',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      null,
      null,
      null,
      Player.x,
      null,
      null,
      null,
      null,
    ]),
  );

  /// E05
  /// _ | _ | _
  /// ---------
  /// X | _ | _
  /// ---------
  /// _ | O | _
  static final e05 = TestCase(
    id: 'E05',
    stage: GameStage.early,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      null,
      null,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
    ]),
  );

  // ── Mid game boards ──────────────────────────────────────────
  // 4 cells filled — moderate search tree, some forced moves

  /// M01
  /// X | O | _
  /// ---------
  /// _ | X | _
  /// ---------
  /// O | _ | _
  static final m01 = TestCase(
    id: 'M01',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      null,
      Player.x,
      null,
      Player.o,
      null,
      null,
    ]),
  );

  /// M02
  /// X | _ | O
  /// ---------
  /// _ | O | _
  /// ---------
  /// X | _ | _
  static final m02 = TestCase(
    id: 'M02',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      Player.o,
      null,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  /// M03
  /// _ | O | X
  /// ---------
  /// X | _ | _
  /// ---------
  /// _ | O | _
  static final m03 = TestCase(
    id: 'M03',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.o,
      Player.x,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
    ]),
  );

  /// M04
  /// O | X | _
  /// ---------
  /// _ | _ | O
  /// ---------
  /// _ | X | _
  static final m04 = TestCase(
    id: 'M04',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
      null,
      Player.x,
      null,
    ]),
  );

  /// M05
  /// X | _ | _
  /// ---------
  /// O | X | _
  /// ---------
  /// _ | _ | O
  static final m05 = TestCase(
    id: 'M05',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
    ]),
  );

  /// M06
  /// X | _ | _
  /// ---------
  /// O | O | _
  /// ---------
  /// X | _ | _
  static final m06 = TestCase(
    id: 'M06',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      null,
      Player.o,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  /// M07
  /// X | O | _
  /// ---------
  /// X | O | _
  /// ---------
  /// _ | _ | _
  static final m07 = TestCase(
    id: 'M07',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      Player.x,
      Player.o,
      null,
      null,
      null,
      null,
    ]),
  );

  /// M08
  /// O | X | _
  /// ---------
  /// _ | O | _
  /// ---------
  /// X | _ | _
  static final m08 = TestCase(
    id: 'M08',
    stage: GameStage.mid,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      null,
      null,
      Player.o,
      null,
      Player.x,
      null,
      null,
    ]),
  );

  // ── Late game boards ─────────────────────────────────────────
  // 6 cells filled — small search tree, maximum pruning expected

  /// L01
  /// X | O | X
  /// ---------
  /// O | X | _
  /// ---------
  /// _ | _ | O
  static final l01 = TestCase(
    id: 'L01',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      null,
      null,
      Player.o,
    ]),
  );

  /// L02
  /// O | X | O
  /// ---------
  /// X | _ | X
  /// ---------
  /// O | _ | _
  static final l02 = TestCase(
    id: 'L02',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      Player.x,
      Player.o,
      null,
      null,
    ]),
  );

  /// L03
  /// X | O | _
  /// ---------
  /// O | X | O
  /// ---------
  /// X | _ | _
  static final l03 = TestCase(
    id: 'L03',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      null,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      null,
    ]),
  );

  /// L04
  /// _ | O | X
  /// ---------
  /// O | X | _
  /// ---------
  /// X | _ | O
  static final l04 = TestCase(
    id: 'L04',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      null,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      null,
      Player.x,
      null,
      Player.o,
    ]),
  );

  /// L05
  /// X | _ | O
  /// ---------
  /// _ | O | X
  /// ---------
  /// X | O | _
  static final l05 = TestCase(
    id: 'L05',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      null,
      Player.o,
      null,
      Player.o,
      Player.x,
      Player.x,
      Player.o,
      null,
    ]),
  );

  /// L06
  /// X | O | X
  /// ---------
  /// O | X | O
  /// ---------
  /// _ | _ | _
  static final l06 = TestCase(
    id: 'L06',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      Player.x,
      Player.o,
      null,
      null,
      null,
    ]),
  );

  /// L07
  /// X | X | O
  /// ---------
  /// O | O | X
  /// ---------
  /// _ | _ | _
  static final l07 = TestCase(
    id: 'L07',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.x,
      Player.x,
      Player.o,
      Player.o,
      Player.o,
      Player.x,
      null,
      null,
      null,
    ]),
  );

  /// L08
  /// O | X | X
  /// ---------
  /// _ | O | _
  /// ---------
  /// X | _ | O
  static final l08 = TestCase(
    id: 'L08',
    stage: GameStage.late,
    player: Player.x,
    board: Board.fromPlayers(const [
      Player.o,
      Player.x,
      Player.x,
      null,
      Player.o,
      null,
      Player.x,
      null,
      Player.o,
    ]),
  );

  /// All early game test cases.
  static final List<TestCase> earlyGame = [e01, e02, e03, e04, e05];

  /// All mid game test cases.
  static final List<TestCase> midGame = [
    m01,
    m02,
    m03,
    m04,
    m05,
    m06,
    m07,
    m08,
  ];

  /// All late game test cases.
  static final List<TestCase> lateGame = [
    l01,
    l02,
    l03,
    l04,
    l05,
    l06,
    l07,
    l08,
  ];

  /// All 21 test cases combined.
  static final List<TestCase> all = [
    ...earlyGame,
    ...midGame,
    ...lateGame,
  ];
}
