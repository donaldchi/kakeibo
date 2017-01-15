#!/usr/bin/env python
#coding: utf-8

f = open ("test.txt", "w")
f.write("abcdef")
f.close()


f1 = open ("test.txt", "r")
for line in f1:
	print(line)

f1.close()
