H2_VERSION=1.3.176

PACKAGE_ROOT=..
DATABASE_LIB=h2-$(H2_VERSION).jar
JAVA_INST_PATH=$(PACKAGE_ROOT)/inst/java

.PHONY: all clean

all: h2_jar

h2_jar:
ifeq ($(wildcard $(JAVA_INST_PATH)/$(DATABASE_LIB)),)
	curl -O -L "http://search.maven.org/remotecontent?filepath=com/h2database/h2/$(H2_VERSION)/$(DATABASE_LIB)"
	mkdir -p "$(JAVA_INST_PATH)"
	rm -f "$(JAVA_INST_PATH)/*.jar"
	cp "$(DATABASE_LIB)" "$(JAVA_INST_PATH)/"
endif

clean:
	rm -f *.jar
