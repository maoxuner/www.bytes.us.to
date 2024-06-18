.PHONY: clean

all: public

post: poem:=$(shell curl http://v1.jinrishici.com/all.json)
post: content:=$(shell echo '$(poem)' | jq -r .content)
post: origin:=$(shell echo '$(poem)' | jq -r .origin)
post: author:=$(shell echo '$(poem)' | jq -r .author)
post: file:=post/$(shell date +%Y%m%d)-$(origin).md
post:
	@hugo new '$(file)'
	@echo '$(content)' >> 'content/$(file)'
	@echo '-- 《$(origin)》 $(author)' >> 'content/$(file)'
	@git add content
	@git commit -m "feat: $(origin)"

public:
	hugo -e production --cleanDestinationDir --minify

deploy:
	git push

clean:
	@rm -rf public resources .hugo_build.lock
