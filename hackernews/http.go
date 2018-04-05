// +build !gopherjs

package hackernews

import (
	"io/ioutil"
	"net/http"

	"github.com/pkg/errors"
)

func httpGet(u string) ([]byte, error) {
	r, err := http.Get(u)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	defer r.Body.Close()
	b, err := ioutil.ReadAll(r.Body)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	return b, nil
}
