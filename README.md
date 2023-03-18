[![pub package](https://img.shields.io/pub/v/js_packer.svg?logo=dart&logoColor=00b9fc)](https://pub.dev/packages/js_packer)
[![Last Commits](https://img.shields.io/github/last-commit/thitlwincoder/js_packer?logo=git&logoColor=white)](https://github.com/thitlwincoder/js_packer/commits/master)
[![GitHub repo size](https://img.shields.io/github/repo-size/thitlwincoder/js_packer)](https://github.com/thitlwincoder/js_packer)
[![License](https://img.shields.io/github/license/thitlwincoder/js_packer?logo=open-source-initiative&logoColor=green)](https://github.com/thitlwincoder/js_packer/blob/master/LICENSE)
<br>
[![Uploaded By](https://img.shields.io/badge/uploaded%20by-thitlwincoder-blue)](https://github.com/thitlwincoder)
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