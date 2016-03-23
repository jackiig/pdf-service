FROM ruby:2.1-onbuild

env PATH_TO_PDFTK /usr/bin/pdftk
env PORT 80

RUN apt-get -qq update && \
  apt-get -qqy install \
    pdftk \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR "/usr/src/app"

CMD ["/usr/local/bin/ruby", "app.rb"]
