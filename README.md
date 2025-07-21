# Approximate-mac-unit-for-edge-detection
This project presents the design and implementation of a Vedic Multiply-Accumulate (MAC) unit for 
edge detection, optimized for FPGA deployment using Xilinx ISE. The Vedic multiplier leverages 
ancient Indian mathematics for efficient arithmetic operations, offering advantages in speed and 
resource utilization compared to conventional multipliers. The MAC unit is implemented in 
Verilog/VHDL and synthesized on Xilinx platforms, with applications in image processing tasks such 
as edge detection. 
 
Edge detection is achieved through a Sobel filter in Python, using the Vedic multiplier to perform 
pixel-wise gradient computations. Additionally, the project explores the design of an approximate 
MAC unit, focusing on reducing power consumption and area while maintaining acceptable accuracy 
levels. The impact of approximation is assessed by comparing the edge detection results from the 
Vedic MAC unit and the approximate MAC unit. 
 
Performance metrics, including Mean Square Error (MSE), Peak Signal-to-Noise Ratio (PSNR), Mean 
Absolute Error (MAE), Average Distance (AD), and Structural Similarity Index Measure (SSIM), are 
calculated to evaluate the image quality and computational efficiency. Results demonstrate that the 
approximate MAC unit significantly reduces power and area overheads with minimal degradation in 
edge detection performance, making it suitable for resource-constrained embedded systems. 
