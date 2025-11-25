# Base stage - tools
FROM ubuntu:24.04 AS base
RUN apt-get update && apt-get install -y gcc valgrind
WORKDIR /app

# Build stage - compile and test
FROM base AS build
COPY *.c .
RUN gcc -g -o main main.c
RUN valgrind --leak-check=full --error-exitcode=1 ./main

# Production stage - optimized binary
FROM base AS production
COPY *.c .
RUN gcc -O3 -o main main.c