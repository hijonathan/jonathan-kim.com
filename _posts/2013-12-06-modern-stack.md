---
layout: post
title: A Modern Front End Stack
categories: []
tags: []
status: draft
type: post
---
![A picture representing A Modern Front End Stack](http://placekitten.com/g/600/400)

Building Appcues has also given me the chance to start with a fresh tech stack. As a frontend guy, I've always dreamed of a single language, [no backend](http://nobackend.org) setup that let me move quickly. Hopefully this will be helpful for other frontend devs looking to build new apps.

### In a Nutshell

Here's what I ended up with:

- **[Brunch](http://brunch.io/)** for the static build process.
- **[Firebase](https://www.firebase.com/)** for the database + API.
- **[Divshot.io](http://www.divshot.io/)** for hosting (previously on [Github Pages](http://pages.github.com/)).
- **[Wercker](http://wercker.com/)** for continuous integration.

### The Goals

Goal #1 was to have no middle layer—not even a node. Middle layers are great for processing data, but they also add extra overhead which requires even more overhead to keep it fast, and so on and so on.

Goal #2 was that I wanted something free or nearly free. For me, this also meant looking for vendors that would let me grow to 100 customers before I needed to pay.

And goal #3 was to have an efficient system. I didn't want to get bogged down by deploy processes or have to remember to do tricky things in order to not break something crucial. I just wanted commit code and let something else take care of it.

Basically I wanted [HubSpot's infrastructure](http://dev.hubspot.com/blog/how-we-deploy-300-times-a-day) for free.

### The Advantages

**Brunch** has a simple config and a bunch of open source plugins, which is usually nice. I can see myself outgrowing it soon, but it's hard to match it in terms of quick development. If you just want to build a simple single-page app for Github Pages, Brunch is a great choice.

**Firebase** is a pretty good BaaS provider. Their API is extremely fast and reliable (so far), and the fact that data is updated in realtime is nice. They also have a decent Backbone integration library that makes good use of their realtime updating. It basically means that everything that you see on the frontend has been (or eventually will be) sync'd to the database.

I got invited to try out **Divshot.io** before the beta, and so far it's been really awesome. They provide some [nice things out of the box](http://docs.divshot.io/) that make it a much better alternative to Github Pages.

- Custom routes are great if you're using pushState.
- Separate development, staging and production enviroments created for you.
- Awesome command line deployer that lets you "promote" environments.
- You can set custom cache headers in your config file!
- Custom domains.

In addition, the Divshot team has been super responsive whenever I've run into issues. They even helped me to get it working with Wercker.

Ah **Wercker**. This is the "advantages" section, so I'm going to hold back on them. They're a CI service and FREE. The builds and deploys are actually really fast (faster than at HubSpot) and they benefit from having a community of people building boxes and steps. Their support team has been pretty good too.

### The Disadvantages

Getting **Wercker** to werck was a pain in the ass. There is no debug mode, so the only way to test changes is to push commits to your repo. Not super fun. Their UI is also way too AJAXy, and laid out in a weird way. I feel like I have to click a bunch just to figure out how my build is doing.

In comparison, **Divshot** has been a walk in the park, and **Firebase** just took some getting used to. Unlike some other BaaS providers, Firebase doesn't have a `WHERE` clause, meaning you have to store the data you want in it's own index if you want to get it quickly.

That last part is especially important if you have no backend. If I want to find all the users named `Joe`, my options are either:

- Be constantly updating a new index called `people_named_joe`.
- Download all users to the client, loop over them and pluck out the `Joe`s.
- Don't offer that feature.

Jury is still out on that one.

### How it Works Together

When I push commits to Github, Wercker gets the webhook and starts building two copies of the project (development and production).

Wercker, to it's credit, does a great job getting dependencies, compiling, minifying and then testing my code. Assuming those steps all pass successfully, Wercker then queues up two Divshot deploys.

Wercker automatically deploys the development and production builds to their respective environments. In the future, I plan to use Divshot's `promote` command better so that builds go from staging to production after a certain amount of time or perhaps some extra tests are run. Not sure yet.

Upon successful deploy, Wercker then tags the git commit with the name of the environment (e.g. "appcues-staging") and pushes those tags to the repo. It's a convenient way for me to keep track of what is currently deployed.

And that's it!

### Save Yourself the Headache

If you're interested in using this stack, I highly recommend using [my Wercker config](https://gist.github.com/hijonathan/7824199). It'll save you a lot of headache trying to figure Wercker out.
