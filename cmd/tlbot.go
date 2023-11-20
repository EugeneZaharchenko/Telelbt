package cmd

import (
	"fmt"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	TeleToken = os.Getenv("TELE_TOKEN")
)

var kbotCmd = &cobra.Command{
	Use:   "kbot",
	Short: "A brief desc of command",
	Long:  "The long desc of a command",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("kbot %s started", appVersion)
		kbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please, go AWAY! And check %s", err)
			return
		}

		kbot.Handle(telebot.OnText, func(m telebot.Context) error {
			return err
		})

		kbot.Start()

	},
}
