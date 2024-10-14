n = int(input())

def frac(n):
    if (n <= 0):
        return 1
    return n * frac(n - 1)

print(frac(n))