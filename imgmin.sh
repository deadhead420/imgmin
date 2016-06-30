#!/bin/bash

usage() {

	this=${0##*/}
	echo
	echo "Usage: $this [options] [images]"
	echo
	echo "Examples:"
	echo "	$this --size 50 test_img.png"
	echo "	$this --right test_img.jpg"
	echo "	$this -s 200 test_img.jpeg"
	echo
	echo "Options:"
	echo "	'-r' '--right' - Rotate selected image(s) right"
	echo "	'-l' '--left' - Rotate selected image(s) left"
	echo "	'-s' '--size' - Resize selected image(s) by percentage (+ or -)"
	echo

}

get_opts() {

	case "$1" in
		-h|--help)	usage
					exit 0
		;;
		-s|--size)	shift
					PERCENT="$1"
					shift
					resize "$@"
		;;
		-r|--right) DIRECTION="$1"
					shift
					rotate "$@"
		;;
		-l|--left) 	DIRECTION="$1"
					shift
					rotate "$@"
		;;
	esac

}

resize() {

	while (( "$#" )); do  
		convert "$1" -resize "$PERCENT%" -quality 100 "resized_to_${PERCENT}%_$1"
		shift
	done

	exit 0

}

rotate() {

	case "$DIRECTION" in
	  -r|--right)	while (( "$#" )); do
	      		convert -rotate 90 -quality 100 "$1" "$1" 
	      		shift
	    	done
	  ;;
	  -l|--left)	while (( "$#" )); do
	      		convert -rotate -90 -quality 100 "$1" "$1"
	      		shift
	    	done
	  ;;
	esac

	exit 0

}

get_opts "$@"
