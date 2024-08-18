ans = []

fProd = 0
for r in range(2, 2000):
    prod = 1
    for i in range(2, r + 1):
        prod *= (202 - i) / 200
    fprod = ((r - 1) / 200) * prod
    ans.append(fprod)

max_ans = max(ans)
max_index = ans.index(max_ans)

print(max_index)

# here index 0 is considered as position 2 so our ans is index+2
# after 200 cards there is no possibiltity
