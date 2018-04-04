#!/bin/bash

export PORT=5153

cd ~/www/tasktracker3
./bin/tasktracker3 stop || true
./bin/tasktracker3 start
