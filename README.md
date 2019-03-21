# Explanation

In the current app, we have integrated a WebView with a static HTML file loading a GoogleMap inside of it. We wanted to create a new circle on each click on the map so there is an event listener on the HTML side for handling the click events.

On the Dart side we have a Stack and two Positioned elements from which the second one is overlaping the WebView. We attached an onPressed handler which triggers a javascript eval on the WebView, but sometimes the click event is propagated to the map below and even though it works and the js is evals, a circle is created, too. 

**In order the example to work please add you own Google Maps Javascript API KEY in assets/index.html**

