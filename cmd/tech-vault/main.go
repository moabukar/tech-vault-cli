package main

import (
	"fmt"
	"log"
	"os"

	"github.com/moabukar/tech-vault-cli/pkg/questions"
	"github.com/urfave/cli/v2"
)

func main() {
	app := &cli.App{
		Name:  "tech-vault",
		Usage: "Get random tech interview questions",
		Commands: []*cli.Command{
			{
				Name:  "random",
				Usage: "Show a random tech question",
				Action: func(c *cli.Context) error {
					question, err := questions.GetRandomQuestion()
					if err != nil {
						log.Fatalf("Error fetching question: %v", err)
					}
					fmt.Println("Random Question:", question)
					return nil
				},
			},
		},
	}

	err := app.Run(os.Args)
	if err != nil {
		log.Fatal(err)
	}
}
