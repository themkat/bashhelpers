#!/bin/bash

# attempt at replacing my houndreds of useJava11, useJava8, useJava18 aliases :P 
function use_java() {
    # TODO: this probably only supports Mac?
    #       is it possible to create something flexible that will work anywhere?
    export JAVA_HOME=$(/usr/libexec/java_home -v $1)
}
