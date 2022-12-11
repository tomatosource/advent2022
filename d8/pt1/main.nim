import strutils
import std/sequtils
import std/sugar

proc isVisible(grid: seq[seq[int]], i, j: int): bool =
  if i == 0 or j == 0 or i == grid.len-1 or j == grid[0].len-1:
    return true

  var visibleUp = true
  for x in countup(0, i-1):
    if grid[x][j] >= grid[i][j]:
      visibleUp = false
      break

  if visibleUp:
    return true

  var visibleRight = true
  for x in countup(i+1, grid.len-1):
    if grid[x][j] >= grid[i][j]:
      visibleRight = false
      break

  if visibleRight:
    return true

  var visibleLeft = true
  for x in countup(0, j-1):
    if grid[i][x] >= grid[i][j]:
      visibleLeft = false
      break

  if visibleLeft:
    return true

  var visibleDown = true
  for x in countup(j+1, grid.len-1):
    if grid[i][x] >= grid[i][j]:
      visibleDown = false
      break

  if visibleDown:
    return true

  false

let grid = readFile("./input.txt")
  .split({'\n'})
  .filter(x => x != "")
  .map(x => toSeq(x.items))
  .map(xs => xs.map(x => parseInt($x)))

var visibleCount = 0
for i in countup(0, grid.len-1):
  for j in countup(0, grid[i].len-1):
    visibleCount += (if grid.isVisible(i, j): 1 else: 0)

echo visibleCount
