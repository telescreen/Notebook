import cv2
import sys

img = cv2.imread('/home/telescreen/Documents/Data/Flowers/image_06821.jpg')
if img is None:
  sys.exit('Could not read image')

cv2.imshow("Display Window", img)
cv2.waitKey(0)

sys.exit(0)
