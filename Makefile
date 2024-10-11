WEBSITE="http://kaba.ai"
DESCRIPTION="KabaCorp, Inc Browser"
NAME=kaba-ai

build: 
	@yarn export
	@cp -R out/* ../kaba/app/userland/ai/
	# @cp -R sw.js ~/source/kaba-labs/kaba/app/userland/ai/sw.js

out:
	@cp -R out/* ../kaba/app/userland/ai/
	@cp -R sw.js ~/source/kaba-labs/kaba/app/userland/ai/sw.js


docker:
	@cp -R sw.js out/sw.js
	@docker build --build-arg KABA_USER=$(KABA_USER),KABA_PASSWORD=$(KABA_PASSWORD) -t kaba-webllm -f Dockerfile .
	@docker tag kaba-webllm registry.digitalocean.com/kabacorp/kaba-webllm
	@docker push registry.digitalocean.com/kabacorp/kaba-webllm


up:
	kubectl --validate=false create -f kube/kaba-webllm/

down:
	kubectl delete -f kube/kaba-webllm/

# super lazy
push:
	git add . && git commit -a -m 'update' && git pull && git push


build-docker:
	# mkdir -p ~/.kaba-tmp/ && \
		# wget https://github.com/snail007/goproxy/releases/download/v14.1/proxy-linux-amd64.tar.gz && \
		# tar zxf proxy-linux-amd64.tar.gz && docker buildx build --platform linux/amd64 --no-cache -t kaba-proxy -f Dockerfile.proxy .
	# rm -rf ~/.kaba-tmp/
	# docker tag kaba-proxy registry.digitalocean.com/kabacorp/kaba-proxy
	# docker push registry.digitalocean.com/kabacorp/kaba-proxy

clean:
	@rm -rf out/

.PHONY: build
