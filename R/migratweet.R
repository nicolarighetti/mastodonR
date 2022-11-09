#' migratweet
#'
#' Function to collect Mastodon accounts put in the "name" field on Twitter.
#'
#' @param user the username on Twitter
#' @param followers collect Mastodon accounts from followers. Default to TRUE
#' @param following collect Mastodon accounts from following Default to TRUE
#' @param academicAPI the Academic Twitter API bearer token. If not specified, retrieved from the from the environmental variable "TWITTER_BEARER" using \link[academictwitteR]{get_bearer}.
#'
#' @return a vector of detected Mastodon accounts and a csv file saved in the working directory that can be imported on Mastodon to add the listed accounts.
#'
#' @details
#' Simple function to extract Mastodon accounts from the name field on Twitter using a simple series of regex routines.
#'
#' @examples
#' \dontrun{
#' account_list <- migratweet(user = "NicRighetti")
#' head(account_list)
#' }
#'
#' @importFrom academictwitteR get_user_id get_bearer get_user_followers get_user_following
#' @importFrom utils write.table
#'
#' @export


migratweet <- function(user = NULL,
                       followers = TRUE,
                       following = TRUE,
                       academicAPI = NULL){

  user <- user

  if(is.null(academicAPI)){
    academicAPI <- academictwitteR::get_bearer()
  }

  user_id <- academictwitteR::get_user_id(usernames = user,
                                          bearer_token = academicAPI)

  if (isTRUE(followers)){
    follower_list <- academictwitteR::get_user_followers(x = user_id,
                                                         bearer_token = academicAPI)
  }

  if (isTRUE(following)){
    following_list <- academictwitteR::get_user_following(x = user_id,
                                                          bearer_token = academicAPI)
  }


  if (isTRUE(followers)){
    followers_mastodon <- get_mastodon_accounts(followers_following = follower_list)
    followers_mastodon <- gsub("\\(|\\)", "", followers_mastodon)
  }

  if (isTRUE(following)){
    following_mastodon <- get_mastodon_accounts(followers_following = following_list)
    following_mastodon <- gsub("\\(|\\)", "", following_mastodon)
  }

  # return
  if (isTRUE(followers) & isTRUE(following)){
    followers_following_mastodon <- unique(c(followers_mastodon, following_mastodon))
    write.table(followers_following_mastodon, file = "twitter_followers_following_list_mastodon.csv",
                row.names = FALSE, col.names = FALSE, sep = ",")
    return(followers_following_mastodon)
  }

  if (isTRUE(followers) & isFALSE(following)){
    write.table(followers_mastodon, file = "twitter_followers_list_mastodon.csv",
                row.names = FALSE, col.names = FALSE, sep = ",")
    return(followers_mastodon)
  }

  if (isFALSE(followers) & isTRUE(following)){
    write.table(following_mastodon, file = "twitter_following_list_mastodon.csv",
                row.names = FALSE, col.names = FALSE, sep = ",")
    return(following_mastodon)
  }

}

