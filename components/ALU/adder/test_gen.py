import random
import numpy as np

a = []
b = []
sum = []

mm = 0

# Generate txt file for testing
with open("adder_tb.txt", 'w') as f:
    for i in range(1000):
        a.append(random.getrandbits(64))
        b.append(random.getrandbits(64))
        sum.append(a[i] + b[i])
        line = "{0:064b}_{0:064b}_{0:064b}\n".format(a[i], b[i], sum[i])
        f.write(line)
f.close()
        
# Verify output is as expected
with open("adder_tb.txt", 'r') as f:
    lines = f.readlines()
    for line in lines:
        if (len(line) >195):
            mm += 1
if(mm!=0):
    print("Error in generation")
else:
    print("Generated successfully")
f.close()   
print(mm)