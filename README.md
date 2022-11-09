# mastodonR

R package for interacting with Mastodon.

Currently, it includes a function **migratweet** to scrape the Mastodon account names that users put in the "name" field on Twitter. To run, it requires access to the Twitter Academic API.

The function returns a csv file with the detected Mastodon accounts which can be imported on Mastodon (*Preferences/Import and Export/Import*).


```
# install.packages("devtools")

library("devtools")
devtools::install_github("https://github.com/nicolarighetti/mastodonR")
```

# Migratweet

You can scrape the users you follow and/or who follow you.
The option *academicAPI* allows you to specify your Bearer Token. Otherwise, it is retrieved using the *get_bearer* function of [academictwitteR](https://github.com/cjbarrie/academictwitteR). 

```
account_list <- migratweet(user = "NicRighetti", 
                           followers = TRUE,
                           following = TRUE,
                           academicAPI = NULL
                          )
```



