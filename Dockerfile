FROM alpine

RUN apk add --no-cache jenkins
EXPOSE 8080
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"

CMD java -jar ./usr/share/webapps/jenkins/jenkins.war