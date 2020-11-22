#!/bin/bash

# download restriced data
curl -L --digest --user jiayuanyao@ntu.edu.sg:Agdnjgh3yh86 -o data.mseed 'http://service.iris.edu/fdsnws/dataselect/1/queryauth?net=ZE&sta=KALS&cha=HHZ&start=2016-01-24T10:30:30&end=2016-01-24T10:50:30'

