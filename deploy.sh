#!/bin/bash -x

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH"

echo $TRAVIS_PULL_REQUEST_BRANCH

if [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ "$TRAVIS_BRANCH" != "master" ] && [ "TRAVIS_PULL_REQUEST_BRANCH" =~ release-v[\d.-]+$ ]; then
  echo "merge detected"
  mvn -B release:prepare && mvn release:perform
end

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then 
  echo "pull request"
  
fi

if [ "$TRAVIS_PULL_REQUEST" = "false" ]; then 
  echo "regular build"
  mvn test -B
fi
