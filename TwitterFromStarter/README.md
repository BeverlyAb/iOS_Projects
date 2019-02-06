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
Displays basic functionality of logging in and out, 
restarting, refreshing, and alerting users without it tweets loaded.
<img src='https://i.imgur.com/o9vzOVP.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Displays images when they finally do load
<img src='https://i.imgur.com/846kxjG.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

Notes:
Despite running the same code, the TwitterCallerAPI only sometimes loads tweets. Additionally, changes to 
the starter project included updating the "AppDelegate" keywords : UIApplicationOpenURLOptionsKey and UIApplicationLaunchOptionsKey. No "." in between both keywords
