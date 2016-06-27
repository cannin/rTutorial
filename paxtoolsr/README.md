docker run --name slides -p 8081:8080 -v /Users/cannin/default/workspace/rTutorial:/site -w /site -t cannin/nodejs-http-server:0.10.25

docker exec -it slides bash

./decktape/bin/phantomjs ./decktape/decktape.js reveal http://localhost:8081/paxtoolsr/paxtoolsr.html ./paxtoolsr/paxtoolsr.pdf

http://localhost:8081/paxtoolsr/paxtoolsr.html
