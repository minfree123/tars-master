#!/bin/bash
docker run -dt --name tars --net=host -v /Users/pengyouhui/work/Docker/master:/data -p 3000:3000 tars-master:v1.0
