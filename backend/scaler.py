mean_array = [0.429245, 49.580189, 9.005937, 0.029615, 0.310613, 236.699523, 132.354599, 82.897759, 25.800801, 75.878981,81.963655]
std_array = [81.963655, 8.572942, 11.922462, 0.169544, 0.462799, 44.591284, 22.033300, 11.910394, 4.079840, 12.025348, 23.954335]
def scale(array):
    counter = 0
    scaled_array = []
    for value in array:
        s_value = (value - mean_array[counter])/std_array[counter]
        scaled_array.append(s_value)
        counter = counter + 1
    return scaled_array