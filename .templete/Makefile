SOURCES = $(wildcard *.md)
OBJS := $(patsubst %.md,%.html, $(SOURCES))

all: $(OBJS)

%.html: %.md
	landslide -t theme -x markdown.extensions.tables -l no -i $< -d $@

clean:
	rm -f $(OBJS)
