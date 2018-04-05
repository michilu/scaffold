// +build gopherjs

package hackernews

import (
	"github.com/pkg/errors"
	"honnef.co/go/js/xhr"
)

func httpGet(u string) ([]byte, error) {
	b, err := xhr.Send("GET", u, nil)
	if err != nil {
		return nil, errors.WithStack(err)
	}
	return b, nil
}
