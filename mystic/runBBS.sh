#!/bin/bash
find . -name *.bsy -exec rm {} \;
exec sudo /mystic/mis server
