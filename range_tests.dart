import "range.dart";
import 'package:unittest/unittest.dart';

main() {
  test("for-in iterator", () {
    int sum = 0;
    for (int v in range(0, 10)) {
      sum += v;
    }
    expect(sum, 0+1+2+3+4+5+6+7+8+9+10);
  });

  test("indices", () {
    var str = "abc";
    expect(range(0, str.length - 1), indices(str));
  });

  test("explicit iterator", () {
    var r = range(0, 10);

    // iterate two times to validate that iterator doesn't affect range state
    for (int n = 0; n < 2; n++) {
      var it = r.iterator;

      int sum = 0;
      while (it.moveNext()) {
        sum += it.current;
      }
      expect(sum, 0+1+2+3+4+5+6+7+8+9+10);
    }
  });

  test("forEach", () {
    int sum = 0;
    range(0, 10).forEach((e) => sum += e);
    expect(sum, 0+1+2+3+4+5+6+7+8+9+10);
  });

  test("some", () {
    expect(range(0, 10).some((e) => e > 5), true);
    expect(range(0, 10).some((e) => e > 10), false);
  });

  test("every", () {
    expect(range(0, 10).every((e) => e >= 0), true);
    expect(range(0, 10).every((e) => e > 5), false);
  });

  test("filter", () {
    var even = range(0, 10).filter((e) => e % 2 == 0);
    Expect_iterableEquals([0, 2, 4, 6, 8, 10], even);
  });

  test("map", () {
    var squares = range(0, 4).map((e) => e * e);
    Expect_iterableEquals([0, 1, 4, 9, 16], squares);
  });

  test("List.from", () {
    List<int> list = new List<int>.from(range(0, 5));
    expect(list.length, 6);
    int sum = 0;
    list.forEach((e) => sum += e);
    expect(sum, 0+1+2+3+4+5);
  });

  test("toString", () {
    expect(range(0, 1).toString(), "Range(0, 1)");
    expect(range(0, 2, 3).toString(), "Range(0, 2, 3)");
    expect(range(-1, -2, -3).toString(), "Range(-1, -2, -3)");
  });

  test("simple ranges", () {
    Expect_iterableEquals([0, 1, 2, 3, 4, 5], range(0, 5));
    Expect_iterableEquals([1, 2, 3, 4, 5], range(1, 5));
    Expect_iterableEquals([-1, 0, 1, 2, 3, 4, 5], range(-1, 5));
    Expect_iterableEquals([0, 2, 4, 6, 8, 10], range(0, 10, 2));
    Expect_iterableEquals([0, -2, -4, -6, -8, -10], range(0, -10, -2));
    Expect_iterableEquals([10, 8, 6, 4, 2, 0], range(10, 0, -2));
    Expect_iterableEquals([-10, -8, -6, -4, -2, 0], range(-10, 0, 2));
    Expect_iterableEquals([-5, -2, 1, 4], range(-5, 5, 3));
    Expect_iterableEquals([5, 2, -1, -4], range(5, -5, -3));

    // empty ranges
    Expect_iterableEquals([], range(0, -1));
    Expect_iterableEquals([], range(-1, 0, -1));
    Expect_iterableEquals([], range(2, 0));
    Expect_iterableEquals([], range(0, 2, -1));
    Expect_iterableEquals([], range(-1, -2));
    Expect_iterableEquals([], range(-2, -1, -1));

    // ranges of length 1
    Expect_iterableEquals([0], range(0, 0));
    Expect_iterableEquals([-3], range(-3, -3));
    Expect_iterableEquals([1], range(1, 10, 10));
    Expect_iterableEquals([-1], range(-1, -10, -10));
  });

  test("length", () {
    expect(6, range(0, 5).length);
    expect(5, range(1, 5).length);
    expect(7, range(-1, 5).length);
    expect(6, range(0, 10, 2).length);
    expect(6, range(0, -10, -2).length);
    expect(6, range(10, 0, -2).length);
    expect(6, range(-10, 0, 2).length);
    expect(4, range(-5, 5, 3).length);
    expect(4, range(5, -5, -3).length);

    // empty ranges
    expect(0, range(0, -1).length);
    expect(0, range(-1, 0, -1).length);
    expect(0, range(2, 0).length);
    expect(0, range(0, 2, -1).length);
    expect(0, range(-1, -2).length);
    expect(0, range(-2, -1, -1).length);

    // ranges of length 1
    expect(1, range(0, 0).length);
    expect(1, range(-3, -3).length);
    expect(1, range(1, 10, 10).length);
    expect(1, range(-1, -10, -10).length);

    // test permutations of start, stop and step varying from -8 to 8
    for (int start = -8; start <= 8; start++) {
      for (int stop = -8; stop <= 8; stop++) {
        for (int step = -8; step <= 8; step++) {
          if (step == 0) {
            continue;
          }
          var r = range(start, stop, step);
          expect(new List.from(r).length, r.length);
        }
      }
    }
  });

  test("operator ==", () {
    expect(range(1, 2, 3)==range(1, 2, 3), true);
    expect(range(1, 2, 3)==range(1, 0, 3), false);
    expect(range(1, 2, 3)==range(0, 2, 3), false);
    expect(range(1, 2, 3)==range(1, 2), false);
    expect(range(1, 1)==range(2, 2), false);
    expect(range(1, 2, 3)==null, false);
  });

  test("iterator next exception", () {
    var it = range(1, 2).iterator;
    it.moveNext();
    it.moveNext();
    expect(it.moveNext(), false);
  });
  
  test("step 0 exception", () {
    var isExceptionThrown = false;
    try {
      range(1, 2, 0);
    } catch (e) {
      isExceptionThrown=true;
      expect(e, isArgumentError);
    }
    expect(isExceptionThrown, true);
  });
  


  print("all tests passed");

  for (int i = 0; i < 10; i++) {
    //performance_test();
  }
}

performance_test() {
  bench("standard for", () {
    double sum = 0.0;
    for (var it = 0; it < 100000; it++) {
      sum += it;
    }
    print("sum is $sum");
  });
  bench("range iterator", () {
    double sum = 0.0;
    for (var it in range(0, 100000)) {
      sum += it;
    }
    print("sum is $sum");
  });
}

bench(String name, fn) {
  var t0 = new Date.now().value;
  fn();
  var dt = new Date.now().value - t0;
  print("$name took $dt ms");
}

test(String name, fn) {
  print("executing $name test");
  fn();
}

void Expect_iterableEquals(Iterable expected, Iterable actual) {
  var iterExpected = expected.iterator;
  var iterActual = actual.iterator;

  int i = 0;
  while (iterExpected.moveNext() && iterActual.moveNext()) {
    var expectedElement = iterExpected.current;
    var actualElement = iterActual.current;
    if (expectedElement != actualElement) {
      throw new TestFailure('Expect_iterableEquals(at index $i, ' +
                                'expected: <$expectedElement>, actual: <$actualElement>) fails');
    }
    ++i;
  }
  if (iterExpected.moveNext() != iterActual.moveNext()) {
    throw new TestFailure('Expect_iterableEquals(moveNext, ' +
                              'expected: <${iterExpected.current}>, ' +
                              'actual: <${iterActual.current}>) fails');
  }
}
