package main

import "bufio"
import "os/exec"

var methods = [2]string{
	"xkb:us::eng",
	"pinyin",
}

func main() {
	cmd := exec.Command("ibus", "engine")
	out, _ := cmd.StdoutPipe()
	cmd.Start()
	r := bufio.NewScanner(out)
	if r.Scan() {
		currentMethod := r.Text()
		for i := 0; i < len(methods); i++ {
			// Try to find and switch
			if currentMethod == methods[i] {
				exec.Command("ibus", "engine", methods[(i+1)%len(methods)]).Run()
				exec.Command("herbstclient", "emit_hook", "ibus").Run()
				break
			}
		}
	}
}
