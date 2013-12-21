#!/bin/bash
(cd "_out" && git add -A . && git commit -m "Sync website content" && git push)
