''' Provides function that connects to twitter
    Usage is shown in main test program
'''

import tweepy

# put the authorization codes here from your twitter developer application
CONSUMER_KEY = 'Your Key'
CONSUMER_SECRET = 'Your Secret'
OAUTH_TOKEN = 'Your Token'
OAUTH_SECRET = 'Your Auth Secret'
          

# login to Twitter with ordinary rate limiting
def oauth_login():
  # get the authorization from Twitter and save in the twepy package
  auth = tweepy.OAuthHandler(CONSUMER_KEY,CONSUMER_SECRET)
  auth.set_access_token(OAUTH_TOKEN,OAUTH_SECRET)
  tweepy_api = tweepy.API(auth)

  # if a null api is returned, give error message
  if (not tweepy_api):
      print ("Problem Connecting to API with OAuth")

  # return the twitter api object that allows access for the tweepy api functions
  return tweepy_api

# login to Twitter with extended rate limiting
#  must be used with the tweepy Cursor to wrap the search and enact the waits
def appauth_login():
  CONSUMER_KEY = 'PAx7RXiuo6JTjikKZH94hKliI'
  CONSUMER_SECRET = 'toV6d2hAKNvGruzvpZUcrKkCphv5gMwHWx4ip788jTvJv6WZyW'
  auth = tweepy.AppAuthHandler(CONSUMER_KEY, CONSUMER_SECRET)

 #With the bearer token received, we are now ready for business:

  api = tweepy.API(auth)
  # get the authorization from Twitter and save in the twepy package
 # auth = tweepy.AppAuthHandler(CONSUMER_KEY,CONSUMER_SECRET)
  # apparently no need to set the other access tokens
  #tweepy_api = tweepy.API(auth, wait_on_rate_limit=True, wait_on_rate_limit_notify=True)

  # if a null api is returned, give error message
  if (not api):
      print ("Problem Connecting to API with AppAuth")

  # return the twitter api object that allows access for the tweepy api functions
  return api
    
# Test program to show how to connect
if __name__ == '__main__':
  tweepy_api = oauth_login()
  print ("Twitter OAuthorization: ", tweepy_api)
  tweepy_api = appauth_login()
  print ("Twitter AppAuthorization: ", tweepy_api)