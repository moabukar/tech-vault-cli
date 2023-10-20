package questions

import (
	"bytes"
	"io/ioutil"
	"net/http"
	"testing"

	"github.com/jarcoal/httpmock"
	"github.com/stretchr/testify/assert"
)

type MockHttpClient struct{}

func (m *MockHttpClient) Get(url string) (*http.Response, error) {
	// Mocking a response with a 200 status and a sample body
	mockBody := "<summary>Question 1</summary><summary>Question 2</summary>"
	r := ioutil.NopCloser(bytes.NewReader([]byte(mockBody)))
	return &http.Response{
		StatusCode: 200,
		Body:       r,
	}, nil
}

func TestGetRandomQuestion(t *testing.T) {

	httpmock.Activate()
	defer httpmock.DeactivateAndReset()

	client := &http.Client{}

	mockReadme := `<summary>Mock Question 1</summary><summary>Mock Question 2</summary>`
	httpmock.RegisterResponder("GET", "https://raw.githubusercontent.com/moabukar/tech-vault/main/README.md",
		httpmock.NewStringResponder(200, mockReadme))

	question, err := GetRandomQuestion(client)

	assert.Nil(t, err, "Expecting error to be nil")
	assert.True(t, question == "Mock Question 1" || question == "Mock Question 2", "Received unexpected question: "+question)
}
