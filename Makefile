OWNER = lnmpy
REPO = realpath
TAG = `git describe --tags`


install:
	@echo

build: clean
	go build -o realpath

tag: build
	git tag ${TAG}
	git push --tags

release: clean
	GOOS=darwin GOARCH=amd64 go build -o realpath && tar -czf realpath_darwin.tar.gz realpath
	GOOS=linux GOARCH=amd64 go build -o realpath && tar -czf realpath_linux.tar.gz realpath
	GOOS=windows GOARCH=amd64 go build -o realpath.exe  && tar -czf realpath_windows.tar.gz realpath.exe
	github-release release -u ${OWNER} -r ${REPO} -t ${TAG} -n ${TAG}
	github-release upload  -u ${OWNER} -r ${REPO} -t ${TAG} -n "realpath_darwin.tar.gz" -f realpath_darwin.tar.gz
	github-release upload  -u ${OWNER} -r ${REPO} -t ${TAG} -n "realpath_linux.tar.gz" -f realpath_linux.tar.gz
	github-release upload  -u ${OWNER} -r ${REPO} -t ${TAG} -n "realpath_windows.tar.gz" -f realpath_windows.tar.gz

clean:
	rm -f realpath*
