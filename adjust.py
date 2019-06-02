#!/usr/bin/python
# coding: utf-8

import sys
import datetime


fname = sys.argv[1]
ms = sys.argv[2]

file = open(fname)


def offset(line):
	t1 = line[0:12].replace(',', '.')
	t2 = line[17:29].replace(',', '.')
##	d =datetime.deltatime(microseconds,ms)
	return t1


while 1:
	line = file.readline()
	if not line:
		break
	if line.find('-->') != -1 :
		print offset(line)


