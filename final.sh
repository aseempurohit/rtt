/home/apertium-apy/servlet.py -p 4897 /usr/share/apertium &

java -Dtransports.netty.conf=/home/temp.yaml -jar /home/tesseract-ocr-service-1.0-SNAPSHOT.jar &

java -Dtransports.netty.conf=/home/msf4j-http-config.yaml -DOCR_SERVICE_HOST_NAME=$OCR_SERVICE_HOST_NAME -DOCR_SERVICE_PORT_NUMBER=$OCR_SERVICE_PORT_NUMBER -DTRANSLATION_SERVICE_HOST_NAME=$TRANSLATION_SERVICE_HOST_NAME -DTRANSLATION_SERVICE_PORT_NUMBER=$TRANSLATION_SERVICE_PORT_NUMBER -jar /home/Cloudlet-0.0.1-SNAPSHOT.jar &
