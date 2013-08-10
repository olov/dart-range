## This project has moved
Ilya Kharlamov has taken over maintainership of dart-range, see https://github.com/ilyakharlamov/dart-range

### Usage:

```dart
import "package:range/range.dart";

main() {
  for (int i in range(0, 5)) {
    print (i); //0,1,2,3,4,5
  }
  for (int i in range(0, 8, 2)) {
    print (i); //0,2,4,6,8
  }
  for (int i in range(0, 7, 2)) {
    print (i); //0,2,4,6
  }
}
```
