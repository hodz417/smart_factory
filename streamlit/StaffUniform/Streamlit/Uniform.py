import streamlit as st
import cv2
import numpy as np
from ultralytics import YOLO

def detect_fire(image):
    model = YOLO("streamlit/StaffUniform/Model/Uniform.pt")
    prediction = model.predict(image)
    return prediction, model.names

st.title("Uniform Detection")
st.write("Upload an image to detect Uniform:")

uploaded_file = st.file_uploader("Upload an image", type=["jpg", "png", "jpeg"])

if uploaded_file is not None:
    # Convert the uploaded file to an OpenCV image
    file_bytes = np.frombuffer(uploaded_file.read(), np.uint8)
    image1 = cv2.imdecode(file_bytes, cv2.IMREAD_COLOR)
    
    if image1 is not None:
        prediction_result, class_names = detect_fire(image1)
        
        if len(prediction_result) > 0 and len(prediction_result[0].boxes) > 0:
            # Check the detected classes
            detected_classes = [class_names[int(box.cls)] for box in prediction_result[0].boxes]

            # Combine texts for each degree
            # (Here you can define the texts for different detected classes)
            detected_texts = []
            for detected_class in detected_classes:
                if detected_class == "class_name1":  # Replace with actual class name
                    detected_texts.append("Detected class 1.")
                elif detected_class == "class_name2":  # Replace with actual class name
                    detected_texts.append("Detected class 2.")
                # Add more classes as needed
            
            combined_text = " ".join(detected_texts)
            
            # Display the image with detected classes
            image = prediction_result[0].plot()
            # Convert the image from BGR to RGB for displaying correctly in Streamlit
            image_rgb = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
            
            # Display the image
            st.image(image_rgb, caption="Original Image with Detected food", use_column_width=True)
            
            # Display the combined text below the image
            st.write(combined_text)
        else:
            st.write("No  Uniform dected in the image.")
    else:
        st.write("Error in loading the image.")
