#!/bin/bash -x

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH, TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"
echo "TRAVIS_COMMIT=$TRAVIS_COMMIT"
echo "TRAVIS_COMMIT_MSG=$TRAVIS_COMMIT_MSG"

# ^Merge pull request .* from .*\/release-(v[\d.-]+$)

if [ "$TRAVIS_PULL_REQUEST" != "false" ] && [ "$TRAVIS_BRANCH" != "master" ] && [[ "TRAVIS_PULL_REQUEST_BRANCH" =~ release-v[\d.-]+$ ]]; then
  echo "merge detected"
  mvn -B release:prepare && mvn release:perform
fi

if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then 
  echo "pull request"
  
fi

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then 
  echo "regular build"
  mvn test
fi
