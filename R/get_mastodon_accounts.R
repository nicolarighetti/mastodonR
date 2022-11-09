#' get_mastodon_accounts
#'
#' Function to get Mastodon accounts from the "name" field on Twitter.
#'
#' @param followers_following the followers and/or following list of users
#' @noRd

get_mastodon_accounts <- function(followers_following) {
  account_list <- followers_following[grepl("@", followers_following[, "name"]),]
  account_list <- unlist(strsplit(account_list$name, " "))
  account_list <- account_list[grepl("@", account_list)]

  keep_1 <- lengths(regmatches(account_list, gregexpr("@", account_list))) > 1
  keep_2 <- grepl("/@", account_list)
  keep_3 <- grepl(paste0(mastodon_instances, collapse = "|"), account_list)

  account_list <- account_list[unique(grep("TRUE", keep_1),
                                      grep("TRUE", keep_2),
                                      grep("TRUE", keep_3))]

  return(account_list)
}
