# GCC support can be specified at major, minor, or micro version
# (e.g. 8, 8.2 or 8.2.0).
# See https://hub.docker.com/r/library/gcc/ for all supported GCC
# tags from Docker Hub.
# See https://docs.docker.com/samples/library/gcc/ for more on how to use this image
FROM gcc:12.1 as build

# These commands copy your files into the specified directory in the image
# and set that as the working location
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# This command compiles your app using GCC, adjust for your source code
RUN g++ -o myapp MyCpp/MyCpp.cpp

FROM alpine:3.16 as runtime
RUN apk add --no-cache libc6-compat=1.2.3-r0 libstdc++=11.2.1_git20220219-r2
COPY --from=build /usr/src/myapp/myapp /usr/local/myRenamedApp
WORKDIR /usr/local/

# This command runs your application, comment out this line to compile only
CMD ["./myRenamedApp"]

LABEL name=myRenamedApp version=0.0.1
