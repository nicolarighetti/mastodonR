# mastodonR

R package for interacting with Mastodon.

Currently, it includes a function **migratweet** to scrape Mastodon accounts put in the "name" field on Twitter. It requires access to the Twitter Academic API.

The function returns a csv file with the detected Mastodon accounts which can be imported on Mastodon (*Preferences/Import and Export/Import*).


```
# install.packages("devtools")

library("devtools")
devtools::install_github("https://github.com/nicolarighetti/mastodonR")
```
