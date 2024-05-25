-module(calculator).
-export([add/2, subtract/2, multiply/2, divide/2, 
display_result/1, calculate/1, power/2, update_history/3, 
successful_calculations/1, fahrenheit_to_celsius/1, usd_to_euro/1, 
miles_to_kilometers/1, pee_in_pool/2, celsius_to_fahrenheit/1, calculate_bmi/2, 
calculate_percentage/2, calculate_circle_area/1, calculate_sphere_volume/1, 
hours_to_minutes/1]).

% Addition
add(A, B) ->
    A + B.

% Subtraction
subtract(A, B) ->
    A - B.

% Multiplication
multiply(A, B) ->
    A * B.

% Division
divide(A, B) when B =/= 0 ->
    A / B;
divide(_, _) ->
    {error, "Error!! Divided by zero!"}.

% Display results
display_result(Result) ->
    io:format("Result: ~p~n", [Result]).

% Temperature Converter
fahrenheit_to_celsius(F) ->
    (F - 32) * 5/9.

celsius_to_fahrenheit(C) ->
    (C*9/5) + 32.

% Money Converter
usd_to_euro(USD) ->
    USD * 0.82.

% Miles to Kilometers Converter
miles_to_kilometers(Miles) ->
    Miles * 1.60934. % 1 Mile = 1.60934 Kilometers

% Mark Roberts' Pee in Pool equation: https://youtu.be/S32y9aYEzzo
pee_in_pool(SwimmersPerDay, PeePerSwimmer) ->
    TotalPee = SwimmersPerDay * PeePerSwimmer * 2,
    Gallons = TotalPee / 3785.41, % Convert milliliters to gallons
    io:format("Estimated pee in the pool: ~.2f gallons\n", [Gallons]).

% BMI Calculator
calculate_bmi(Height, Weight) ->
    Height_m = Height / 100, % Convert height from centimeters to meters
    BMI = Weight / (Height_m * Height_m),
    BMI.

% Percent Calculator
calculate_percentage(Percentage, Number) ->
    Percentage / 100 * Number.

% Area of Circle
calculate_circle_area(Radius) ->
    math:pi() * Radius * Radius.

% Volume of a Sphere:
calculate_sphere_volume(Radius) ->
    (4/3) * math:pi() * math:pow(Radius, 3).

% Hours to minutes
hours_to_minutes(Hours) ->
    Hours * 60.

% Pattern Matching in Function Parameters
calculate({add, A, B}) ->
    add(A, B);
calculate({subtract, A, B}) ->
    subtract(A, B);
calculate({multiply, A, B}) ->
    multiply(A, B);
calculate({divide, A, B}) ->
    divide(A, B);
calculate({Op, A, B}) when is_number(A), is_number(B), Op =/= undefined ->
    Result =
        case Op of
            add -> add(A, B);
            subtract -> subtract(A, B);
            multiply -> multiply(A, B);
            divide -> divide(A, B)
        end,
    {ok, Result};
calculate(_) ->
    {error, "Invalid input"}.

% Exponentiation
power(_, 0) ->
    1;
power(A, B) when B > 0 ->
    A * power(A, B - 1).

% History of Calculations
-record(calculation, {operation, result}).

% Function to update history
update_history(Operation, Result, History) ->
    [#calculation{operation=Operation, result=Result} | History].

% Filter successful calculations
successful_calculations(History) ->
    lists:filter(fun(#calculation{result={error, _}}) -> false; (_) -> true end, History).