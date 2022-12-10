import 'dart:convert';
import 'dart:io';

class Dir {
  String name;
  Dir? parent;
  late List<Dir> childDirs;
  late List<MyFile> files;
  late int size;
  late String path;

  Dir(this.name, [this.parent = null]) {
    this.size = 0;
    this.childDirs = [];
    this.files = [];
    this.path = (this.parent?.path ?? "") + this.name + "/";
  }

  int CalcSize() {
    var fileSizes = this.files.map((f) => f.size).fold(0, (a, b) => a + b);
    var dirSizes =
        this.childDirs.map((c) => c.CalcSize()).fold(0, (a, b) => a + b);

    this.size = fileSizes + dirSizes;
    return this.size;
  }

  int SumUnder() {
    return (this.size <= 100000 ? this.size : 0) +
        this.childDirs.map((c) => c.SumUnder()).fold(0, (a, b) => a + b);
  }
}

class MyFile {
  String name;
  int size;

  MyFile(this.name, this.size);
}

void main() async {
  final lines = utf8.decoder
      .bind(File('./input.txt').openRead())
      .transform(const LineSplitter());

  var root = new Dir("");
  root.parent = root;
  var currDir = root;

  await for (final line in lines) {
    if (line.startsWith("\$ cd")) {
      if (line.startsWith("\$ cd /")) {
        currDir = root;
      }
      if (line == "\$ cd ..") {
        var parent = currDir.parent;
        if (parent != null) {
          currDir = parent;
        } else {
          stdout.writeln("oh no");
          exit(1);
        }
      } else {
        var targetDir = line.replaceFirst("\$ cd ", "");
        for (var dir in currDir.childDirs) {
          if (dir.name == targetDir) {
            currDir = dir;
            break;
          }
        }
      }
    } else if (!line.startsWith("\$")) {
      if (line.startsWith("dir ")) {
        var newDir = line.replaceFirst("dir ", "");
        currDir.childDirs.add(new Dir(newDir, currDir));
      } else {
        var parts = line.split(" ");
        currDir.files.add(new MyFile(
          parts[1],
          int.tryParse(parts[0]) ?? 0,
        ));
      }
    } else if (line.startsWith("\$ ls")) {
      continue;
    } else {
      stdout.writeln("UNKNOWN LINE:");
      stdout.writeln(line);
      exit(1);
    }
  }

  root.CalcSize();
  stdout.writeln(root.SumUnder());
}
