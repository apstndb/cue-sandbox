package main

import (
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/pem"
	"errors"
	"io"
	"log"
	"os"
)

func _main() error {
	privateKeyPem := os.Getenv("PRIVATE_KEY_PEM")
	block, _ := pem.Decode([]byte(privateKeyPem))
	parsedKey, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		return err
	}

	rsaKey, ok := parsedKey.(*rsa.PrivateKey)
	if !ok {
		return errors.New("private key failed rsa.PrivateKey type assertion")
	}

	sha := sha256.New()
	io.Copy(sha, os.Stdin)

	sig, err := rsa.SignPKCS1v15(rand.Reader, rsaKey, crypto.SHA256, sha.Sum(nil))
	if err != nil {
		return err
	}

	os.Stdout.WriteString(base64.RawURLEncoding.EncodeToString(sig))
	// os.Stdout.Write(sig)
	return nil
}

func main() {
	if err := _main(); err != nil {
		log.Fatalln(err)
	}
}
