#!/bin/sh
project_name=${1:-$(printf '%q\n' "${PWD##*/}")}
pkill -f "[t]mux.*[${project_name:0:1}]${project_name:1:${#project_name}-1}"
