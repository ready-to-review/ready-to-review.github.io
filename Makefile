.PHONY: run build deploy deploy-cloudflare clean install

run:
	@command -v mkdocs >/dev/null 2>&1 || { echo "mkdocs not found. Run 'make install' first."; exit 1; }
	mkdocs serve

build:
	mkdocs build

deploy:
	mkdocs gh-deploy

deploy-cloudflare:
	mkdocs build && npx wrangler deploy

clean:
	rm -rf site/

install:
	pip install mkdocs-material
