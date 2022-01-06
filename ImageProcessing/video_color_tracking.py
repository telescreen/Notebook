import cv2
import numpy as np

top_left = (0, 0)
bottom_right = (0, 0)

top_left_clicked = False
bottom_right_clicked = False

def draw_rectangle(event, x, y, flags, param):
    """ Update rectangle point when mouse clicked event triggered """
    global top_left, bottom_right, top_left_clicked, bottom_right_clicked

    if event == cv2.EVENT_LBUTTONDOWN:

        # Reset the rectangle
        if top_left_clicked and bottom_right_clicked:
            top_left = (0, 0)
            bottom_right = (0, 0)
            top_left_clicked = False
            bottom_right_clicked = False

        if not top_left_clicked:
            top_left = (x, y)
            top_left_clicked = True

        elif not bottom_right_clicked:
            bottom_right = (x, y)
            bottom_right_clicked = True



cap = cv2.VideoCapture(0)
cv2.namedWindow('DispImage')
cv2.setMouseCallback('DispImage', draw_rectangle)

while True:
    ret, frame = cap.read()

    if top_left_clicked:
        cv2.circle(frame, top_left, 5, (0, 0, 255), -1)

    if top_left_clicked and bottom_right_clicked:
        cv2.rectangle(frame, top_left, bottom_right, (0, 0, 255), 3)

    cv2.imshow('DispImage', frame)

    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
