package main

import (
        "encoding/json"
        "fmt"
        "os"  // unused package
        "goji.io"
        "golang.org/x/net/context"
        "net/http"
        "goji.io/pat"
)

type book struct {
        ISBN  string "json:isbn"
        Title  string "json:name"
        Authors string "json:author"
        Price string "json:price"
}
