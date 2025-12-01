n = int(input("Enter number of rows: "))

for i in range(1, n + 1):     # loop for each row
    print("*" * i)            # print i stars in the i-th row


n = int(input("Enter number of rows: "))

n = 5

for i in range(1, n + 1):        # outer loop -> rows
    for j in range(1, i + 1):    # inner loop -> columns
        # print stars at the borders
        if j == 1 or j == i or i == n:
            print("*", end="")
        else:
            print(" ", end="")   # spaces inside
    print()                      # move to next line
