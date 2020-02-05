# Less terse aliases using automatic variables:
# https://ftp.gnu.org/old-gnu/Manuals/make-3.79.1/html_chapter/make_10.html#SEC101
TARGET = $@
FIRST_DEPENDENCY = $<

.PHONY: build clean

build:
	docker build --rm -t resume-generator .

push: build
	docker tag resume-generator celfring/resume-generator
	docker push celfring/resume-generator

output/resume.html: resume.yaml
	docker run --rm -it -v `pwd`:/go/src/github.com/caitlin615/resume-generator resume-generator -resume=$(FIRST_DEPENDENCY)

clean:
	rm -rf output/resume*
