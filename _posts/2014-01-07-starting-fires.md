---
layout: post
title: Starting Fires
categories: []
tags: []
type: post
---
![This is how it feels to work on a startup sometimes.]({{ site.baseurl }}/assets/images/flames.jpg)

If there's one thing I've learned this past week, it's that when starting a fire, don't question the sparks. **Just fan the flame.**

I was *really* hoping to get some coding done last Thursday. Instead, I spent that and the following five days scrambling to put together a marketing campaign for an unexpected surge in new leads. The kicker? **We couldn't accept any new customers.**

Basically, we had a great opportunity at the worst possible time. Here's the story of how we made the best of it.

This new traffic surge came from [Product Hunt](http://www.producthunt.co/posts/518), a sort of Hacker News for products. Members submit products they think are cool, and the community votes on them, floating the best to the top. Ours was casually submitted by [Ryan Dawidjan](https://twitter.com/ryandawidjan), a [true #hustler]({% post_url 2013-10-07-week-two %}) with a keen product sense. Ryan actually helped me do customer development for Appcues in the way way early stages, which made him among some two dozen people who actually knew about Appcues at all.

The company was starting private beta, so we weren't planning to handle any more customers for another month or so. But here was this nice little spark that had the potential to become something.

At [Nathan Bashaw's recommendation](https://twitter.com/nbashaw/status/418784840733827072), I did an AMA in the PH comments. We sent out a couple of tweets and a bunch of my old coworkers (organically, I swear) found the post and shared some karma.

By the end of the day, we had over 75 high quality leads, and more were expected when Product Hunt's morning digest went out. The total was 134 qualified leads in 3 days. Appcues is built for product people (product marketers and managers), so the PH leads were HOT.

![We hit our visits and leads goals for the month a bit early.]({{ site.baseurl }}/assets/images/ph-traffic.png)

That might not seem like a lot, but for our size, it's a mountain. We were in a position I think many business owners fear: a surplus of customers, a shortage of inventory, and only ourselves to blame. We decided to keep fanning the fire.

We quickly published a landing page and email campaign to learn a few more things from these Product Hunters while we were still relevant to them:

1. Was the pain that they felt around onboarding bad enough that they'd commit money without even seeing a screenshot?
2. Could we actually communicate that we're building a product to solve that pain?

As it turns out, they did need a solution, and we were *mostly* able to communicate the value of ours. Getting featured on Product Hunt has been an amazing (albeit nerve-wracking) experience for us, and we hope to give back to that community over time.

By all accounts, I'm a "planner," and Appcues already had a marketing strategy. We could have decided the timing wasn't right and ignored the surge, but I'm really glad we didn't. I'm learning that **timing will almost never be perfect,** and a startup simply needs to make the best of every good opportunity.

Huge thanks to [Ryan Hooover](http://twitter.com/rrhoover) & [Nathan Bashaw](https://twitter.com/nbashaw) for creating PH and helping fan the flames. And a special thanks to [Hiten Shah](http://twitter.com/hnshah) and [Anand Rajaram](http://twitter.com/anandrajaram) for their sage advice and honest feedback when I was freaking out over what to do.


### About the Landing Page

[![I used Stripe's API to get the most up-to-date customer list, then fetched the avatars from Gravatar.]({{ site.baseurl }}/assets/images/ph-lp.png)](https://appcues-payments.herokuapp.com)

The landing page was hosted on Heroku so we could accept credit cards via Stripe, which requires SSL. The landing page forumla we used was:

1. The offer and why this page exists.
2. Lots of social proof and smiling faces.
3. FAQs (to put people's mind at ease).
4. Alternatives (email notification or a survey).

If you're interested in using it, let me know in the comments and I'll open source the code.
