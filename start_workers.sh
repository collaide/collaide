#!/bin/sh
bundle exec env rake resque:workers QUEUE='*' COUNT='3'