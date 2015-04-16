#!/bin/bash
# echo the file selected
echo filename: "$1"
# start the server with the file as an arguement
shotgun server.rb $1
