# run-ssm.sh

## Important
`run-ssm -l` - to login
`run-ssm` - To skip login when login token is still valid

## On with the regular show
This script will help make it easier to log into a container running on Amazon's Fargate service. This script does the following:
1. Logs your google user into AWS
1. Logs your google user into AWS ECR (the container registry)
1. Downloads the dev-tools:latest image
1. Logs you into the dev-tools container

### Prerequisites
- *aws-google-auth*: A python library that can be [installed](https://github.com/cevoaustralia/aws-google-auth) with pip
- *docker*: You know what this is
- *jq*: For command output parsing in bash scripts

### Logging into AWS using the cli:
This is documented [here](https://www.notion.so/companycam/AWS-Access-cf4b6caff01d421eb5a742d5cdbb5798#e6213cec1dd24d08a83068b814586971). This script assumes your configured github email address is the same as your CompanyCam email address. Logging in via the command line requires the user to answer a Captcha challenge and a 2fa code is sent to your phone. The session is good for 12 hours.

```
# Login to AWS as admin before downloading container
/bin/bash run-ssm.sh -l -r admin

# Run the script without logging in
/bin/bash run-ssm.sh

```

### How it works
The script downloads a docker container that has a python app installed which uses systems manager to log into the Fargate service. Once the app downloads the dev-tools image it will run the image and mount your ~/.gitconfig file and ~/.aws directory as volumes.


### Accessing the containers
Once in the dev-tools container you can easily access your cluster and then select which container in the cluster to log into.

```
# Run the ssm script, passing -c <cluster_name>. In qa it's always qa-<pr_number>-v2
root@90f7af3104dc:/dev-tools# poetry run ssm -c qa-4077-v2

# Pick a number

Pick a container to access:
1: service:qa-4077-v2-sidekiq-webhooks-queue
2: service:qa-4077-v2-sidekiq-default_slow-queue
3: service:qa-4077-v2-sidekiq-low_priority-queue
4: service:qa-4077-v2-sidekiq-critical-queue
5: service:qa-4077-v2-sidekiq-downloads-queue
6: service:qa-4077-v2-nginx
7: service:qa-4077-v2-webapp
8: service:qa-4077-v2-sidekiq-backfill-queue
9: service:qa-4077-v2-sidekiq-default-queue
10: service:qa-4077-v2-sidekiq-temp_backfill-queue
11: service:qa-4077-v2-sidekiq-events-queue
12: service:qa-4077-v2-sidekiq-subscriptions-queue
7  # <-- Picked the webapp container

# Once you choose a number, AWS' systems manager service will drop you into the container
# in the root of Company-Cam-API directory
The Session Manager plugin was installed successfully. Use the AWS CLI to start a session.


Starting session with SessionId: ecs-execute-command-0f25a6548a67887c8
root@ip-172-17-38-98:/Company-Cam-API#
```

Exiting the container (with the exit command) will put you back into the host container. Exiting again puts you back on the host system.
