package main

import (
	"log"
	"net/http"
)

func main() {
	log.Print("Go: Hello World!")

	var url string = "https://golang.org"
	_, err := http.Get(url)
	if err != nil {
		log.Fatal(err)
	} else {
		log.Printf("[%s] https request succeeded", url)
	}
}
