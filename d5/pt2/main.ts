var fs = require("fs");
const moveRe = /move ([0-9]+) from ([0-9]+) to ([0-9]+)/;
const lines = fs.readFileSync("./input.txt").toString().split("\n");

let stacks = lines
  .slice(0, 8)
  .reduce((acc: Array<Array<string>>, curr: string) => {
    for (let i = 0; i < 9; i++) {
      const v = curr[i * 4 + 1];
      if (v !== " ") {
        (acc[i] ??= []).push(v);
      }
    }
    return acc;
  }, [])
  .map((s: Array<string>) => s.reverse());

const answer = lines
  .slice(10)
  .filter((l: string) => l.length > 5)
  .reduce((acc: Array<Array<string>>, m: string) => {
    const matches = m.match(moveRe) || [];
    const from = acc[Number(matches[2]) - 1];
    const count = Number(matches[1]);
    acc[Number(matches[3]) - 1].push(
      ...from.splice(from.length - count, count)
    );
    return acc;
  }, stacks)
  .map((s: Array<string>) => s.pop())
  .join("");

console.log(answer);
