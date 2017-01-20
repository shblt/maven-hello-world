#!/bin/bash -x

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH, TRAVIS_PULL_REQUEST=$TRAVIS_PULL_REQUEST"
echo "TRAVIS_COMMIT=$TRAVIS_COMMIT"
echo "TRAVIS_COMMIT_MSG=$TRAVIS_COMMIT_MSG"

RELEASE_VERSION=$(echo $TRAVIS_COMMIT_MSG | grep -P '^Merge\spull\srequest\s.*\sfrom\s.*\/release-(v[\d.-]+$)' | grep -P -o 'release-(v[\d.-]+$)')
echo $RELEASE_VERSION

# Release merge if commit is a non-PR push into master from a release branch
if [ "$TRAVIS_BRANCH" == "master" ] && [[ $RELEASE_VERSION ]]; then
  echo "merge detected"
  cat pom.xml | grep version

  mvn -B release:clean release:prepare release:perform
  cat pom.xml | grep version

elif [ "$TRAVIS_PULL_REQUEST" != "false" ]; then 
  echo "pull request"
  
else
#if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then 
  echo "regular build"
  
fi
