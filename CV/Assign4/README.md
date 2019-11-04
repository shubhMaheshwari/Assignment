# CV Assignment 4 
## "GrabCut" — Interactive Foreground Extraction using Iterated Graph Cuts
[Link to Paper](https://cvg.ethz.ch/teaching/cvl/2012/grabcut-siggraph04.pdf "GrabCut Paper")

# Implementation
A GUI program to display the result from a image segmentation algorithm named  

This program is a course project during my second year in university, so some functions in outdated libraries may be not supported by the newest libraries.

##### Requirements
```
​	python3.5
​	matplotlib
​	OpenCV
​	scikit-learn
​	PIL
​	wxPython
​	igraph
```
​	**Note**: To install igraph library , run **pip install python-igraph**. Do **not** run **pip install igraph**
   
   **Note**: To install wxPython library on GTK 3, Ubuntu 16.04 , run **pip3.5 install -U -f https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-16.04 wxPython**

## Usage
### Run
```
    python main.py
```
### Organization
```
./
./code
    ./GrabCut
        |--grab.py - call the GrabCut function in OpenCV.
        |--grabcut.py - use igraph and scikit-learn to implement GrabCut function.(Not a good implementation)
        |--main.py - build the GUI architecture by wxPython.
    ./mrf

./report
    |--Assignment.pdf - Question Details
    |--Report.pdf - Report on the current Implementation

./examples/
    |--bboxes - Bounding Boxes for each image
    |--images - Images
    

```

##### Examples

![1](1.gif)

![2](2.gif)