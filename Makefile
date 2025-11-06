.PHONY: run build deploy clean install

run:
	mkdocs serve

build:
	mkdocs build

deploy:
	mkdocs gh-deploy

clean:
	rm -rf site/

install:
	pip install mkdocs-material
