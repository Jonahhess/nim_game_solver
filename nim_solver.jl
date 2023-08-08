# logic to beat nim using min-max strategy
# idea: make a 7x5x3 matrix, where each index is a gamestate

# win-lose logic: if all of the states are lose states, this is a win state.

# (1,2,3) is a winning state, because any state from here is a losing state

function isLegalMove(next_move)
    dimensions = 0 
    for i in range(1,3)
        if next_move[i] < 0
            return false
        end
        if next_move[i] > 0
            dimensions += 1
        end
    end

    if dimensions == 1
        return true
    else 
        return false
    end
end

function checkState(new_state)
    for l in lose
        next_move = (new_state[1] - l[1],new_state[2] - l[2], new_state[3] - l[3])
        if isLegalMove(next_move)
            print("from ")
            print(new_state)
            print(" to ")
            println(l)
            push!(win,new_state)
            return
        end
    end
    push!(lose,new_state)
end

function iterateRegular(list)
    for i in range(0,X), j in range(0,Y), k in range(0,Z)
        new_state = [i,j,k]
        checkState(new_state)
    end
end

lose = [[1,0,0],[0,1,0],[0,0,1]]
win = []
all = []
X = 7
Y = 5
Z = 3
list = (X,Y,Z)

iterateRegular(list)

print("Losing States")
println(lose)