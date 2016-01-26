## Run Slides on Local Docker
docker run --name slides -p 8081:8080 -v rTutorial:/site -w /site -t cannin/nodejs-http-server

## Remote Docker
docker run --name slides -p 8089:8080 -v del:/site -w /site -t cannin/nodejs-http-server

## Generate PDF Using decktape
[Download Decktape](https://github.com/astefanutti/decktape)

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/overview.html ./presentations/overview.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/statisticalMethods.html ./presentations/statisticalMethods.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/cbioportal.html ./presentations/cbioportal.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/cellminer.html ./presentations/cellminer.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/pathwayCommons.html ./presentations/pathwayCommons.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/shiny.html ./presentations/shiny.pdf

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/usingR.html ./presentations/usingR.pdf

## Debug Slide
`r if(file.exists("debug.R")) { source("debug.R"); I(grid) }`

## Add content to <HEAD>
`r if(file.exists("head.R")) { source("head.R"); I(head) }`

## Add Google Analytics Events
Reveal.addEventListener('slidechanged', function(event) {
  // event.previousSlide, event.currentSlide, event.indexh, event.indexv
  ga('send', 'event', 'Slide', 'click', event.currentSlide);
});

## Included Presentations
* usingR 
* cellminer
* cbioportal
* installR
* shiny
* pathwayCommons
* statisticalMethods
