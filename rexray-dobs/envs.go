package main

import (
	"fmt"
	"os"
)

func main() {
	// Get all environment variables
	env := os.Environ()

	// Print each environment variable
	for _, e := range env {
		fmt.Println(e)
	}
}
