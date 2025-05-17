## User System Operations

### Commands (Create, Update, Delete)

1. **RegisterUser**
    
    - Given an email, username, and password
    - When a visitor registers for an account
    - Then a user account is created in the ACTIVE state
    - And the user is associated with the AUTHENTICATED role
    - And a confirmation email is sent to the user
2. **AuthenticateUser**
    
    - Given a username/email and password
    - When a user attempts to log in
    - Then the user's credentials are validated
    - And an authentication token is created
    - And the user session is established
3. **UpdateUserProfile**
    
    - Given a user ID and profile information
    - When a user edits their profile
    - Then the user profile is updated with new information
4. **DeactivateAccount**
    
    - Given a user ID
    - When a user requests account deactivation
    - Then the user account is marked as INACTIVE
5. **SubscribeToChannel**
    
    - Given a user ID and a channel ID
    - When a user subscribes to a channel
    - Then a subscription is created
    - And the subscription is associated with the user
    - And the subscription is associated with the channel
    - And the channel's subscriber count is incremented

### Queries (Read)

1. **GetUserProfile**
    
    - Given a user ID
    - When a profile page is requested
    - Then the user's profile information is retrieved
2. **GetUserSubscriptions**
    
    - Given a user ID
    - When a user's subscriptions are requested
    - Then all channels the user is subscribed to are retrieved
3. **GetUserNewsFeed**
    
    - Given a user ID
    - When a user's news feed is requested
    - Then content from subscribed channels is retrieved
    - And content is sorted by publication date

## Channel System Operations

### Commands (Create, Update, Delete)

1. **CreateChannel**
    
    - Given a user ID, channel name, and description
    - When a user creates a channel
    - Then a channel is created
    - And the channel is associated with the user as owner
    - And the channel is set to INACTIVE state
2. **UpdateChannelInfo**
    
    - Given a channel ID and channel information
    - When a channel owner edits channel details
    - Then the channel information is updated
3. **DeleteChannel**
    
    - Given a channel ID
    - When a channel owner deletes their channel
    - Then the channel is marked as DELETED
    - And all associated content is archived

### Queries (Read)

1. **GetChannelDetails**
    
    - Given a channel ID
    - When a channel page is requested
    - Then the channel details are retrieved
2. **GetChannelVideos**
    
    - Given a channel ID
    - When a channel's videos are requested
    - Then all videos associated with the channel are retrieved
3. **GetChannelArticles**
    
    - Given a channel ID
    - When a channel's articles are requested
    - Then all articles associated with the channel are retrieved
4. **GetChannelSubscribers**
    
    - Given a channel ID
    - When a channel's subscriber list is requested
    - Then all users subscribed to the channel are retrieved

## Video System Operations

### Commands (Create, Update, Delete)

1. **StartLiveStream**
    
    - Given a channel ID, title, and description
    - When a streamer starts a live stream
    - Then a video is created with type LIVE
    - And the channel's isLive status is set to TRUE
    - And notifications are sent to channel subscribers
2. **EndLiveStream**
    
    - Given a video ID
    - When a streamer ends a live stream
    - Then the video type is changed to VOD
    - And the channel's isLive status is set to FALSE
    - And the video duration is calculated
3. **UploadVideo**
    
    - Given a channel ID, video file, title, and description
    - When a user uploads a video
    - Then a video is created with type VOD
    - And the video is associated with the channel
    - And the video is processed for different quality levels
4. **DeleteVideo**
    
    - Given a video ID
    - When a video owner deletes a video
    - Then the video is marked as DELETED
    - And associated comments are archived
5. **AddCommentToVideo**
    
    - Given a user ID, video ID, and comment text
    - When a user comments on a video
    - Then a comment is created
    - And the comment is associated with the user
    - And the comment is associated with the video
6. **AddChatMessageToLiveStream**
    
    - Given a user ID, video ID, and message text
    - When a user sends a chat message during a live stream
    - Then a chat message is created
    - And the chat message is associated with the user
    - And the chat message is associated with the video
    - And the chat message is broadcast to all viewers

### Queries (Read)

1. **GetVideoDetails**
    
    - Given a video ID
    - When video details are requested
    - Then video information is retrieved
2. **GetVideoComments**
    
    - Given a video ID
    - When video comments are requested
    - Then all comments associated with the video are retrieved
3. **GetLiveStreamChat**
    
    - Given a video ID with type LIVE
    - When chat messages are requested
    - Then all chat messages associated with the live stream are retrieved
4. **SearchVideos**
    
    - Given search criteria (keywords, filters)
    - When a video search is performed
    - Then videos matching the criteria are retrieved

## Article System Operations

### Commands (Create, Update, Delete)

1. **CreateArticle**
    
    - Given a user ID, channel ID, title, content, and category
    - When a user creates an article
    - Then an article is created
    - And the article is associated with the user
    - And the article is associated with the channel
2. **UpdateArticle**
    
    - Given an article ID and new content
    - When an article author edits the article
    - Then the article content is updated
3. **DeleteArticle**
    
    - Given an article ID
    - When an article author deletes an article
    - Then the article is marked as DELETED

### Queries (Read)

1. **GetArticleDetails**
    
    - Given an article ID
    - When article details are requested
    - Then article information is retrieved
2. **SearchArticles**
    
    - Given search criteria (keywords, category, filters)
    - When an article search is performed
    - Then articles matching the criteria are retrieved

## Tournament System Operations

### Commands (Create, Update, Delete)

1. **CreateTournament**
    
    - Given tournament details (name, description, dates, game, etc.)
    - When an admin creates a tournament
    - Then a tournament is created
    - And the tournament is associated with the admin
    - And the tournament status is set to UPCOMING
2. **RegisterForTournament**
    
    - Given a user ID and tournament ID
    - When a user registers for a tournament
    - Then the user is added to the tournament participant list
3. **UpdateTournamentStatus**
    
    - Given a tournament ID and status
    - When an admin updates tournament status
    - Then the tournament status is updated

### Queries (Read)

1. **GetTournamentDetails**
    
    - Given a tournament ID
    - When tournament details are requested
    - Then tournament information is retrieved
2. **GetTournamentParticipants**
    
    - Given a tournament ID
    - When tournament participants are requested
    - Then all users registered for the tournament are retrieved
3. **SearchTournaments**
    
    - Given search criteria (game, date, status)
    - When a tournament search is performed
    - Then tournaments matching the criteria are retrieved

## Admin System Operations

### Commands (Create, Update, Delete)

1. **ChangeUserRole**
    
    - Given a user ID and role
    - When an admin changes a user's role
    - Then the user's role is updated
2. **DisableUserAccount**
    
    - Given a user ID
    - When an admin disables a user account
    - Then the user account is marked as DISABLED

### Queries (Read)

1. **GetDashboardStatistics**
    
    - Given date range parameters
    - When dashboard statistics are requested
    - Then platform statistics are retrieved and calculated
2. **GetUserList**
    
    - Given filter parameters
    - When a user list is requested
    - Then users matching the filters are retrieved
3. **GetChannelStatistics**
    
    - Given a channel ID
    - When channel statistics are requested
    - Then the channel's performance metrics are retrieved and calculated

## Bonus System Operations

### Commands (Create, Update, Delete)

1. **SendNotification**
    
    - Given a notification type, content, and recipient IDs
    - When a notification-triggering event occurs
    - Then notifications are created for all recipients
2. **MakeDonation**
    
    - Given a donor ID, recipient ID, amount, and message
    - When a user makes a donation
    - Then a donation record is created
    - And payment is processed
    - And the donation is associated with the donor and recipient

### Queries (Read)

1. **GetUserNotifications**
    
    - Given a user ID
    - When notifications are requested
    - Then all notifications for the user are retrieved
2. **GetChannelDonations**
    
    - Given a channel ID
    - When donation history is requested
    - Then all donations to the channel are retrieved