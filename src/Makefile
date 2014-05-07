H2_VERSION=1.3.176

.PHONY: all clean

all: download_h2_jar copy_to_inst

download_h2_jar:
ifeq ($(wildcard h2-$(H2_VERSION).jar),)
	curl -O http://search.maven.org/remotecontent?filepath=com/h2database/h2/$(H2_VERSION)/h2-$(H2_VERSION).jar
endif

copy_to_inst:
	mkdir -p ../inst/java/
	cp *.jar ../inst/java/

clean:
	rm -f *.jar
	rm -rf ../inst/java/
