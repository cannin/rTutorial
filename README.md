# Run Slides on Server
docker run --name site -p 8081:8080 -v ~/default/workspace/rTutorial/:/tmp -w /tmp -t cannin/nodejs-http-server

# Generate PDF
./decktape/bin/phantomjs ./decktape/decktape.js reveal http://192.168.99.100:8081/presentations/overview.html ./presentations/overview.pdf
