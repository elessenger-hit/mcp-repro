build:
	docker build . -t mcp-repro:latest --sbom=true --provenance=true

build-clean:
	docker build . -t mcp-repro:latest --sbom=true --provenance=true --no-cache

run: build
	docker run -p 8000:8000 mcp-repro:latest