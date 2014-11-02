---
layout: post
title: How to Design an Embed Script
categories: []
tags: []
status: draft
type: post
---
For the past year, I've been researching third-party client libraries. Like Google Analytics or Optimizely, Appcues gives its customers a snippet of Javascript for them to embed on their site. I've studied dozens of embed scripts and have learned a ton through our own customer implementation.

If you're building a third-party client library, this article is for you.

### Considerations

There are a handful of things you'll need to decide before you dive in:

- Synchronous or Asynchronous?
- Do you offer an API?
- Are you rendering content (js, css, html)?
- How frequently will your script or API change?

These decisions may seem easy to make, but they're far more complicated to execute properly.

### They myth of synchronous javascript

The choice between sync vs async has actually been made for you. The short answer: *always assume you'll be loaded asynchronously.*

Until just a few years ago, blocking js patterns were the norm. Some scripts started loading themselves asynchronously (think Mixpanel or KISSmetrics), but in either case, those script tags were added to the HTML just as the Mixpanel or KISSmetrics provided them.

With new loading conventions like AMD and CommonJS, embed scripts have little say over how they're loaded. Because of that, you should always assume your script will be loaded asynchronously, so it should be designed accordingly.

### How to expose an API

If you believe in the above, there's only one right way to expose your API, and that's as a queue. There are a couple of patterns you can use to do that:

#### 1. Expose an Array

This is how Google used to do it, and how most libraries still do it. Basically, you expose an array and fill it with calls, like this:

```js
window._gaq = window._gaq || [];
_gaq.push(['track', 'pageview', {some: 'data'}]);
```

The advantage of this method is that it's very easy to design and exposes a consistent API. The main disadvantage is that the consumer has no idea what API methods are available.

#### 3. Expose a Function

Another option is to expose a function which puts stuff in the correct queues for you. This is how Google now does it with their Universal Analytics script.

```js
window['GoogleAnalyticsObject'] = 'ga';
window['ga'] = window['ga'] || function() {
    (window['ga'].q = window['ga'].q || []).push(arguments);
};
window['ga'].l = 1 * new Date();

var scriptEl = document.createElement('script'),
    firstScript = document.getElementsByTagName('script')[0];

scriptEl.async = 1;
scriptEl.src = '//www.google-analytics.com/analytics.js';
firstScript.parentNode.insertBefore(scriptEl, firstScript);
```

It's almost identical to the array method, but calling methods now feel more natural and less error prone. When the real js script finally does load, you also have just one stub function to override.

#### 3. Expose Stubs

Mixpanel and Segment.io use this method. This technique initializes an array with stub methods, each with their own queue.

```js
window.analytics = window.analytics || [];

// A list of the methods in Analytics.js to stub.
window.analytics.methods = ['identify', 'group', 'track',
  'page', 'pageview', 'alias', 'ready', 'on', 'once', 'off',
  'trackLink', 'trackForm', 'trackClick', 'trackSubmit'];

// Define a factory to create stubs. These are placeholders
// for methods in Analytics.js so that you never have to wait
// for it to load to actually record data. The `method` is
// stored as the first argument, so we can replay the data.
window.analytics.factory = function(method){
  return function(){
    var args = Array.prototype.slice.call(arguments);
    args.unshift(method);
    window.analytics.push(args);
    return window.analytics;
  };
};

// For each of our methods, generate a queueing stub.
for (var i = 0; i < window.analytics.methods.length; i++) {
  var key = window.analytics.methods[i];
  window.analytics[key] = window.analytics.factory(key);
}
// ...
```

Unlike the basic array method, this technique lets the consumer see what methods are available, but with one major tradeoff: your API can't be updated without asking consumers to update their embed scripts.

