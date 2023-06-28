FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG GITHUB_USERNAME
ARG GITHUB_BRANCHNAME

WORKDIR /project

RUN git clone https://github.com/ppy/osu-tools
RUN git clone https://github.com/ppy/osu

WORKDIR /project/osu
# Only switch branch if it's not already the default.
RUN if [ "$GITHUB_USERNAME" != ppy ] || [ "$GITHUB_BRANCHNAME" != master ]; \
    then  \
    git remote add ${GITHUB_USERNAME} https://github.com/${GITHUB_USERNAME}/osu.git \
    && git fetch ${GITHUB_USERNAME} ${GITHUB_BRANCHNAME} \
    && git checkout -b ${GITHUB_BRANCHNAME} ${GITHUB_USERNAME}/${GITHUB_BRANCHNAME}; \
    fi

WORKDIR /project/osu-tools

RUN /bin/bash -c ./UseLocalOsu.sh

WORKDIR /project/osu-tools/PerformanceCalculator

RUN dotnet build
