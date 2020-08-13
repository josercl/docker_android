FROM openjdk:8-jdk

ENV ANDROID_COMPILE_SDK 29
ENV ANDROID_BUILD_TOOLS 29.0.3
ENV ANDROID_SDK_TOOLS 6609375

SHELL ["/bin/bash", "-c"]

WORKDIR /root

RUN apt-get update --yes && apt-get install --yes wget tar unzip lib32stdc++6 lib32z1

RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip
RUN unzip -d android-sdk-linux android-sdk.zip
RUN echo y | android-sdk-linux/tools/bin/sdkmanager --sdk_root=$PWD/android-sdk-linux "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager --sdk_root=$PWD/android-sdk-linux "platform-tools" >/dev/null
RUN echo y | android-sdk-linux/tools/bin/sdkmanager --sdk_root=$PWD/android-sdk-linux "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

RUN export ANDROID_HOME=$PWD/android-sdk-linux
RUN set +o pipefail
RUN yes | android-sdk-linux/tools/bin/sdkmanager --licenses --sdk_root=$ANDROID_HOME
RUN set -o pipefail