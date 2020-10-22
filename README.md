# js_packer

Decoder for Dean Edwards' JavaScript Packer

## Usage

First call `JSPacker()` with your JS value

```dart
JSPacker jsPacker = JSPacker(eval); // add your eval js code
```

Use `detect` class to check your JS value format is correct

```dart
jsPacker.detect()
```

Use `unpack` class to get value

```dart
jsPacker.unpack()
```

### Example

```dart
JSPacker jsPacker = JSPacker(eval); // add your value

if (jsPacker.detect()) {
    print(jsPacker.unpack());
} else {
    print("Not P.A.C.K.E.R. coded");
}
```