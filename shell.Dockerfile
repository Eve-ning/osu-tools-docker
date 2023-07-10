FROM mcr.microsoft.com/dotnet/sdk:6.0 AS base

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
RUN dotnet build -o /osu.tools.build

FROM mcr.microsoft.com/dotnet/runtime:6.0-alpine3.18
WORKDIR /osu.tools.build
COPY --from=base /osu.tools.build /osu.tools.build

ENTRYPOINT /bin/sh