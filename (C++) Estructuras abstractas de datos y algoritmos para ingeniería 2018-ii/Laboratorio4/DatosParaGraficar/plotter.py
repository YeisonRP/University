import sys
import plotly
import matplotlib.pyplot as pyplot 


def init(argv):
    x_file = sys.argv[1]
    y_file = sys.argv[2]
    if len(sys.argv) == 4:
        z_file = sys.argv[3]
        return [x_file, y_file, z_file]
    else:
        return [x_file, y_file]






def main():
    data_files = init(sys.argv)
    _3d = False
    if len(data_files) == 3: _3d = True

    x=[]
    y=[]
    z=[]

    with open(data_files[0], "r") as x_file: 
        x = x_file.readlines()
        x = [ float(i) for i in x ]
        
    with open(data_files[1], "r") as y_file: 
        y = y_file.readlines()
        y = [ float(i) for i in y ]
    
    if _3d: 
        with open(data_files[2], "r") as z_file: 
            z = z_file.readlines()
            z = [ float(i) for i in z ]


    pyplot.plot(x, y, linestyle='-', linewidth=1)
    pyplot.grid(which='both', axis='both', color="#DDDDDD")
    pyplot.show()



#####################
main()
