---
layout: post
title: The Problem with Upgrading Touch Events
categories: []
tags: []
status: draft
type: post
---
If you take away one thing from this article, it's that the solution is not to use `event.preventDefault()`. By preventing an event's default behavior, you're basically shutting down every other bound event listener. This works great in example code, but it's terrible when you have multiple listeners on an element and want them all to fire.

### Some Backstory

Not caught up on why we're upgrading touch events? The short story is that `click` handlers fired from a touch event have some perceptible lag (~300ms). That lag is there so the device can discern between a click and other gestures.

To get around that lag, most developers (myself included) optimized their events for mobile. It looked something like this:

```javascript
var supportsTouch = 'ontouchend' in document;
eventName = supportsTouch ? 'touchstart' : 'click';

$('.my-target').on(eventName, callback);
```

There's been a bunch of [stuff written](http://www.html5rocks.com/en/mobile/touchandmouse/) about why this technique is bad, and it's namely because it's difficult to know when someone is on a touchscreen device that's using a mouse input. However, I'm hear to argue that the current recommendation---`event.preventDefault()`---isn't much better and that both should be avoided.

### An Illustrated Example

```javascript
callback = function(evt) {
  console.log(evt.type);
  evt.preventDefault();
}

// This is for the same behavior.
$('body').on('touchstart', callback);
$('body').on('click', callback);


completelyUnrelatedBoundEvent = function(evt) {
  console.log("I'm just a normal event trying to bubble a living.");
}

// As the name lets on, this is unrelated to the above events.
$('body').on('click', completelyUnrelatedBoundEvent);
```

In the above example, clicking anywhere on the page would only log the touchevent, since it gets fired first in the event chain. It keeps the event for itself, which is pretty uncool.
