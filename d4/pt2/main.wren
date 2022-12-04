import "io" for File

var f = File.read("./input.txt")
var lines = f.split("\n")
lines.remove("")
var count = 0

for (line in lines) {
  var halves = line.split(",")
	var left = halves[0].split("-")
	var right = halves[1].split("-")
	if (Num.fromString(left[1]) >= Num.fromString(right[0]) &&
			Num.fromString(left[0]) <= Num.fromString(right[1])) {
		count=count+1
	}
}

System.print(count)
