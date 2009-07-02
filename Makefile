# Makefile for ubiquity-slideshow-ubuntu

SOURCE=.
SOURCESLIDES=$(SOURCE)/slides
BUILD=build

all:
	mkdir -p $(BUILD);
	cp -r $(SOURCESLIDES) $(BUILD)/slides;
	
	for slide in po/*; \
	do \
		slidename=`basename $$slide`; \
		for locale in $$slide/*.po; \
		do \
			if [ -e $$locale ]; \
			then \
				buildslides=$(BUILD)/slides.`basename $$locale .po`; \
				[ ! -e $$buildslides ] && mkdir -p $$buildslides; \
				[ -e $$buildslides/$$slidename ] && rm -f $$buildslides/$$slidename; \
				po2html -i $$locale -t $(SOURCESLIDES)/$$slidename -o $$buildslides/$$slidename; \
			fi; \
		done; \
	done;

.PHONY : clean
clean:
	-rm -rf $(BUILD)
