import turtle
import time 
import random

"""
        Famous represantion of turtle class 
                by Ankur
"""

height = 640
width = 480

minstick = 9
maxstick = 35

def randomrow():
    return random.randint(minstick, maxstick)

class game(turtle):
    
    def __init(self, randomrow):
        self.randomrow = randomrow
        