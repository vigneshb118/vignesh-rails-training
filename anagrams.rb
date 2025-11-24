strs = ["xyzzzzzzzzzzzz","zzzzzzzzzzzzyx"]

anagrams = []
i = 0
while(strs[i])
    j = i+1
    arr = []
    while(strs[j])
        intersection = (strs[i].chars & strs[j].chars)
        if (!intersection.empty? && strs[i] == intersection.join) || (strs[i] == strs[j])
            arr << strs.delete_at(j)
        else
            j += 1
        end
    end
    arr << strs.delete_at(i)
    anagrams << arr
end

p anagrams