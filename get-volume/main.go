package main

import "os"
import "bufio"
import "regexp"
import "bytes"
import "os/exec"

var pctg = regexp.MustCompile("[0-9]+%")

func main() {
	cmd := exec.Command("amixer", "-D", "pulse", "get", "Master")
	out, _ := cmd.StdoutPipe()
	cmd.Start()
	r := bufio.NewScanner(out)
	var b []byte
	for r.Scan() {
		b = r.Bytes()
	}
	if bytes.Contains(b, []byte("[on]")) {
		os.Stdout.Write(pctg.Find(b))
	} else {
		os.Stdout.WriteString("M")
	}
}
