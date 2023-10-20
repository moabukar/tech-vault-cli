package questions

import (
	"io/ioutil"
	"math/rand"
	"net/http"
	"regexp"
	"time"
)

func GetRandomQuestion() (string, error) {
	url := "https://raw.githubusercontent.com/moabukar/tech-vault/main/README.md"
	resp, err := http.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	content := string(body)
	re := regexp.MustCompile(`<summary>(.*?)<\/summary>`)
	matches := re.FindAllStringSubmatch(content, -1)

	var questions []string
	for _, match := range matches {
		questions = append(questions, match[1])
	}

	rand.Seed(time.Now().UnixNano())
	randomIndex := rand.Intn(len(questions))
	return questions[randomIndex], nil
}
