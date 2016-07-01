#import library - MUST use cv2 if using opencv_traincascade
import sys
sys.path.append('/usr/local/lib/python2.7/site-packages')
import cv2

# rectangle color and stroke
color = (0,0,255)       # reverse of RGB (B,G,R) - weird
strokeWeight = 1        # thickness of outline

# set window name
windowName = "Object Detection"

# load an image to search for faces
img = cv2.imread("/Users/saadia/Desktop/wsrlib/TestingData_VR/KDOX20080910_103829_V04.gz.png") #("/Users/saadia/Desktop/wsrlib/TestingData/20080922-vr-105632.png") ("/Users/saadia/Desktop/wsrlib/TestingData/20080901-vr-103550.png")  #("/Users/saadia/Desktop/wsrlib/positiveSamples/109758-gray-6346.png") ("/Users/saadia/Desktop/wsrlib/TestingData/20080922-105632.png") ("/Users/saadia/Desktop/wsrlib/TestingData/20080901-103550.png") #/Users/saadia/Desktop/wsrlib/positiveSamples/109758-gray-6346.png

# load detection file (various files for different views and uses)
cascade = cv2.CascadeClassifier("/Users/saadia/Desktop/wsrlib/cascade4/cascade.xml")

# preprocessing, as suggested by: http://www.bytefish.de/wiki/opencv/object_detection
img_copy = cv2.resize(img, (img.shape[1]/2, img.shape[0]/2))
gray = cv2.cvtColor(img_copy, cv2.COLOR_BGR2GRAY)
gray = cv2.equalizeHist(gray)

# detect objects, return as list
rects = cascade.detectMultiScale(img,scaleFactor=1.1, minNeighbors=50, minSize=(2, 2), maxSize = (194,194), flags = 0) #(img,scaleFactor=1.1, minNeighbors=10, minSize=(2, 2), maxSize = (194,194), flags = 0)
print(rects)
thefile = open("/Users/saadia/Desktop/wsrlib/code/rects.txt","w")
i = 0
thefile.write("{0}\n".format(841836)) #841646 for 20080901-vr-103550 #12215 for KDOX20090801_100959_V04 #109758 for 109758-gray-6346
for x in rects:
     line = "{0} {1} {2} {3}\n".format(rects[i][0], rects[i][1], rects[i][2], rects[i][3])
     thefile.write(line)
     i = i + 1
     #thefile.write('%d\n' % x)
thefile.close()
# display until escape key is hit
while True:
    
    # get a list of rectangles
    for x,y, width,height in rects:
        cv2.rectangle(img, (x,y), (x+width, y+height), color, strokeWeight)
    # display!
    cv2.imshow(windowName, img)

# escape key (ASCII 27) closes window
if cv2.waitKey(20) == 27:
# if esc key is hit, quit!
    exit()