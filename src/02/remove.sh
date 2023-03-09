#!/bin/bash

sudo rm -rvI $(awk '{print $1}' infod.log)
rm info.log infod.log path_dir