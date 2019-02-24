package main

import (
	"fmt"
	"math"
)

func main() {
	for i := 1; i <= 64; i++ {
		t := math.Pow(2.0, float64(i))
		fmt.Printf("%.20f\n", math.Sin(t))
	}
}
