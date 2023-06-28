FROM mcr.microsoft.com/dotnet/sdk:6.0

ARG OSU_GIT
ARG OSU_TOOLS_GIT

WORKDIR /project

RUN git clone "$OSU_GIT"
RUN git clone "$OSU_TOOLS_GIT"

WORKDIR /project/osu-tools
RUN /bin/bash -c ./UseLocalOsu.sh

WORKDIR /project/osu-tools/PerformanceCalculator
RUN dotnet build
