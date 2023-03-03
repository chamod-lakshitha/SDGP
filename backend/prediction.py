import pickle
import sys
from scaler import *

model = pickle.load(open("CHD_Model.pkl", "rb"))
print(model.predict([scale([float(sys.argv[1]),float(sys.argv[2]),float(sys.argv[3]),float(sys.argv[4]),float(sys.argv[5]),float(sys.argv[6]),float(sys.argv[7]),float(sys.argv[8]),float(sys.argv[9]),float(sys.argv[10]),float(sys.argv[11])])]))