sum <- 0

for (line in readLines("./input.txt")) {
  chars <- strsplit(line, "")[[1]]
  start <- head(chars, length(chars) / 2)
  end <- tail(chars, length(chars) / 2)

  for (c in start) {
    if (is.element(c, end)) {
      if (utf8ToInt(c) >= 96) {
        sum <- sum + which(letters == c)[[1]]
        break
      } else {
        sum <- sum + which(LETTERS == c) + 26
        break
      }
    }
  }
}

print(sum)
