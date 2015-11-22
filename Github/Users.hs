-- | The Github Users API, as described at
-- <http://developer.github.com/v3/users/>.
module Github.Users (
 userInfoFor
,userInfoFor'
,conditionalUserInfoFor'
,userInfoCurrent'
,module Github.Data
) where

import Github.Data
import Github.Private

-- | The information for a single user, by login name.
-- | With authentification
--
-- > userInfoFor' (Just ("github-username", "github-password")) "mike-burns"
userInfoFor' :: Maybe GithubAuth -> String -> IO (Either Error DetailedOwner)
userInfoFor' auth userName = githubGet' auth ["users", userName]

-- | The information for a single user, by login name.
--
-- > userInfoFor "mike-burns"
userInfoFor :: String -> IO (Either Error DetailedOwner)
userInfoFor = userInfoFor' Nothing

-- | The information for a single user, by login name.
-- | With authentification, and conditional on an 'ETag' value.
--
-- > conditionalUserInfoFor (Just (GithubOAuth "...")) (Just (ETag "...")) "mike-burns"
conditionalUserInfoFor' :: Maybe GithubAuth -> Maybe ETag -> String -> IO (Either Error (Maybe ETag, DetailedOwner))
conditionalUserInfoFor' auth etag userName = githubGetConditional auth etag ["users", userName]

-- | Retrieve information about the user associated with the supplied authentication.
--
-- > userInfoCurrent' (GithubOAuth "...")
userInfoCurrent' :: Maybe GithubAuth -> IO (Either Error DetailedOwner)
userInfoCurrent' auth = githubGet' auth ["user"]
