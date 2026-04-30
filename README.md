---

## Getting Started 🚀

**Requirements:** Dart SDK `^3.11.0`

Clone the repository:

```sh
git clone https://github.com/bibash28/minimax-tictactoe
cd minimax_tictactoe
dart pub get
```

---

## Running the Benchmark

```sh
dart run
```

This will:

1. Run all 21 board configurations at depths 1, 2, and 3
2. Execute each case 5 times and record the median
3. Print a full results table to console
4. Export results to `data/results.csv`

---

## Running Tests 🧪

```sh
dart test
```

---

## Running Tests with Coverage

```sh
dart test --coverage=coverage
dart run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

Or use the coverage script:

```sh
./scripts/coverage.sh
```

---

## Research Context

This benchmark was developed as part of:

> **Minimax with Alpha-Beta Pruning: Depth-Based Performance in Tic-Tac-Toe**
> Bibash Shrestha

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
