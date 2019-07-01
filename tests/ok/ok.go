package main

import (
	"encoding/json"
	"fmt"
	"goji.io"
	"goji.io/pat"
	"golang.org/x/net/context"
	"net/http"
	"os" // unused package
)

type book struct {
	ISBN    string "json:isbn"
	Title   string "json:name"
	Authors string "json:author"
	Price   string "json:price"
}
