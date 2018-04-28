#!/usr/bin/python3

import matplotlib.pyplot as plt
import numpy as np
import sys

def main():
    if len(sys.argv) < 4:
        print("Too few arguments")
        return

    try:
        with open(sys.argv[1]) as f: lines = f.readlines()
    except IOError as e:
        print(str(e))
        return
    N = int(sys.argv[2])

    X = np.arange(10, N+1, 1)
    Y = np.zeros(len(lines))

    for i, line in enumerate(lines): Y[i] = float(line)

    plt.ticklabel_format(style='sci', axis='y', scilimits=(0,0), useOffset=True)
    plt.xlabel('N')
    plt.ylabel('Absolute error')
    plt.xticks(np.arange(0, np.amax(X)+1, 10**(int(np.log10(np.amax(X)))-1)))
    plt.yticks(np.linspace(np.amin(Y), np.amax(Y), 10))
    plt.plot(X, Y, '.')
    plt.savefig(sys.argv[3] + '.png')

if __name__ == '__main__':
    main()