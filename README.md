# Run Slides on Local Docker
docker run --name slides -p 8081:8080 -v /Users/cannin/default/workspace/rTutorial:/site -w /site -t cannin/nodejs-http-server

# Remote Docker
docker run --name slides -p 8089:8080 -v /home/ubuntu/random_walks/del:/site -w /site -t cannin/nodejs-http-server

# Generate PDF
./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/overview.html ./presentations/overview.pdf

# Debug Slide
`r if(file.exists("debug.R")) { source("debug.R"); I(grid) }`
