# Twitter - Part II

This is a basic twitter app to view, compose, favorite, and retweet tweets.

Time spent: **8** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can compose a tweet. (4pts)
- [x] User can favorite a tweet. (4pts)
- [x] User can retweet a tweet. (2pts)

The following **bonus** features are implemented:

- [ ] When composing a tweet, user sees a countdown for the number of characters remaining for the tweet (out of 140) (2pts)
- [ ] User can view their profile in a profile tab. (3pts)
- [ ] User sees embedded images in tweet if available. (3pts)
- [x] Retweet and favorite counts are updated 

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/cV2IUxq.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />


# Twitter - Part I

This is a basic twitter app to read your tweets.

Time spent: **30** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User sees app icon in home screen and styled launch screen. (1pt)
- [x] User can log in. (1pt)
- [x] User can log out. (1pt)
- [x] User stays logged in across restarts. (1pt)
- [x] User can view tweets with the user profile picture, username, and tweet text. (6pts)

The following **bonus** features are implemented:

- [x] User can pull to refresh. (1pt)
- [x] User can load past tweets infinitely. (2pts)
- [x] An alert and default tweets are displayed when tweets cannot be loaded

## Video Walkthrough

Here's a walkthrough of implemented user stories:
**Displays basic functionality of logging in and out, 
restarting, refreshing, and alerting users without it tweets loaded.<br/>**
<img src='https://i.imgur.com/o9vzOVP.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' /><br/>

**Displays images when they finally do load<br/>**
<img src='https://i.imgur.com/846kxjG.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' /><br/>

## Notes:
Despite running the same code, the **TwitterCallerAPI** only *sometimes* loads tweets.<br/>
Additionally, changes to the starter project included updating the **AppDelegate.swift** keywords :<br/> *UIApplicationOpenURLOptionsKey* and *UIApplicationLaunchOptionsKey.* <br/>
There should be no "." in between both keywords<br/>
