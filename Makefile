.PHONY: dev
dev:
	@skaffold dev

.PHONY: publish
publish:
	@cd comments && docker build -t christiangama/comments:latest . && \
	cd ../eventbus && docker build -t christiangama/eventbus:latest . && \
	cd ../moderation && docker build -t christiangama/moderation:latest . && \
	cd ../posts && docker build -t christiangama/posts:latest . && \
	cd ../query && docker build -t christiangama/query:latest . && \
	cd ../client && docker build -t christiangama/client:latest . && \
	docker push christiangama/comments:latest && \
	docker push christiangama/eventbus:latest && \
	docker push christiangama/moderation:latest && \
	docker push christiangama/posts:latest && \
	docker push christiangama/query:latest && \
	docker push christiangama/client:latest && \
	cd .. && \
	kubectl apply -f infra/k8s && \
	kubectl rollout restart deployment eventbus-depl comments-depl query-depl posts-depl moderation-depl client-depl

