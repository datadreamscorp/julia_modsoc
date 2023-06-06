module julia_modsoc2023

greet() = print("Hello World!")

function sum_x_y(x,y)
    x + y
end

function blah(x)
	if x == 1
		return 1
	else
		return "lol"
	end
end

f(x,y) = x+y

function add_all(n::Integer)
	vector = 1:n
	sum = 0
	for i in vector
		sum += i
	end
	return sum
end

function add_all_even(n::Integer)
	vector = 1:n
	sum = 0
	for i in vector
        if i%2 == 0
		    sum += i
        end
	end
	return sum
end

function add_all_even_and_three(n::Integer)
	vector = 1:n
	sum = 0
	for i in vector
        if i%2 == 0
		    sum += i
        elseif i == 3
            sum += i
        end
	end
	return sum
end

end # module julia_modsoc2023
