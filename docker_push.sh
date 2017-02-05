#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" == "false" -a -n "$TRAVIS_TAG" ]
then
    docker login -e $DOCKER_EMAIL -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
    export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
    echo "TAG is $TAG"
    docker tag $TRAVIS_REPO_SLUG:$TRAVIS_COMMIT $REPO:$TAG
    docker push $TRAVIS_REPO_SLUG:$TAG
else
    echo 'Ignoring PR branch for docker push.'
fi
