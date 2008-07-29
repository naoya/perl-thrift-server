#!/usr/bin/thrift
# namespace cpp  Hello
# namespace perl Hello

service Hello
{
  string hello(1: string name)
}