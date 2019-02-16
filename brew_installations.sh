#!/usr/bin/env bash

# brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
mkdir -p /usr/local/sbin
brew tap caskroom/versions
# repair dir ownership to not needing sudo for brew stuff
sudo chown -R $(whoami) /usr/local

# brew fundamentals
brew install git bash-completion

# add bash completion and add brew to path
PATHEXP='$PATH'
echo "
# add bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# set gui gui in english
export LANG=en_US

# put brew stuff on path
export PATH=/usr/local/bin:/usr/local/sbin:$PATHEXP
" >> ~/.bash_profile
source ~/.bash_profile


# java 8 and 11
brew cask install java
brew cask install homebrew/cask-versions/java8

# set java 8 to be JAVA_HOME and on path
JAVA_HOME_EXP='$JAVA_HOME'
JAVAHOMEDETERMINER='`/usr/libexec/java_home -v 1.8`'
echo "
# Java
export JAVA_HOME=$JAVAHOMEDETERMINER
export PATH=$JAVA_HOME_EXP/bin:$PATHEXP
" >> ~/.bash_profile
source ~/.bash_profile

# build / dependency tools
brew install ant maven gradle
# set env vars for build tools
echo "
# Build / dependency tools env vars
export ANT_HOME=/usr/local/opt/ant
export MAVEN_HOME=/usr/local/opt/maven
export GRADLE_HOME=/usr/local/opt/gradle
" >> ~/.bash_profile
source ~/.bash_profile


# Android SDK and NDK
brew cask install android-sdk
brew cask install android-ndk

ANDSDKROOTEXP='$ANDROID_SDK_ROOT'
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
echo "
# Android env vars and add tools to Path
export ANDROID_NDK_HOME=/usr/local/share/android-ndk
export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
export PATH=$ANDSDKROOTEXP/tools:$PATHEXP
export PATH=$ANDSDKROOTEXP/platform-tools:$PATHEXP
export PATH=$ANDSDKROOTEXP/build-tools/19.1.0:$PATHEXP
export PATH=$ANDSDKROOTEXP/build-tools/$(ls $ANDROID_SDK_ROOT/build-tools | sort | tail -1):$PATHEXP
" >> ~/.bash_profile
source ~/.bash_profile

# install Android sdk components
mkdir -p ~/.android/
touch ~/.android/repositories.cfg
sdkmanager --update

# ide
#brew cask install android-studio
echo "Use /usr/local/share/android-sdk as Android SDK Directory during App setup"
