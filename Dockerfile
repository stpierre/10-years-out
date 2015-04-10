FROM fedora:21

# much of this Dockerfile stolen from James Turnbull:
# http://kartar.net/2014/05/presenting-with-docker/

# install npm and git. other packages are required by some node.js deps
RUN yum -y install npm git bzip2 spawn tar

# install reveal.js and the presentation
WORKDIR /opt
RUN git clone https://github.com/hakimel/reveal.js.git

WORKDIR /opt/reveal.js
RUN npm install -g grunt-cli
RUN npm install
RUN sed -i "s/port: port/port: port,\n\t\t\t\t\thostname: \'\'/g" Gruntfile.js

ADD index.html /opt/reveal.js/index.html
ADD images /opt/reveal.js/images

EXPOSE 8000

CMD ["grunt", "-d", "serve"]
