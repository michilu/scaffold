# scaffold
A scaffold

# ref
- https://github.com/dart-lang/angular/tree/master/examples/hacker_news_pwa

# optimize

1. minify: https://github.com/gopherjs/gopherjs#performance-tips

:

    7,196,874 bytes:  100%:   $ gopherjs build
    4,661,791 bytes:   65%:   $ gopherjs build --minify

2. UglifyJS 3: https://github.com/mishoo/UglifyJS2

:

    4,547,810 bytes:   63%:   $ gopherjs build --minify && uglifyjs
    4,274,152 bytes:   59%:   $ gopherjs build --minify && uglifyjs --compress
    3,843,890 bytes:   53%:   $ gopherjs build --minify && uglifyjs --compress --mangle

# Wercker CI

setup the environment.
see: https://app.wercker.com/<organization>/<application>/environment

- 'SLACK_URL' needs by the 'slack-notifier' step. see: https://slack.com/apps/A0F7XDUAZ-incoming-webhooks
- 'SLACK_TOKEN' needs by th e'slackapi' command. see: https://api.slack.com/custom-integrations/legacy-tokens

setup the workflows.
see: https://app.wercker.com/<organization>/<application>/workflows
