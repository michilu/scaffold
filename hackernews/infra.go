package hackernews

import (
	"fmt"

	"github.com/pkg/errors"
)

const (
	defaultBaseUrl = "https://api.hnpwa.com/v0"
)

var (
	cacheFeedKey    string
	cacheFeedResult interface{}
)

type (
	hnAPI struct {
		b string
	}
)

// NewHackerNewsAPI returns a new HackerNews via API.
func NewHackerNewsAPI(baseUrl string) HackerNews {
	if baseUrl == "" {
		baseUrl = defaultBaseUrl
	}
	return &hnAPI{b: baseUrl}
}

func (h *hnAPI) GetFeed(n string, p int) (interface{}, error) {
	var (
		url = fmt.Sprintf("%s/%s/%d.json", h.b, n, p)
	)
	if cacheFeedKey == url {
		return cacheFeedResult, nil
	}
	b, err := httpGet(url)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	v, err := jsonUnmarshalFeed(b)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	cacheFeedKey = url
	cacheFeedResult = v
	return v, nil
}

func (h *hnAPI) GetItem(i string) (interface{}, error) {
	var (
		url = fmt.Sprintf("%s/item/%s.json", h.b, i)
	)
	b, err := httpGet(url)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	v, err := jsonUnmarshalItem(b)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	return *v, nil
}
