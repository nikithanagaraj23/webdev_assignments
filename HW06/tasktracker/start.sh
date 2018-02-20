#!/bin/bash

export PORT=5122

cd ~/www/tasktracker
./bin/tasktracker stop || true
./bin/tasktracker start
