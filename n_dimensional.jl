# n-dimensional extension of the logic to beat 7-5-3

function isLegalMove(next_move)
    dimensions = 0 
    for i in eachindex(next_move)
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
        next_move = new_state .- l
        if isLegalMove(next_move)
            #winning_move = [next_move,l]
            #print("from ")
            #print(new_state)
            #print(" to ")
            #println(l)
            #push!(win,new_state)
            return
        end
    end
    push!(lose,new_state)
end

function play(tuple::Tuple)
    A = zeros(tuple)
    ind = CartesianIndices(A)
    tupleInd = Tuple.(ind)
    for i in tupleInd
       new_state = map(x->x-1,i)
       checkState(new_state)
    end
end

function initializeLosingStates(start_position)
    dimensions = length(start_position)
    elementary_lose_list = []
    for i in 1:dimensions
        elementary_lose = []
        for j in 2:i
            push!(elementary_lose,0)
        end
        push!(elementary_lose,1)
        for j in i:dimensions-1
            push!(elementary_lose,0)
        end
        push!(elementary_lose_list,elementary_lose)
    end
    return elementary_lose_list
end

function createStartPosition()
    println("Enter Start Position (separated by space, enter to stop) ")
    input = split(readline())
    start_pos = []
    for i in input
        if inputValidation(i)
            push!(start_pos,parse(Int,i))
        end
    end
    return Tuple(start_pos)
end

function inputValidation(string)
    for i in 1:length(string)
        if string[i] < '0' || string[i] > '9'
            return false
        end
    end
    return true
end

using DelimitedFiles

path = "C:\\Users\\Jonah\\Code\\Julia\\753"
global outputFilePath = path * "\\" * "losing_states" * ".txt"
if isfile(outputFilePath)
    rm(outputFilePath)
end

start_position = createStartPosition()
lose = initializeLosingStates(start_position)
win = []

play(start_position)

open(outputFilePath, "a") do f
    for l in lose
        r = reverse(l)
        str = string.(r)
        writedlm(f,str)
        writedlm(f,'\n')
    end
end


