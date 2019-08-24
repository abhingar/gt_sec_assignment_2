#!/bin/bash
find ../ -type f -name Todo*.zip -exec unzip -u '{}' \; 
find Todos -type f -path "*todos*" 
