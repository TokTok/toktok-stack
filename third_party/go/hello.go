package main

import (
	"fmt"

	"github.com/streamrail/concurrent-map"
)

func Hello() string {
	m := cmap.New()
	m.Set("key", "Hello, world")
	value, ok := m.Get("key")
	if !ok {
		return "error: can't find key"
	}
	return value.(string)
}

func main() {
	fmt.Println(Hello())
}
