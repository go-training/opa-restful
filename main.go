package main

import (
	"bytes"
	_ "embed"
	"fmt"
	"io/ioutil"
	"net/http"
	"time"
)

//go:embed input.json
var input []byte

func main() {
	url := "http://localhost:8181/v1/data/rbac/authz/allow"
	method := "POST"

	payload := bytes.NewReader(input)

	client := &http.Client{
		Timeout: 5 * time.Second,
	}
	req, err := http.NewRequest(method, url, payload)

	if err != nil {
		fmt.Println(err)
		return
	}
	req.Header.Add("Content-Type", "application/json")

	res, err := client.Do(req)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer res.Body.Close()

	body, err := ioutil.ReadAll(res.Body)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(string(body))
}
