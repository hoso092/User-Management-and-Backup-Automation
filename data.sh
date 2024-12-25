#!/bin/bash


read -p "Please Enter Your user Name : " user

read -p "Please Enter Your user full-Name : " name

INFO=$user,$name

read -p "Please, confirm that you have entered the correct information. Is every thing correct ? [y/n]  : " input 

case $input in
	N | n)
		exit
		;;
	Y|y)
		echo $INFO >> employee.csv 
		;;
	*)
		exit
		;;
esac
echo "Your Data Has been Stored Sucessfuly "
		


