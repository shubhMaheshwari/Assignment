1. 



2. We can see the Filter can detect horizontal edges in the image
		- Hence we can use something similiar to this for edge detection 
		- When we are sliding through the image
			- When no edge is present the summation of the filter returns 0 
			- When horizontal edge is  present we get a high value(sign of the value doesn't matter)

	For M' we should get vertical edges

	Reference -> https://www.youtube.com/watch?v=uihBwtPIBxM		


3. We are given 
	- Image size 	 = Width, Height, Channels
	- No. of filters = N 
	- filter size 	 = F,F,Channels
	- Stride 		 = S
	- padding 		 = Z


	If we want to fit the filter

	For one Filter:
		Output Size = N*(Width - F + 2P)/S  + 1, N*(Height -F +2P)/S + 1, Channels)   
		Note = > Make sure Width - F + 2P is divisible by S, or nodes will be wasted.
	For N filters


	No. of Muliplications: 
		Multiplications in 1 Operation = F*F
		Addition in 1 Operation = 1 
		Total Operations = Output_width*Output_Height*Channels

		Total Multiplication = (F*F) * (Output_width*Output_Height*Channels)
		Total Addition = 1 * Output_width*Output_Height*Channels

	Reference => http://cs231n.github.io/convolutional-networks/

4.	How to add reverb in audio 
	1. We recorded video 
	2. Subsampled to different frequecy 
	3. Adding reverb 	