FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG OSU_GIT
ARG OSU_GIT_BRANCH
ARG OSU_TOOLS_GIT
ARG OSU_TOOLS_GIT_BRANCH

WORKDIR /project

RUN git clone -b "$OSU_GIT_BRANCH" "$OSU_GIT"
RUN git clone -b "$OSU_TOOLS_GIT_BRANCH" "$OSU_TOOLS_GIT"

WORKDIR /project/osu-tools
RUN /bin/bash -c ./UseLocalOsu.sh

WORKDIR /project/osu-tools/PerformanceCalculator
RUN dotnet build
