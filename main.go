package main

import (
	"fmt"
	"os"
	"github.com/SharkStudiosSK/zingpackage/zing"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage: zing <command> [arguments]")
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "install":
		if len(os.Args) < 3 {
			fmt.Println("Usage: zing install <zinglet_name>")
			os.Exit(1)
		}
		zingletName := os.Args[2]
		err := zing.Install(zingletName)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error installing zinglet: %v\n", err)
			os.Exit(1)
		}
	case "list":
		err := zing.List()
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error listing zinglets: %v\n", err)
			os.Exit(1)
		}
	case "uninstall":
		if len(os.Args) < 3 {
			fmt.Println("Usage: zing uninstall <zinglet_name>")
			os.Exit(1)
		}
		zingletName := os.Args[2]
		err := zing.Uninstall(zingletName)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error uninstalling zinglet: %v\n", err)
			os.Exit(1)
		}
	default:
		fmt.Printf("Unknown command: %s\n", command)
		os.Exit(1)
	}
}
