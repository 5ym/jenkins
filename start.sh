docker build ./ -t jenkins && docker run -d -p 8080:8080 -v ./jenkins:/root/.jenkins jenkins
