---
layout: post
title: Find Emails With No Reply
categories: []
tags: []
status: draft
type: post
---
![Gmail No Response in Priority Inbox]({{ site.baseurl }}/assets/images/gmail.png)

Ever send out an email but got no response? Some people (myself included) aren't great at email, and they just need a small nudge or reminder. I use tools like [Signals](http://getsignals.com) to get notified when someone opens an email and [FollowUp](http://www.followup.cc/) to send myself reminders to follow up, but I wanted something more automated.

### What Does It Do?

This script creates and manages two new labels: "No Response" for emails that have garnered no reply, and "Ignore No Response" for emails you don't need to respond to.

The script periodically goes through your email and finds **messages between 5 and 14 days old where you were the last person to respond**. Basically, the goal is to find messages where a follow-up email would be appropriate.

### How to Install

Visit the [Google Scripts](http://script.google.com) site and create your first script. Scripts are stored in Google Drive, so you can edit them there later on.

Then, get the [Gmail - No Response script](https://github.com/hijonathan/google-scripts/blob/master/gmail-no-response.js) and paste it into your new script document. At this point, you can also modify the variables at the top of the script. These will change the label names and age thresholds.

Next, click the clock icon to create a trigger that will run this script on a schedule. I set mine up to run daily at midnight:

![The triggers UI is pretty underwhelming]({{ site.baseurl }}/assets/images/schedule-triggers.png)

Make sure to **save your work!**

You'll now have two new labels in your inbox that you can check and do stuff with. If you want to keep those top-of-mind, you can add the "No Response" label to your main inbox. Just go to **Settings** > **Inbox** > **Inbox Sections**, and add the "No Response" label:

![Add the No Response label to your inbox]({{ site.baseurl }}/assets/images/inbox-config.png)

Now sit back and enjoy!

### Why Not Use FollowUp or Boomerang?

As Chris Keller later pointed out to me, FollowUp has a Chrome extension that will auto-populate the BCC field for you, and I assume Boomerang has something similar. I wrote this script before I knew that, and I think it's a better choice for me because:

1. It works on emails you've already sent.
2. It involves no third-party services. Your email stays put.
3. Each user has code-level control, in case they want to go nuts.

Some emails I send are sensitive, and I'd rather not forward it to a third-party service if I don't have to. However, those sensitive emails are often important, so I need a way to remember to follow up.

### To Be Continued

I love finding ways to be more productive, and I've been making an effort to share more of that knowledge. If you like this project and want to keep tabs, you can subscribe to [the Github repo](https://github.com/hijonathan/google-scripts). I might add more scripts there in the future.
