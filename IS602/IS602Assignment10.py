import scipy.ndimage as ndimage
import scipy.misc as misc
import matplotlib.pyplot as pylab
import numpy as np
import Tkinter
import tkFileDialog


def open_png():
	root=Tkinter.Tk()
	root.withdraw()
	filename=tkFileDialog.askopenfilename(parent=root)
	return filename

def process_img_mean(photo,n):
	objects = misc.imread(photo)
	img = ndimage.gaussian_filter(objects,n)
	thres = img > img.mean()
	labs, count = ndimage.measurements.label(thres)
	centers = ndimage.measurements.center_of_mass(thres, labs, range(1, count + 1))
	pylab.imshow(objects)
	pylab.scatter([each[1] for each in centers], [each[0] for each in centers],color='red')
	pylab.show()


if __name__ == '__main__':
	image_file = open_png()
	process_img_mean(image_file,8)
