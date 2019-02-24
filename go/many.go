package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
)

func main() {
	stdin := bufio.NewScanner(os.Stdin)
	stdin.Scan()
	text := stdin.Text()
	t, _ := strconv.ParseFloat(text, 64)
	fmt.Printf("%.20f,%.20f,%.20f,%.20f,%.20f",
		math.Sin(t),
		math.Cos(t),
		math.Tan(t),
		math.Atan(t),
		math.Atan2(t, t/2))
}
