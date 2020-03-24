FROM debian:9-slim

# Copied from somewhere on the internet
ENV HUGO_VERSION='0.55.6'
ENV HUGO_NAME="hugo_extended_${HUGO_VERSION}_Linux-64bit"
ENV HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_NAME}.deb"
ENV BUILD_DEPS="wget"

RUN apt-get update && \
    apt-get install -y git nginx "${BUILD_DEPS}" && \
    wget "${HUGO_URL}" && \
    apt-get install "./${HUGO_NAME}.deb" && \
    rm -rf "./${HUGO_NAME}.deb" "${HUGO_NAME}" && \
    apt-get remove -y "${BUILD_DEPS}" && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# Copy files and compile assets
WORKDIR /app
COPY . .

RUN /usr/local/bin/hugo -D 

RUN mv public/* /var/www/html

# expose nginx

EXPOSE 80
CMD ["nginx","-g","daemon off;"]
