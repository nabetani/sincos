package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func run(size int) float64 {
	sum := 0.0
	for y := 0; y < size; y++ {
		for x := 0; x < size; x++ {
			sum += math.Sin(float64(x+y) + sum)
			sum += math.Cos(float64(x-y) + sum)
		}
	}
	return sum
}

func main() {
	stdin := bufio.NewScanner(os.Stdin)
	stdin.Scan()
	text := stdin.Text()
	size, _ := strconv.ParseInt(text, 10, 32)
	fmt.Printf("%.20f\n", run(int(size)))
}
