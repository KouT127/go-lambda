first-deploy: build-linux
	aws lambda create-function --function-name sample --runtime go1.x \
	  --zip-file fileb://lambda.zip --handler main \
	  --role arn:aws:iam::YOUR_ROLE:role/service-role/YOUR_ROLE
	rm -rf ./build ./lambda.zip

deploy:	build-linux
	aws lambda update-function-code --function-name sample --publish \
		--zip-file fileb://lambda.zip
	rm -rf ./build

build-linux:
	GOOS=linux GOARCH=amd64 go build -o ./build/main main.go
	cd ./build && zip ../lambda.zip ./main