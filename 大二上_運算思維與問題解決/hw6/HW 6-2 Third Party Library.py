import cv2
img = cv2.imread('tora.jpg')
img = cv2.resize(img, (302, 403), interpolation=cv2.INTER_CUBIC)
cv2.putText(img, 'H14086030', (50,50),cv2.FONT_HERSHEY_DUPLEX , 1, (200,200,0), 1,)
cv2.namedWindow('My Image', cv2.WINDOW_NORMAL)
cv2.imshow('My Image', img)
cv2.waitKey(1000)
cv2.imwrite('output.jpg', img, [cv2.IMWRITE_JPEG_QUALITY, 90])