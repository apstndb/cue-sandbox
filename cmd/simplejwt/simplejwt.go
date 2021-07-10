package main

import (
	"bytes"
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"errors"
	"flag"
	"log"
	"os"
)

func main() {

	if err := run(); err != nil {
		log.Fatalln(err)
	}
}

func marshalBase64JSON(i interface{}) (string, error) {
	b, err := json.Marshal(i)
	if err != nil {
		return "", err
	}

	return base64.RawURLEncoding.EncodeToString(b), nil
}

func run() error {
	kid := flag.String("kid", "", "")
	flag.Parse()
	privateKeyPem := os.Getenv("PRIVATE_KEY_PEM")
	if privateKeyPem == "" {
		return errors.New("environment variable PRIVATE_KEY_PEM is missing")
	}
	block, _ := pem.Decode([]byte(privateKeyPem))
	parsedKey, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		return err
	}
	rsaKey, ok := parsedKey.(*rsa.PrivateKey)
	if !ok {
		return errors.New("private key failed rsa.PrivateKey type assertion")
	}

	type jwtHeader struct {
		Kid string `json:"kid,omitempty"`
		Alg string `json:"alg,omitempty"`
		Typ string `json:"typ,omitempty"`
	}
	var buf bytes.Buffer
	header64, err := marshalBase64JSON(jwtHeader{Kid: *kid, Alg: "RS256", Typ: "JWT"})
	if err != nil {
		return err
	}

	var i interface{}
	if err := json.NewDecoder(os.Stdin).Decode(&i); err != nil {
		return err
	}
	claims64, err := marshalBase64JSON(&i)
	if err != nil {
		return err
	}

	buf.WriteString(header64)
	buf.WriteString(".")
	buf.WriteString(claims64)

	sha := sha256.Sum256(buf.Bytes())
	sig, err := rsa.SignPKCS1v15(rand.Reader, rsaKey, crypto.SHA256, sha[:])
	if err != nil {
		return err
	}

	_, err = os.Stdout.WriteString(buf.String() + "." + base64.RawURLEncoding.EncodeToString(sig))
	return err
}
