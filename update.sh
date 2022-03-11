#!/bin/bash

ruby 2-generate-md-2.rb
git add . && git commit -m 'update site' && git push origin main