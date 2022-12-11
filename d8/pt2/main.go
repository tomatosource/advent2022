package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	grid, gridSize, err := getGrid()
	if err != nil {
		panic(err)
	}

	results := make(chan int, 10)
	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			go score(i, j, grid, results)
		}
	}

	max := 0
	for i := 0; i < gridSize; i++ {
		if v := <-results; v >= max {
			max = v
		}
	}

	fmt.Println(max)
}

func getGrid() ([][]int, int, error) {
	dat, err := os.ReadFile("./input.txt")
	if err != nil {
		return nil, 0, err
	}
	lines := strings.Split(string(dat), "\n")
	lines = lines[:len(lines)-1]

	grid := [][]int{}
	for _, line := range lines {
		row := []int{}
		for _, c := range line {
			val, err := strconv.Atoi(string(c))
			if err != nil {
				return nil, 0, err
			}
			row = append(row, val)
		}
		grid = append(grid, row)
	}

	return grid, len(grid) * len(grid[0]), nil
}

func score(i, j int, grid [][]int, result chan<- int) {
	if i == 0 || j == 0 || i == len(grid)-1 || j == len(grid[0])-1 {
		result <- 0
		return
	}

	up, down, right, left := 1, 1, 1, 1

	for {
		if i-up <= 0 || grid[i-up][j] >= grid[i][j] {
			break
		}
		up++
	}
	for {
		if i+down >= len(grid)-1 || grid[i+down][j] >= grid[i][j] {
			break
		}
		down++
	}
	for {
		if j-left <= 0 || grid[i][j-left] >= grid[i][j] {
			break
		}
		left++
	}
	for {
		if j+right >= len(grid[0])-1 || grid[i][j+right] >= grid[i][j] {
			break
		}
		right++
	}
	result <- up * down * left * right
}
