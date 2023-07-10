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

WORKDIR /project/osu-tools/PerformanceCalculatorGUI
RUN dotnet build -o /osu.tools.gui.build

FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /osu.tools.gui.build
COPY --from=base /osu.tools.gui.build /osu.tools.gui.build

ENTRYPOINT /bin/sh