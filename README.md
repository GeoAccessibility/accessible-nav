# Accessible Pathways: An AI-Driven Approach to Urban Accessibility

## Object Detection
Our application leverages cutting-edge computer vision technology to detect and predict accessibility features such as wheelchair ramps and accessible pathways from street view videos. The objective is to integrate these detections into our Simultaneous Localization and Mapping (SLAM) model, thereby creating a dynamic and comprehensive map of the environment. This map can be used for efficient navigation and accessibility planning.

Here's a brief overview of our process:
* **Camera Calibration**. This process helps us understand the camera's intrinsic and extrinsic parameters, which are crucial for mapping the image coordinates to real-world coordinates.
* **Object Detection with YOLOv4**. The model identifies accessibility features and creates an overlay image with bounding boxes of the detected objects for each video frames. These bounding boxes are then overlaid back onto the subsequent frames of our video stream, providing real-time object detection.
* **Conversion to Geospatial Data**. This involves mapping the image coordinates of the detected objects to real-world coordinates, taking into account the camera's field of view, orientation, and location.
* **Updating the SLAM Map**. The geospatial data derived from the object detection is used to update our SLAM map.

Below are screenshots demonstrating how the object detection works:
![skating](yolo_video_output/img1.png)
![Biking](yolo_video_output/img4.png)

## AR Road Steepness Visualization
This feature allows our users to do informed decisions about which road to choose before having to encounter an impossible cliff or an unnaccessible ramp. Taking advantage of Augmented Reality Core, the user can see a real 3D representation of how steep will the road or ramp be, grabbing real time data from the terrain the route suggests. 

<img src="https://github.com/GeoAccessibility/accessible-nav/assets/7455707/74d885e6-cf2e-4d69-b602-1f4e730f771e" width=300 />
<img src="https://github.com/GeoAccessibility/accessible-nav/assets/7455707/4921f946-f7a6-4b78-99de-a09b689f2f95" width=300 />
<img src="https://github.com/GeoAccessibility/accessible-nav/assets/7455707/b5187396-3867-4797-8a6e-5a17dffa4377" width=300 />

Using RealityKit will also allow users to use Apple Vision Pro once it releases. 

To see the functionallity and logic behind this feature, go to the [AR branch](https://github.com/GeoAccessibility/accessible-nav/blob/AR/AccessibleNav/ARView.swift).

## iOS Application

The NavigAbility iOS app features an Apple Maps view, buttons for common destinations and routes with estimated arrival times, total time and distance.

<img width="200" alt="Splash Screen" src="https://github.com/GeoAccessibility/accessible-nav/assets/60060421/da102dac-40b9-40c2-96d6-b1078a85bbe1">
<img width="200" alt="Main Screen" src="https://github.com/GeoAccessibility/accessible-nav/assets/60060421/1bfbbeed-c41a-480f-9c33-dc86a235b1ae">
<img width="200" alt="Filter Screen" src="https://github.com/GeoAccessibility/accessible-nav/assets/60060421/3f29f7d3-56c4-4c6d-bf89-4fb2d5763460">
<img width="200" alt="Navigation Screen" src="https://github.com/GeoAccessibility/accessible-nav/assets/60060421/f328a128-bbef-46fe-a74a-180d2dbb0212">


---
**Statement**
This application is developed for non-profit purposes and is intended to improve urban accessibility for all. The video footage used in our model is exclusively shot in public area. Our goal is to create a more inclusive and accessible environment, and we are committed to doing so in a manner that respects individual privacy and public space.
