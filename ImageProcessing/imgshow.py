import cv2
import sys

img = cv2.imread('/home/telescreen/Workspace/Data/Flowers/image_00001.jpg')
if img is None:
    sys.exit('Could not read image')

cv2.imshow("Display Window", img)
cv2.waitKey()
cv2.destroyAllWindows()
