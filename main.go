package main

import (
	"os"
	"path/filepath"
)

func main() {
	if len(os.Args) != 2 {
		os.Exit(1)
	}

	path, err := filepath.Abs(os.Args[1])
	if err != nil {
		os.Exit(1)
	}
	println(path)
}
