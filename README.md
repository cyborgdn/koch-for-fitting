# Koch Implementation for Additive Manufacturing
The program files have been fully contained and have been 
implemented for the validation in test case scenario. The document
shall mention the methods by which a user can access the benefits
of the program and hence can make the G-Code for the arbitrary shape
of his/her own desire.

# Steps to Follow:

1. All the files should be present in the same folder and the targeted
folder must be chosen as such, that MATLAB can access the folder for
file generation and operations.

2. Run the 'main.m' file (This is the GUI file and would contain the 
connected files which would be present in all other segments)

3. From the GUI generated, choose the functions that are currently 
required by you.

4. Before starting to draw, the user have to initialise the program
such that the program refreshes its memory and hence can be utilised 
for further purposes.

5. Here, the fractal curves have been implemented for the generation 
of GCodes for the operations. (Being a heavy logic file, the program
requires some time to completely blend with the generated drawing and
hence the user is requested to wait for about 40-50 seconds)

6. Choose the operations required (The program has seperate bases for
Milling code and 3D Printing code) - (This would generate the file for
the G-Code to run)

7. IF the user wants to implement otherwise, the program has the option
to export the datapoints in the form of a excel file and hence the generated
file would be accessible by any '*.xls' reading file.

# External Software:

The Program doesn't use any form of external software for the purpose
of implementation. However, for the sake of iteration and rechecking the 
generated solutions, the CNCSimulator Pro (Trial) software has bee used.

https://cncsimulator.info/download

(Download the software from the above link and have the generated g-code
tested and hence make certain changes as desired)
