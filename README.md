# Concurrent Binary Multiplication

The program takes in two numbers from the user, convert them into binary, and displays the binary result. The result is a list of bits and not a string. The principle of integer multiplication is followed i.e each bit of the second number is multiplied with the first number. Each bit is allocated a different thread to work on.

To run the program:
	sbcl --script binary_multiplication.lisp

