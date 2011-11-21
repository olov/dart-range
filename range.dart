#library("range");

class Range implements Collection<int> {
  Range(int this.start, int this.stop, [int this.step = 1]) {
    if (step == 0) {
      throw new IllegalArgumentException("step must not be 0");
    }
  }

  Iterator<int> iterator() {
    if (step == 1) {
      return new RangeIncrementingIterator(start, stop);
    }
    else {
      return new RangeIterator(start, stop, step);
    }
  }

  int get length() {
    if ((step > 0 && start > stop) || (step < 0 && start < stop)) {
      return 0;
    }
    return (stop - start + step) ~/ step;
  }

  bool isEmpty() => length == 0;

  String toString() {
    return step == 1 ?
      "Range($start, $stop)" : "Range($start, $stop, $step)";
  }

  bool every(bool f(int)) {
    for (int e in this) {
      if (f(e) == false) {
        return false;
      }
    }
    return true;
  }

  bool some(bool f(int)) {
    for (int e in this) {
      if (f(e)) {
        return true;
      }
    }
    return false;
  }

  void forEach(void f(int)) {
    for (int e in this) {
      f(e);
    }
  }

  List<int> filter(bool f(int)) {
    var l = new List<int>();
    for (int e in this) {
      if (f(e)) {
        l.add(e);
      }
    }
    return l;
  }

  List map(f(int)) {
    var l = new List();
    for (int e in this) {
      l.add(f(e));
    }
    return l;
  }

  bool operator ==(Range other) {
    return (other != null && start == other.start && stop == other.stop &&
            step == other.step);
  }

  final int start;
  final int stop;
  final int step;
}

class RangeIterator implements Iterator<int> {
  RangeIterator(int this._pos, int this._stop, int this._step);

  bool hasNext() {
    return _step > 0  ? _pos <= _stop : _pos >= _stop;
  }
  int next() {
    if (!hasNext()) {
      throw new NoMoreElementsException();
    }
    var tmp = _pos;
    _pos += _step;
    return tmp;
  }

  int _pos;
  final int _stop;
  final int _step;
}

class RangeIncrementingIterator implements Iterator<int> {
  RangeIncrementingIterator(int this._pos, this._stop);
  bool hasNext() => _pos <= _stop;
  int next() {
    if (!hasNext()) {
      throw new NoMoreElementsException();
    }
    return _pos++;
  }
  int _pos;
  final int _stop;
}

Range range(int start, int stop, [int step = 1]) => new Range(start, stop, step);
Range indices(lengthable) => new Range(0, lengthable.length - 1);
