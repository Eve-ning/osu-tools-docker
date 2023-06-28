FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG GIT_USERNAME
ARG GIT_BRANCHNAME

WORKDIR /project

RUN git clone https://github.com/ppy/osu-tools
RUN git clone https://github.com/ppy/osu

WORKDIR /project/osu
# Only switch branch if it's not already the default.
RUN if [ $GIT_USERNAME != ppy -o $GIT_BRANCHNAME != master ]; \
    then  \
    git remote add ${GIT_USERNAME} https://github.com/${GIT_USERNAME}/osu.git \
    && git fetch ${GIT_USERNAME} ${GIT_BRANCHNAME} \
    && git checkout -b ${GIT_BRANCHNAME} ${GIT_USERNAME}/${GIT_BRANCHNAME}; \
    fi

WORKDIR /project/osu-tools

RUN /bin/bash -c ./UseLocalOsu.sh

WORKDIR /project/osu-tools/PerformanceCalculator

RUN dotnet build
