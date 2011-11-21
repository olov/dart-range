#import("range.dart");

main() {
  test("for-in iterator", () {
    int sum = 0;
    for (int v in range(0, 10)) {
      sum += v;
    }
    Expect.equals(0+1+2+3+4+5+6+7+8+9+10, sum);
  });

  test("indices", () {
    var str = "abc";
    Expect.equals(range(0, str.length - 1), indices(str));
  });

  test("explicit iterator", () {
    var r = range(0, 10);

    // iterate two times to validate that iterator doesn't affect range state
    for (int n = 0; n < 2; n++) {
      var it = r.iterator();

      int sum = 0;
      while (it.hasNext()) {
        sum += it.next();
      }
      Expect.equals(0+1+2+3+4+5+6+7+8+9+10, sum);
    }
  });

  test("forEach", () {
    int sum = 0;
    range(0, 10).forEach((e) => sum += e);
    Expect.equals(0+1+2+3+4+5+6+7+8+9+10, sum);
  });

  test("some", () {
    Expect.isTrue(range(0, 10).some((e) => e > 5));
    Expect.isFalse(range(0, 10).some((e) => e > 10));
  });

  test("every", () {
    Expect.isTrue(range(0, 10).every((e) => e >= 0));
    Expect.isFalse(range(0, 10).every((e) => e > 5));
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
    Expect.equals(6, list.length);
    int sum = 0;
    list.forEach((e) => sum += e);
    Expect.equals(0+1+2+3+4+5, sum);
  });

  test("toString", () {
    Expect.stringEquals("Range(0, 1)", range(0, 1).toString());
    Expect.stringEquals("Range(0, 2, 3)", range(0, 2, 3).toString());
    Expect.stringEquals("Range(-1, -2, -3)", range(-1, -2, -3).toString());
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
    Expect.equals(6, range(0, 5).length);
    Expect.equals(5, range(1, 5).length);
    Expect.equals(7, range(-1, 5).length);
    Expect.equals(6, range(0, 10, 2).length);
    Expect.equals(6, range(0, -10, -2).length);
    Expect.equals(6, range(10, 0, -2).length);
    Expect.equals(6, range(-10, 0, 2).length);
    Expect.equals(4, range(-5, 5, 3).length);
    Expect.equals(4, range(5, -5, -3).length);

    // empty ranges
    Expect.equals(0, range(0, -1).length);
    Expect.equals(0, range(-1, 0, -1).length);
    Expect.equals(0, range(2, 0).length);
    Expect.equals(0, range(0, 2, -1).length);
    Expect.equals(0, range(-1, -2).length);
    Expect.equals(0, range(-2, -1, -1).length);

    // ranges of length 1
    Expect.equals(1, range(0, 0).length);
    Expect.equals(1, range(-3, -3).length);
    Expect.equals(1, range(1, 10, 10).length);
    Expect.equals(1, range(-1, -10, -10).length);

    // test permutations of start, stop and step varying from -8 to 8
    for (int start = -8; start <= 8; start++) {
      for (int stop = -8; stop <= 8; stop++) {
        for (int step = -8; step <= 8; step++) {
          if (step == 0) {
            continue;
          }
          var r = range(start, stop, step);
          Expect.equals(new List.from(r).length, r.length);
        }
      }
    }
  });

  test("operator ==", () {
    Expect.equals(range(1, 2, 3), range(1, 2, 3));
    Expect.notEquals(range(1, 2, 3), range(1, 0, 3));
    Expect.notEquals(range(1, 2, 3), range(0, 2, 3));
    Expect.notEquals(range(1, 2, 3), range(1, 2));
    Expect.notEquals(range(1, 1), range(2, 2));
    Expect.notEquals(range(1, 2, 3), null);
  });

  test("iterator next exception", () {
    var it = range(1, 2).iterator();
    it.next();
    it.next();
    Expect.throws(() { it.next(); });
  });

  test("step 0 exception", () {
    Expect.throws(() { range(1, 2, 0); });
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
  var iterExpected = expected.iterator();
  var iterActual = actual.iterator();

  int i = 0;
  while (iterExpected.hasNext() && iterActual.hasNext()) {
    var expectedElement = iterExpected.next();
    var actualElement = iterActual.next();
    if (expectedElement != actualElement) {
      throw new ExpectException('Expect_iterableEquals(at index $i, ' +
                                'expected: <$expectedElement>, actual: <$actualElement>) fails');
    }
    ++i;
  }
  if (iterExpected.hasNext() != iterActual.hasNext()) {
    throw new ExpectException('Expect_iterableEquals(hasNext, ' +
                              'expected: <${iterExpected.hasNext()}>, ' +
                              'actual: <${iterActual.hasNext()}>) fails');
  }
}
