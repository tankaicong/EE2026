import numpy as np
from scipy.signal import correlate2d

class Convolution:
    def __init__(self, input_shape, filter_size, num_filters):
        input_height, input_width = input_shape
        self.num_filters = num_filters
        self.input_shape = input_shape

        self.filter_shape = (num_filters, filter_size, filter_size) # (3,3)
        self.output_shape = (num_filters, input_height - filter_size + 1, input_width - filter_size + 1)
        
        self.filters = np.random.randn(*self.filter_shape)
        self.biases = np.random.randn(*self.output_shape)

    def forward(self, input_data):
        self.input_data = input_data

        output = np.zeros(self.output_shape)
        
        for i in range(self.num_filters):
            output[i] = correlate2d(self.input_data, self.filters[i], mode="valid")
        
        # ReLU activation
        output = np.maximum(output, 0)
        return output
    
    def backward(self, dL_dout, lr):
        # Create a random dL_dout array to accommodate output gradients
        dL_dinput = np.zeros_like(self.input_data)
        dL_dfilters = np.zeros_like(self.filters)

        for i in range(self.num_filters):
                # Calculating the gradient of loss with respect to kernels
                dL_dfilters[i] = correlate2d(self.input_data, dL_dout[i],mode="valid")

                # Calculating the gradient of loss with respect to inputs
                dL_dinput += correlate2d(dL_dout[i],self.filters[i], mode="full")

        # Updating the parameters with learning rate
        self.filters -= lr * dL_dfilters
        self.biases -= lr * dL_dout

        # returning the gradient of inputs
        return dL_dinput
    
    class MaxPool:
        def __init__(self, pool_size):
            self.pool_size = pool_size

        def forward(self, input_data): #take the maximum value within a patch
            self.input_data = input_data
            self.num_channels, self.input_height, self.input_width = input_data.shape
            self.output_height = self.input_height // self.pool_size
            self.output_width = self.input_width // self.pool_size

            # Determining the output shape
            self.output = np.zeros((self.num_channels, self.output_height, self.output_width))

            # Iterating over different channels
            for c in range(self.num_channels):
                # Looping through the height
                for i in range(self.output_height):
                    # looping through the width
                    for j in range(self.output_width):

                        # Starting postition
                        start_i = i * self.pool_size
                        start_j = j * self.pool_size

                        # Ending Position
                        end_i = start_i + self.pool_size
                        end_j = start_j + self.pool_size

                        # Creating a patch from the input data
                        patch = input_data[c, start_i:end_i, start_j:end_j]

                        #Finding the maximum value from each patch/window
                        self.output[c, i, j] = np.max(patch)

            return self.output

        def backward(self, dL_dout, lr):    #propagate the max gradient from previous layer to the next layer
            dL_dinput = np.zeros_like(self.input_data)

            for c in range(self.num_channels):
                for i in range(self.output_height):
                    for j in range(self.output_width):
                        start_i = i * self.pool_size
                        start_j = j * self.pool_size

                        end_i = start_i + self.pool_size
                        end_j = start_j + self.pool_size
                        patch = self.input_data[c, start_i:end_i, start_j:end_j]

                        mask = patch == np.max(patch)

                        dL_dinput[c,start_i:end_i, start_j:end_j] = dL_dout[c, i, j] * mask

            return dL_dinput